import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/core/services/notification_service.dart';
import 'package:taning/core/services/notification_scheduler.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';

final notificationServiceProvider = Provider<NotificationService>((ref) {
  return NotificationService();
});

final notificationSchedulerProvider = Provider<NotificationScheduler>((ref) {
  final notificationService = ref.watch(notificationServiceProvider);
  final countdownEngine = ref.watch(countdownEngineProvider);
  return NotificationScheduler(
    notificationService: notificationService,
    countdownEngine: countdownEngine,
  );
});

final pendingNotificationsProvider = FutureProvider<List<PendingNotificationRequest>>((ref) async {
  final service = ref.watch(notificationServiceProvider);
  return service.getPendingNotifications();
});