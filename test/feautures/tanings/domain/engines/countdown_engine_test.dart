import 'package:flutter_test/flutter_test.dart';
import 'package:taning/features/tanings/domain/entities/countdown_state.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';

void main() {
  late CountdownEngine engine;

  setUp(() {
    engine = const CountdownEngine();
  });

  group('CountdownEngine - Countdown Type', () {
    test('calculates remaining days correctly for all-day events', () {
      final now = DateTime(2026, 8, 10);
      final taning = Taning.create(
        title: 'Vacation',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24),
        isAllDay: true,
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.remainingDuration?.inDays, 14);
      expect(state.status, CountdownStatus.active);
      expect(state.formattedRemaining, '14d');
      expect(state.isOverdue, false);
    });

    test('calculates exact time remaining for timed events', () {
      final now = DateTime(2026, 8, 10, 10, 0);
      final taning = Taning.create(
        title: 'Exam',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 10, 14, 0),
        isAllDay: false,
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.remainingDuration?.inHours, 4);
      expect(state.status, CountdownStatus.lessThanDay);
      expect(state.formattedRemaining, '4h 0m');
    });

    test('detects less than hour status', () {
      final now = DateTime(2026, 8, 10, 13, 45);
      final taning = Taning.create(
        title: 'Meeting',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 10, 14, 0),
        isAllDay: false,
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.status, CountdownStatus.lessThanHour);
      expect(state.formattedRemaining, '15m 0s');
    });

    test('detects today status', () {
      final now = DateTime(2026, 8, 10, 9, 0);
      final taning = Taning.create(
        title: 'Event',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 10),
        isAllDay: true,
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.status, CountdownStatus.today);
    });

    test('detects overdue state', () {
      final now = DateTime(2026, 8, 25);
      final taning = Taning.create(
        title: 'Vacation',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.isOverdue, true);
      expect(state.status, CountdownStatus.overdue);
      expect(state.remainingDuration?.inDays.abs(), 1);
    });

    test('calculates progress percentage correctly', () {
      final now = DateTime(2026, 8, 17);
      final taning = Taning.create(
        title: 'Vacation',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24),
        createdAt: DateTime(2026, 8, 10),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.progressPercentage, closeTo(0.5, 0.01));
    });
  });

  group('CountdownEngine - Duration Type', () {
    test('calculates progress correctly for duration', () {
      final now = DateTime(2026, 8, 15);
      final taning = Taning.create(
        title: '30 Day Challenge',
        type: TaningType.duration,
        startDate: DateTime(2026, 8, 1),
        endDate: DateTime(2026, 8, 31),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.currentDay, 15);
      expect(state.totalDays, 31);
      expect(state.progressPercentage, closeTo(0.483, 0.01));
      expect(state.status, CountdownStatus.active);
    });

    test('detects upcoming duration', () {
      final now = DateTime(2026, 7, 31);
      final taning = Taning.create(
        title: '30 Day Challenge',
        type: TaningType.duration,
        startDate: DateTime(2026, 8, 1),
        endDate: DateTime(2026, 8, 31),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.status, CountdownStatus.upcoming);
      expect(state.currentDay, null);
    });

    test('detects ended duration', () {
      final now = DateTime(2026, 9, 1);
      final taning = Taning.create(
        title: '30 Day Challenge',
        type: TaningType.duration,
        startDate: DateTime(2026, 8, 1),
        endDate: DateTime(2026, 8, 31),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.status, CountdownStatus.ended);
      expect(state.progressPercentage, 1.0);
    });
  });

  group('CountdownEngine - CountUp Type', () {
    test('counts up correctly from start date', () {
      final now = DateTime(2026, 8, 15);
      final taning = Taning.create(
        title: 'Since I started',
        type: TaningType.countUp,
        startDate: DateTime(2026, 8, 1),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.elapsedDuration?.inDays, 14);
      expect(state.status, CountdownStatus.active);
      expect(state.formattedRemaining, '14d');
    });

    test('detects upcoming count-up', () {
      final now = DateTime(2026, 7, 31);
      final taning = Taning.create(
        title: 'Since I started',
        type: TaningType.countUp,
        startDate: DateTime(2026, 8, 1),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.status, CountdownStatus.upcoming);
    });
  });

  group('CountdownEngine - Recurring Type', () {
    test('calculates next occurrence for daily recurrence', () {
      final now = DateTime(2026, 8, 10);
      final taning = Taning.create(
        title: 'Daily Event',
        type: TaningType.recurring,
        recurrence: DailyRecurrence(interval: 1),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.targetDate, isNotNull);
      expect(state.remainingDuration?.inDays, 1);
    });

    test('calculates next occurrence for weekly recurrence', () {
      final now = DateTime(2026, 8, 10); // Monday
      final taning = Taning.create(
        title: 'Weekly Event',
        type: TaningType.recurring,
        recurrence: WeeklyRecurrence(weekdays: [3]), // Wednesday
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.targetDate, isNotNull);
      expect(state.targetDate?.weekday, 3);
      expect(state.remainingDuration?.inDays, 2);
    });
  });

  group('CountdownEngine - Edge Cases', () {
    test('handles leap year correctly', () {
      final now = DateTime(2024, 2, 28);
      final taning = Taning.create(
        title: 'Leap Year Event',
        type: TaningType.countdown,
        endDate: DateTime(2024, 3, 1),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.remainingDuration?.inDays, 2);
    });

    test('handles end of month correctly', () {
      final now = DateTime(2026, 1, 31);
      final taning = Taning.create(
        title: 'Month End',
        type: TaningType.countdown,
        endDate: DateTime(2026, 2, 1),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.remainingDuration?.inDays, 1);
    });

    test('handles year boundary correctly', () {
      final now = DateTime(2026, 12, 31);
      final taning = Taning.create(
        title: 'New Year',
        type: TaningType.countdown,
        endDate: DateTime(2027, 1, 1),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.remainingDuration?.inDays, 1);
    });

    test('handles zero duration gracefully', () {
      final now = DateTime(2026, 8, 10);
      final taning = Taning.create(
        title: 'Zero Duration',
        type: TaningType.duration,
        startDate: DateTime(2026, 8, 10),
        endDate: DateTime(2026, 8, 10),
      );

      final state = engine.calculate(now: now, taning: taning);

      expect(state.progressPercentage, 0.0);
      expect(state.status, CountdownStatus.active);
    });
  });
}