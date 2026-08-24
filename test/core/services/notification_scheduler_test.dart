import 'package:flutter_test/flutter_test.dart';
import 'package:taning/core/services/notification_scheduler.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

void main() {
  group('NotificationScheduler', () {
    test('calculates correct notification times for countdown', () {
      final scheduler = NotificationScheduler();
      final taning = Taning.create(
        title: 'Test',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24, 10, 0),
        notificationSettings: NotificationSettings(
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
      final times = scheduler.calculateNotificationTimes(taning);

      expect(times.length, 7);
      expect(times.any((t) => t.type == NotificationType.oneDayBefore), true);
      expect(times.any((t) => t.type == NotificationType.threeDaysBefore), true);
      expect(times.any((t) => t.type == NotificationType.sevenDaysBefore), true);
      expect(times.any((t) => t.type == NotificationType.oneHourBefore), true);
      expect(times.any((t) => t.type == NotificationType.thirtyMinutesBefore), true);
      expect(times.any((t) => t.type == NotificationType.exactTime), true);
    });

    test('returns empty list when notifications disabled', () {
      final scheduler = NotificationScheduler();
      final taning = Taning.create(
        title: 'Test',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24),
        notificationSettings: NotificationSettings(
          enabled: false,
          oneDayBefore: false,
          threeDaysBefore: false,
          sevenDaysBefore: false,
          oneHourBefore: false,
          thirtyMinutesBefore: false,
          atExactTime: false,
        ),
      );

      final times = scheduler.calculateNotificationTimes(taning);

      expect(times.isEmpty, true);
    });

    test('calculates progress notifications for duration', () {
      final scheduler = NotificationScheduler();
      final taning = Taning.create(
        title: '30 Day Challenge',
        type: TaningType.duration,
        startDate: DateTime(2026, 8, 1),
        endDate: DateTime(2026, 8, 31),
        notificationSettings: NotificationSettings(
          enabled: true,
          oneDayBefore: false,
          threeDaysBefore: false,
          sevenDaysBefore: false,
          oneHourBefore: false,
          thirtyMinutesBefore: false,
          atExactTime: false,
        ),
      );

      final times = scheduler.calculateNotificationTimes(taning);

      expect(times.any((t) => t.type == NotificationType.progress), true);
    });
  });
}