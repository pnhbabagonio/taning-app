import 'package:flutter_test/flutter_test.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

void main() {
  late CountdownEngine engine;
  
  setUp(() {
    engine = const CountdownEngine();
  });
  
  group('CountdownEngine - Countdown Type', () {
    test('calculates remaining days correctly', () {
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
    
    test('handles exact time countdown', () {
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
    });
  });
  
  group('CountdownEngine - Duration Type', () {
    test('calculates progress correctly', () {
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
    
    test('detects completion', () {
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
    test('counts up correctly', () {
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
  });
}