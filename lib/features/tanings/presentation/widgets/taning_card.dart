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

const double _kCardHeight = 180.0;

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
    // FIX: Use Text with font instead of IconData
    final iconCode = String.fromCharCode(widget.taning.icon.codePoint);
    final iconFamily = widget.taning.icon.family ?? 'MaterialIcons';

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: SizedBox(
        height: _kCardHeight,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _buildCardContent(iconCode, iconFamily),
        ),
      ),
    );
  }

  Widget _buildCardContent(String iconCode, String iconFamily) {
    switch (widget.variant) {
      case TaningCardVariant.standard:
        return _StandardCard(
          taning: widget.taning,
          state: _currentState,
          iconCode: iconCode,
          iconFamily: iconFamily,
        );
      case TaningCardVariant.compact:
        return _CompactCard(
          taning: widget.taning,
          state: _currentState,
          iconCode: iconCode,
          iconFamily: iconFamily,
        );
      case TaningCardVariant.focus:
        return _FocusCard(
          taning: widget.taning,
          state: _currentState,
          iconCode: iconCode,
          iconFamily: iconFamily,
        );
      case TaningCardVariant.mini:
        return _MiniCard(
          taning: widget.taning,
          state: _currentState,
          iconCode: iconCode,
          iconFamily: iconFamily,
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
class _StandardCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final String iconCode;
  final String iconFamily;

  const _StandardCard({
    required this.taning,
    required this.state,
    required this.iconCode,
    required this.iconFamily,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFinished = state.isFinished || state.isOverdue;
    final accentColor = ref.watch(accentColorProvider);

    return Container(
      height: _kCardHeight - 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Header
          SizedBox(
            height: 32,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    iconCode,
                    style: TextStyle(
                      fontFamily: iconFamily,
                      fontSize: 18,
                      color: accentColor,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    taning.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (taning.isPinned)
                  Icon(Icons.push_pin,
                      size: 14, color: accentColor.withValues(alpha: 0.6)),
                if (isFinished)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: state.isOverdue
                          ? Colors.red.withValues(alpha: 0.1)
                          : Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      state.isOverdue ? 'Overdue' : 'Done',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: state.isOverdue
                            ? Colors.red.shade700
                            : Colors.green.shade700,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Countdown Display
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CountdownDisplay(
                    duration: state.remainingDuration ?? Duration.zero,
                    style: taning.countdownStyle,
                    isOverdue: state.isOverdue,
                    isFinished: state.isFinished ||
                        state.status == CountdownStatus.ended,
                  ),
                ),
                if (state.progressPercentage != null &&
                    state.progressPercentage! > 0)
                  SizedBox(
                    width: 36,
                    height: 36,
                    child: CircularProgressIndicator(
                      value: state.progressPercentage,
                      strokeWidth: 3,
                      backgroundColor: accentColor.withValues(alpha: 0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                    ),
                  ),
              ],
            ),
          ),

          // Footer
          if (state.targetDate != null)
            SizedBox(
              height: 20,
              child: Row(
                children: [
                  Icon(Icons.calendar_today,
                      size: 12, color: accentColor.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  Text(
                    CountdownFormatter.formatDate(state.targetDate!),
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color
                          ?.withValues(alpha: 0.6),
                    ),
                  ),
                  const Spacer(),
                  if (taning.type == TaningType.duration &&
                      state.currentDay != null)
                    Text(
                      'Day ${state.currentDay} of ${state.totalDays}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: accentColor.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// MARK: - Compact Card
class _CompactCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final String iconCode;
  final String iconFamily;

  const _CompactCard({
    required this.taning,
    required this.state,
    required this.iconCode,
    required this.iconFamily,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              iconCode,
              style: TextStyle(
                fontFamily: iconFamily,
                fontSize: 18,
                color: accentColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              taning.title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (state.status == CountdownStatus.overdue)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Overdue',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else if (state.isFinished || state.status == CountdownStatus.ended)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Done',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            CountdownDisplay(
              duration: state.remainingDuration ?? Duration.zero,
              style: CountdownStyle.simple,
            ),
          const SizedBox(width: 8),
          if (state.progressPercentage != null)
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                value: state.progressPercentage,
                strokeWidth: 2,
                backgroundColor: accentColor.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              ),
            ),
        ],
      ),
    );
  }
}

// MARK: - Focus Card
class _FocusCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final String iconCode;
  final String iconFamily;

  const _FocusCard({
    required this.taning,
    required this.state,
    required this.iconCode,
    required this.iconFamily,
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Text(
                iconCode,
                style: TextStyle(
                  fontFamily: iconFamily,
                  fontSize: 40,
                  color: accentColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              taning.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyLarge?.color,
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 28),
            CountdownDisplay(
              duration: state.remainingDuration ?? Duration.zero,
              style: CountdownStyle.full,
              isOverdue: state.isOverdue,
              isFinished:
                  state.isFinished || state.status == CountdownStatus.ended,
            ),
            if (state.targetDate != null) ...[
              const SizedBox(height: 12),
              Text(
                CountdownFormatter.formatDate(state.targetDate!),
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.color
                      ?.withValues(alpha: 0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (state.progressPercentage != null) ...[
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: state.progressPercentage,
                  backgroundColor: accentColor.withValues(alpha: 0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(accentColor),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${(state.progressPercentage! * 100).toStringAsFixed(0)}% Complete',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: accentColor.withValues(alpha: 0.8),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// MARK: - Mini Card
class _MiniCard extends ConsumerWidget {
  final Taning taning;
  final CountdownState state;
  final String iconCode;
  final String iconFamily;

  const _MiniCard({
    required this.taning,
    required this.state,
    required this.iconCode,
    required this.iconFamily,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accentColor = ref.watch(accentColorProvider);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            iconCode,
            style: TextStyle(
              fontFamily: iconFamily,
              fontSize: 22,
              color: accentColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            taning.title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          if (!state.isFinished && state.status != CountdownStatus.ended)
            CountdownDisplay(
              duration: state.remainingDuration ?? Duration.zero,
              style: CountdownStyle.simple,
            ),
          if (state.isFinished || state.status == CountdownStatus.ended)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: state.isOverdue
                    ? Colors.red.withValues(alpha: 0.1)
                    : Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                state.isOverdue ? 'Overdue' : 'Done',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: state.isOverdue ? Colors.red : Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }
}