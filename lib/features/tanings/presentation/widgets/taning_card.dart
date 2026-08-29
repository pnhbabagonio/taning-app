// ignore_for_file: non_const_argument_for_const_parameter

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/core/utils/countdown_formatter.dart';
import 'package:taning/features/tanings/domain/entities/countdown_state.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/shared/widgets/countdown_display.dart';
import 'package:taning/features/settings/presentation/providers/settings_providers.dart';

class TaningCard extends ConsumerStatefulWidget {
  final Taning taning;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final TaningCardVariant variant;

  const TaningCard({
    super.key,
    required this.taning,
    this.onTap,
    this.onLongPress,
    this.variant = TaningCardVariant.standard,
  });

  @override
  ConsumerState<TaningCard> createState() => _TaningCardState();
}

class _TaningCardState extends ConsumerState<TaningCard> {
  late final Ticker _ticker;
  CountdownState _currentState = const CountdownState(
    status: CountdownStatus.active,
    formattedRemaining: '',
    isOverdue: false,
  );
  DateTime _lastUpdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _updateState();
    _ticker = Ticker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    final now = DateTime.now();
    if (now.difference(_lastUpdate) >= _getUpdateInterval()) {
      _updateState();
      _lastUpdate = now;
    }
  }

  Duration _getUpdateInterval() {
    final style = widget.taning.countdownStyle;
    switch (style) {
      case CountdownStyle.simple:
      case CountdownStyle.calendar:
        return const Duration(minutes: 1);
      case CountdownStyle.detailed:
        return const Duration(seconds: 10);
      case CountdownStyle.full:
        return const Duration(seconds: 1);
      default:
        return const Duration(seconds: 1);
    }
  }

  void _updateState() {
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

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: _buildCardContent(color, icon),
      ),
    );
  }

  Widget _buildCardContent(Color color, IconData icon) {
    switch (widget.variant) {
      case TaningCardVariant.standard:
        return _StandardCard(
          taning: widget.taning,
          state: _currentState,
          color: color,
          icon: icon,
        );
      case TaningCardVariant.compact:
        return _CompactCard(
          taning: widget.taning,
          state: _currentState,
          color: color,
          icon: icon,
        );
      case TaningCardVariant.focus:
        return _FocusCard(
          taning: widget.taning,
          state: _currentState,
          color: color,
          icon: icon,
        );
      case TaningCardVariant.mini:
        return _MiniCard(
          taning: widget.taning,
          state: _currentState,
          color: color,
          icon: icon,
        );
    }
  }
}

enum TaningCardVariant {
  standard,
  compact,
  focus,
  mini,
}

// MARK: - Standard Card

// Update _StandardCard - make it a ConsumerWidget
class _StandardCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final Color color;
  final IconData icon;

  const _StandardCard({
    required this.taning,
    required this.state,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFinished = state.isFinished || state.isOverdue;
    final accentColor = ref.watch(accentColorProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  taning.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (taning.isPinned)
                const Icon(Icons.push_pin, size: 16, color: Colors.grey),
              if (isFinished)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: state.isOverdue
                        ? Colors.red.shade100
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.isOverdue ? 'Overdue' : 'Done',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: state.isOverdue
                          ? Colors.red.shade800
                          : Colors.green.shade800,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Countdown Display
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CountdownDisplay(
                  duration: state.remainingDuration ?? Duration.zero,
                  style: taning.countdownStyle,
                  // taningColor is now optional, accentColor will be used
                  isOverdue: state.isOverdue,
                  isFinished: state.isFinished || state.status == CountdownStatus.ended,
                ),
              ),
              if (state.progressPercentage != null &&
                  state.progressPercentage! > 0)
                _buildProgressIndicator(accentColor),
            ],
          ),

          const SizedBox(height: 12),

          // Target Date
          if (state.targetDate != null)
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  CountdownFormatter.formatDate(state.targetDate!),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Spacer(),
                if (taning.type == TaningType.duration &&
                    state.currentDay != null)
                  Text(
                    'Day ${state.currentDay} of ${state.totalDays}',
                    style: TextStyle(
                      fontSize: 12,
                      color: accentColor.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(Color accentColor) {
    final progress = state.progressPercentage ?? 0;
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: 3,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(accentColor),
      ),
    );
  }
}

// Similarly update _CompactCard
class _CompactCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final Color color;
  final IconData icon;

  const _CompactCard({
    required this.taning,
    required this.state,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              taning.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (state.status == CountdownStatus.overdue)
            const Text(
              'Overdue',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
          else if (state.isFinished || state.status == CountdownStatus.ended)
            const Text(
              'Done',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            CountdownDisplay(
              duration: state.remainingDuration ?? Duration.zero,
              style: CountdownStyle.simple,
              // No taningColor needed, uses accentColor
            ),
          const SizedBox(width: 8),
          if (state.progressPercentage != null)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                value: state.progressPercentage,
                strokeWidth: 2,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              ),
            ),
        ],
      ),
    );
  }
}

// Update _FocusCard
class _FocusCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final Color color;
  final IconData icon;

  const _FocusCard({
    required this.taning,
    required this.state,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              taning.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 24),
            CountdownDisplay(
              duration: state.remainingDuration ?? Duration.zero,
              style: CountdownStyle.full,
              isOverdue: state.isOverdue,
              isFinished:
                  state.isFinished || state.status == CountdownStatus.ended,
            ),
            if (state.targetDate != null) ...[
              const SizedBox(height: 8),
              Text(
                CountdownFormatter.formatDate(state.targetDate!),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
            if (state.progressPercentage != null) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: state.progressPercentage,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                minHeight: 4,
              ),
              const SizedBox(height: 8),
              Text(
                '${(state.progressPercentage! * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Mini Card remains similar
class _MiniCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final Color color;
  final IconData icon;

  const _MiniCard({
    required this.taning,
    required this.state,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            taning.title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (!state.isFinished && state.status != CountdownStatus.ended)
            CountdownDisplay(
              duration: state.remainingDuration ?? Duration.zero,
              style: CountdownStyle.simple,
            ),
          if (state.isFinished || state.status == CountdownStatus.ended)
            Text(
              state.isOverdue ? 'Overdue' : 'Done',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
        ],
      ),
    );
  }
}