import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taning/core/utils/countdown_formatter.dart';
import 'package:taning/features/tanings/domain/entities/countdown_state.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/features/tanings/presentation/screens/edit_screen.dart';
import 'package:taning/features/tanings/presentation/widgets/progress_indicators.dart';
import 'package:taning/core/services/share_service.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  CountdownState _currentState = const CountdownState(
    status: CountdownStatus.active,
    formattedRemaining: '',
    isOverdue: false,
  );
  bool _isFullscreen = false;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    _updateState();
  }

  void _updateState() {
    final taning = ref.read(taningProvider(widget.id)).value;
    if (taning == null) return;

    final engine = ref.read(countdownEngineProvider);
    final state = engine.calculate(
      now: DateTime.now(),
      taning: taning,
    );

    if (!mounted) return;
    setState(() {
      _currentState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taningAsync = ref.watch(taningProvider(widget.id));

    return taningAsync.when(
      data: (taning) {
        if (taning == null) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Taning not found',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          );
        }

        return _isFullscreen
            ? _FullscreenCountdown(
                taning: taning,
                state: _currentState,
                onExit: () => setState(() => _isFullscreen = false),
              )
            : _DetailContent(
                taning: taning,
                state: _currentState,
                onFullscreen: () => setState(() => _isFullscreen = true),
                onEdit: () => _navigateToEdit(taning),
                onDelete: () => _deleteTaning(taning.id),
                onArchive: () => _archiveTaning(taning.id),
                onComplete: () => _completeTaning(taning.id),
              );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error loading Taning',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: const TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  ref.invalidate(taningProvider(widget.id));
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEdit(Taning taning) {
    context.push('/edit', extra: {'taning': taning});
  }

  void _deleteTaning(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Delete Taning?'),
        content: const Text(
          'This action cannot be undone. All progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(tandingRepositoryProvider).delete(id);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Taning deleted'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _archiveTaning(String id) async {
    await ref.read(tandingRepositoryProvider).archive(id);
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Taning archived'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _completeTaning(String id) async {
    await ref.read(tandingRepositoryProvider).markCompleted(id);
    if (mounted) {
      ref.invalidate(taningProvider(id));
      _updateState();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🎉 Taning completed!'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}

// MARK: - Detail Content (Simplified for brevity - keep your existing code)

class _DetailContent extends StatelessWidget {
  final Taning taning;
  final CountdownState state;
  final VoidCallback onFullscreen;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onArchive;
  final VoidCallback onComplete;

  const _DetailContent({
    required this.taning,
    required this.state,
    required this.onFullscreen,
    required this.onEdit,
    required this.onDelete,
    required this.onArchive,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    // ... keep your existing code ...
    return Scaffold(
      body: const Center(
        child: Text('Detail Content - Keep your existing code here'),
      ),
    );
  }

  void _shareTaning(BuildContext context) {
    ShareService.shareTaning(context, taning);
  }
}

// MARK: - Fullscreen Countdown (Simplified - keep your existing code)

class _FullscreenCountdown extends ConsumerStatefulWidget {
  final Taning taning;
  final CountdownState state;
  final VoidCallback onExit;

  const _FullscreenCountdown({
    required this.taning,
    required this.state,
    required this.onExit,
  });

  @override
  ConsumerState<_FullscreenCountdown> createState() => _FullscreenCountdownState();
}

class _FullscreenCountdownState extends ConsumerState<_FullscreenCountdown> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  CountdownState _currentState = const CountdownState(
    status: CountdownStatus.active,
    formattedRemaining: '',
    isOverdue: false,
  );

  @override
  void initState() {
    super.initState();
    _currentState = widget.state;
    _ticker = Ticker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final engine = ref.read(countdownEngineProvider);
    final state = engine.calculate(
      now: DateTime.now(),
      taning: widget.taning,
    );

    if (!mounted) return;
    setState(() {
      _currentState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.taning.color.toColor();
    final icon = IconData(
      widget.taning.icon.codePoint,
      fontFamily: widget.taning.icon.family ?? 'MaterialIcons',
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: widget.onExit,
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Exit hint
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.tap, color: Colors.white54, size: 16),
                    SizedBox(width: 8),
                    Text(
                      'Tap to exit',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 48),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                widget.taning.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Main countdown
              if (_currentState.isFinished && !_currentState.isOverdue)
                const Text(
                  '✨ Completed!',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                  ),
                )
              else if (_currentState.isOverdue)
                Column(
                  children: [
                    Text(
                      '${_currentState.remainingDuration?.inDays.abs() ?? 0} days overdue',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 56,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Time has passed',
                      style: TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                  ],
                )
              else if (widget.taning.type == TaningType.duration &&
                  _currentState.currentDay != null &&
                  _currentState.totalDays != null)
                Column(
                  children: [
                    Text(
                      'Day ${_currentState.currentDay}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'of ${_currentState.totalDays}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Text(
                      _currentState.formattedRemaining,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 72,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_currentState.targetDate != null)
                      Text(
                        CountdownFormatter.formatDate(
                            _currentState.targetDate!),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                  ],
                ),
              const Spacer(),
              // Progress
              if (_currentState.progressPercentage != null &&
                  !_currentState.isFinished &&
                  !_currentState.isOverdue)
                Container(
                  width: 200,
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: _currentState.progressPercentage,
                        backgroundColor: Colors.grey.shade800,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 4,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(_currentState.progressPercentage! * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 32),
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: widget.onExit,
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: const Text('Exit',
                        style: TextStyle(color: Colors.white)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white54),
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (!_currentState.isFinished && !_currentState.isOverdue)
                    OutlinedButton.icon(
                      onPressed: () {
                        // TODO: Share
                      },
                      icon: const Icon(Icons.share, color: Colors.white),
                      label: const Text('Share',
                          style: TextStyle(color: Colors.white)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white54),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
