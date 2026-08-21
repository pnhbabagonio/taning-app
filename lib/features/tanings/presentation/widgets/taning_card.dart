import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/core/utils/countdown_formatter.dart';
import 'package:taning/features/tanings/domain/entities/countdown_state.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/features/tanings/presentation/widgets/progress_indicator.dart';

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
  CountdownState _currentState = CountdownState(
    status: CountdownStatus.active,
    formattedRemaining: '',
    isOverdue: false,
  );

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
    _updateState();
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

class _StandardCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final isFinished = state.isFinished || state.isOverdue;
    final isUpcoming = state.isUpcoming;
    final isActive = state.isActive;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon + Title + Status
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  taning.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
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
                    color: state.isOverdue ? Colors.red.shade100 : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.isOverdue ? 'Overdue' : 'Done',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: state.isOverdue ? Colors.red.shade800 : Colors.green.shade800,
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
                child: _buildCountdownDisplay(),
              ),
              if (state.progressPercentage != null && state.progressPercentage! > 0)
                _buildProgressIndicator(),
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
                if (taning.type == TaningType.duration && state.currentDay != null)
                  Text(
                    'Day ${state.currentDay} of ${state.totalDays}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildCountdownDisplay() {
    if (state.status == CountdownStatus.overdue) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${state.remainingDuration?.inDays.abs() ?? 0} days overdue',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
          const Text(
            'Time has passed',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      );
    }

    if (state.status == CountdownStatus.completed || 
        state.status == CountdownStatus.ended) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '✅ Completed',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.green,
            ),
          ),
          const Text(
            'Your taning has arrived!',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      );
    }

    final displayText = state.formattedRemaining;
    final unit = _getTimeUnit(displayText);
    final number = displayText.replaceAll(RegExp(r'[^0-9]'), '');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number.isNotEmpty ? number : displayText,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.0,
          ),
        ),
        Text(
          unit.isNotEmpty ? unit : _getFallbackUnit(state),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  String _getTimeUnit(String displayText) {
    if (displayText.contains('d')) return 'days';
    if (displayText.contains('h')) return 'hours';
    if (displayText.contains('m')) return 'minutes';
    if (displayText.contains('s')) return 'seconds';
    return '';
  }

  String _getFallbackUnit(CountdownState state) {
    if (state.remainingDuration != null) {
      final d = state.remainingDuration!;
      if (d.inDays > 0) return 'days';
      if (d.inHours > 0) return 'hours';
      if (d.inMinutes > 0) return 'minutes';
      return 'seconds';
    }
    return '';
  }

  Widget _buildProgressIndicator() {
    final progress = state.progressPercentage ?? 0;
    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: 3,
        backgroundColor: Colors.grey.shade200,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}

// MARK: - Compact Card

class _CompactCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: color, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              taning.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
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
          else if (state.isFinished)
            const Text(
              'Done',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            Text(
              state.formattedRemaining,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
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
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
        ],
      ),
    );
  }
}

// MARK: - Focus Card

class _FocusCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 32),
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
          Text(
            state.formattedRemaining,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
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
              valueColor: AlwaysStoppedAnimation<Color>(color),
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
    );
  }
}

// MARK: - Mini Card (for grids)

class _MiniCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.2),
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
          if (!state.isFinished)
            Text(
              state.formattedRemaining,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          if (state.isFinished)
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