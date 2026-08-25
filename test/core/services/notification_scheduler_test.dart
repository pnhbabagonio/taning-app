import 'package:flutter_test/flutter_test.dart';
import 'package:taning/core/services/notification_scheduler.dart' as scheduler;
import 'package:taning/features/tanings/domain/entities/taning.dart';

void main() {
  group('NotificationScheduler', () {
    test('calculates correct notification times for countdown', () {
      final notificationScheduler = scheduler.NotificationScheduler();
      final taning = Taning.create(
        title: 'Test',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24, 10, 0),
        notificationSettings: const NotificationSettings(
          enabled: true,
          oneDayBefore: true,
          threeDaysBefore: true,
          sevenDaysBefore: true,
          oneHourBefore: true,
          thirtyMinutesBefore: true,
          atExactTime: true,
        ),
      );

      // Use reflection to test private method
      // or make it public for testing
      final times = notificationScheduler.calculateNotificationTimes(taning);

      expect(times.length, 7);
      expect(times.any((t) => t.type == scheduler.NotificationType.oneDayBefore), true);
      expect(times.any((t) => t.type == scheduler.NotificationType.threeDaysBefore), true);
      expect(times.any((t) => t.type == scheduler.NotificationType.sevenDaysBefore), true);
      expect(times.any((t) => t.type == scheduler.NotificationType.oneHourBefore), true);
      expect(times.any((t) => t.type == scheduler.NotificationType.thirtyMinutesBefore), true);
      expect(times.any((t) => t.type == scheduler.NotificationType.exactTime), true);
    });

    test('returns empty list when notifications disabled', () {
      final notificationScheduler = scheduler.NotificationScheduler();
      final taning = Taning.create(
        title: 'Test',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24),
        notificationSettings: const NotificationSettings(
          enabled: false,
          oneDayBefore: false,
          threeDaysBefore: false,
          sevenDaysBefore: false,
          oneHourBefore: false,
          thirtyMinutesBefore: false,
          atExactTime: false,
        ),
      );

      final times = notificationScheduler.calculateNotificationTimes(taning);

      expect(times.isEmpty, true);
    });

    test('calculates progress notifications for duration', () {
      final notificationScheduler = scheduler.NotificationScheduler();
      final taning = Taning.create(
        title: '30 Day Challenge',
        type: TaningType.duration,
        startDate: DateTime(2026, 8, 1),
        endDate: DateTime(2026, 8, 31),
        notificationSettings: const NotificationSettings(
          enabled: true,
          oneDayBefore: false,
          threeDaysBefore: false,
          sevenDaysBefore: false,
          oneHourBefore: false,
          thirtyMinutesBefore: false,
          atExactTime: false,
        ),
      );

      final times = notificationScheduler.calculateNotificationTimes(taning);

      expect(times.any((t) => t.type == scheduler.NotificationType.progress), true);
    });
  });
}