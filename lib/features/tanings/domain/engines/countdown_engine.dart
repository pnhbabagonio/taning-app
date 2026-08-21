import 'package:taning/features/tanings/domain/entities/countdown_state.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

class CountdownEngine {
  const CountdownEngine();

  CountdownState calculate({required DateTime now, required Taning taning}) {
    final start = taning.startDate;
    final end = taning.endDate;

    if (taning.type == TaningType.countUp && start != null) {
      final elapsed = now.difference(start);
      return CountdownState(
        status: CountdownStatus.active,
        elapsedDuration: elapsed,
        formattedRemaining: _format(elapsed),
        isOverdue: false,
      );
    }

    if (taning.type == TaningType.duration && start != null && end != null) {
      final total = end.difference(start);
      final elapsed = now.difference(start);
      final progress = total.inSeconds == 0
          ? 1.0
          : (elapsed.inSeconds / total.inSeconds).clamp(0.0, 1.0);
      return CountdownState(
        status: now.isBefore(start)
            ? CountdownStatus.upcoming
            : now.isAfter(end)
                ? CountdownStatus.ended
                : CountdownStatus.active,
        totalDuration: total,
        elapsedDuration: elapsed,
        progressPercentage: progress,
        currentDay: elapsed.inDays + 1,
        totalDays: total.inDays + 1,
        formattedRemaining: _format(end.difference(now).isNegative
            ? Duration.zero
            : end.difference(now)),
        targetDate: end,
        isOverdue: now.isAfter(end),
      );
    }

    if (end != null) {
      final remaining = end.difference(now);
      final overdue = remaining.isNegative;
      final absolute = overdue ? remaining.abs() : remaining;
      final status = overdue
          ? CountdownStatus.overdue
          : absolute.inHours < 1
              ? CountdownStatus.lessThanHour
              : absolute.inHours < 24
                  ? CountdownStatus.lessThanDay
                  : CountdownStatus.active;
      return CountdownState(
        status: status,
        remainingDuration: remaining,
        formattedRemaining: _format(absolute),
        targetDate: end,
        isOverdue: overdue,
      );
    }

    return const CountdownState(
      status: CountdownStatus.upcoming,
      formattedRemaining: '',
      isOverdue: false,
    );
  }

  String _format(Duration duration) {
    if (duration.inDays > 0) return '${duration.inDays}d';
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
    }
    return '${duration.inMinutes}m';
  }
}
