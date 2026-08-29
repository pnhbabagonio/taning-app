// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taning/core/utils/countdown_formatter.dart';
import 'package:taning/core/services/share_service.dart';
import 'package:taning/features/tanings/domain/entities/countdown_state.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/features/tanings/presentation/widgets/progress_indicators.dart';
import 'package:taning/features/notifications/presentation/screens/notification_settings_screen.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen>
    with SingleTickerProviderStateMixin {
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
    _updateState();
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
    final taningAsync = ref.read(taningProvider(widget.id));
    final taning = taningAsync.value;
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
                onNotificationSettings: () => _openNotificationSettings(taning),
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
      await ref.read(taningRepositoryProvider).delete(id);
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
    await ref.read(taningRepositoryProvider).archive(id);
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
    await ref.read(taningRepositoryProvider).markCompleted(id);
    if (mounted) {
      ref.invalidate(taningProvider(id));
      _updateState();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🎉 Taning completed!'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _openNotificationSettings(Taning taning) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationSettingsScreen(taningId: taning.id),
      ),
    );
  }
}

// MARK: - Detail Content

class _DetailContent extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final VoidCallback onFullscreen;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onArchive;
  final VoidCallback onComplete;
  final VoidCallback onNotificationSettings;

  const _DetailContent({
    required this.taning,
    required this.state,
    required this.onFullscreen,
    required this.onEdit,
    required this.onDelete,
    required this.onArchive,
    required this.onComplete,
    required this.onNotificationSettings,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = taning.color.toColor();
    final icon = IconData(
      taning.icon.codePoint,
      fontFamily: taning.icon.family ?? 'MaterialIcons',
    );
    final accentColor = ref.watch(accentColorProvider);

    return Scaffold(
      appBar: _buildAppBar(context, color, accentColor),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildCountdownDisplay(color, icon),
            const SizedBox(height: 32),
            _buildProgressSection(color),
            const SizedBox(height: 32),
            _buildInformationSection(),
            const SizedBox(height: 32),
            _buildActionButtons(context, accentColor),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Color color, Color accentColor) {
    return AppBar(
      title: Text(
        taning.title,
        style: const TextStyle(fontSize: 18),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.fullscreen),
          onPressed: onFullscreen,
          tooltip: 'Fullscreen',
          color: accentColor,
        ),
        IconButton(
          icon: const Icon(Icons.share_outlined),
          onPressed: () => _shareTaning(context),
          tooltip: 'Share',
          color: accentColor,
        ),
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: accentColor),
          onSelected: (value) {
            switch (value) {
              case 'edit':
                onEdit();
                break;
              case 'archive':
                onArchive();
                break;
              case 'complete':
                onComplete();
                break;
              case 'delete':
                onDelete();
                break;
              case 'notifications':
                onNotificationSettings();
                break;
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit_outlined),
                  SizedBox(width: 12),
                  Text('Edit'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'archive',
              child: Row(
                children: [
                  Icon(Icons.archive_outlined),
                  SizedBox(width: 12),
                  Text('Archive'),
                ],
              ),
            ),
            if (!taning.isCompleted)
              const PopupMenuItem(
                value: 'complete',
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline),
                    SizedBox(width: 12),
                    Text('Mark Complete'),
                  ],
                ),
              ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete_outline, color: Colors.red),
                  SizedBox(width: 12),
                  Text('Delete', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'notifications',
              child: Row(
                children: [
                  Icon(Icons.notifications_outlined),
                  SizedBox(width: 12),
                  Text('Notifications'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCountdownDisplay(Color color, IconData icon) {
    final isFinished = state.isFinished || state.isOverdue;
    final isOverdue = state.isOverdue;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.1),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 40),
          ),
          const SizedBox(height: 16),
          Text(
            taning.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (isFinished && !isOverdue)
            const Text(
              '✨ Completed!',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: Colors.green,
              ),
            )
          else if (isOverdue)
            Column(
              children: [
                Text(
                  '${state.remainingDuration?.inDays.abs() ?? 0} days overdue',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Time has passed',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            )
          else if (state.status == CountdownStatus.today)
            const Text(
              '🎉 Today!',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
              ),
            )
          else if (taning.type == TaningType.duration &&
              state.currentDay != null &&
              state.totalDays != null)
            Column(
              children: [
                Text(
                  'Day ${state.currentDay}',
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'of ${state.totalDays}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Text(
                  _getMainDisplayText(),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getUnitText(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          if (state.statusMessage != null && !isFinished)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.statusEmoji ?? '⏳',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    state.statusMessage!,
                    style: TextStyle(
                      fontSize: 14,
                      color: color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          if (state.targetDate != null && !isFinished)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                CountdownFormatter.formatDate(
                  state.targetDate!,
                  includeTime: !(taning.isAllDay ?? false),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getMainDisplayText() {
    final display = state.formattedRemaining;
    if (display.isEmpty) return '0s';

    final numbers = RegExp(r'\d+').allMatches(display);
    if (numbers.isNotEmpty) {
      return numbers.first.group(0) ?? display;
    }
    return display;
  }

  String _getUnitText() {
    final display = state.formattedRemaining;
    if (display.isEmpty) return 'seconds';

    if (display.contains('d')) return 'days';
    if (display.contains('h')) return 'hours';
    if (display.contains('m')) return 'minutes';
    if (display.contains('s')) return 'seconds';
    return '';
  }

  Widget _buildProgressSection(Color color) {
    if (state.progressPercentage == null) return const SizedBox.shrink();

    final progress = state.progressPercentage!;
    final isFinished = state.isFinished || state.isOverdue;

    if (isFinished) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progress',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(progress * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressBar(
            progress: progress,
            color: color,
            height: 8,
          ),
          if (taning.type == TaningType.duration &&
              state.currentDay != null &&
              state.totalDays != null)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Day ${state.currentDay} of ${state.totalDays}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildInformationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            'Type',
            _getTypeLabel(taning.type),
            Icons.label_outline,
          ),
          const Divider(),
          _buildInfoRow(
            'Created',
            CountdownFormatter.formatDate(taning.createdAt),
            Icons.calendar_today_outlined,
          ),
          if (taning.updatedAt != null) ...[
            const Divider(),
            _buildInfoRow(
              'Last modified',
              CountdownFormatter.formatDate(taning.updatedAt!),
              Icons.edit_outlined,
            ),
          ],
          if (taning.isCompleted && taning.completedAt != null) ...[
            const Divider(),
            _buildInfoRow(
              'Completed',
              CountdownFormatter.formatDate(taning.completedAt!),
              Icons.check_circle_outline,
            ),
          ],
          if (taning.isPinned) ...[
            const Divider(),
            _buildInfoRow(
              'Status',
              'Pinned',
              Icons.push_pin_outlined,
            ),
          ],
          if (taning.isArchived) ...[
            const Divider(),
            _buildInfoRow(
              'Status',
              'Archived',
              Icons.archive_outlined,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _getTypeLabel(TaningType type) {
    switch (type) {
      case TaningType.countdown:
        return 'Countdown';
      case TaningType.duration:
        return 'Duration';
      case TaningType.countUp:
        return 'Count Up';
      case TaningType.recurring:
        return 'Recurring';
    }
  }

  Widget _buildActionButtons(BuildContext context, Color accentColor) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit'),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: accentColor),
              foregroundColor: accentColor,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onFullscreen,
            icon: const Icon(Icons.fullscreen),
            label: const Text('Fullscreen'),
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _shareTaning(BuildContext context) {
    ShareService.shareTaning(context, taning);
  }
}

// MARK: - Fullscreen Countdown

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
  ConsumerState<_FullscreenCountdown> createState() =>
      _FullscreenCountdownState();
}

class _FullscreenCountdownState extends ConsumerState<_FullscreenCountdown>
    with SingleTickerProviderStateMixin {
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
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.touch_app, color: Colors.white54, size: 16),
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
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 48),
              ),
              const SizedBox(height: 24),
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
                SizedBox(
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
                        ShareService.shareTaning(context, widget.taning);
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
