import 'package:workmanager/workmanager.dart';
import 'package:taning/core/services/logger.dart';

class BackgroundService {
  static const String taskName = 'taning_sync_notifications';
  static const String uniqueName = 'taning_background_service';

  static Future<void> initialize() async {
    try {
      await Workmanager().initialize(
        callbackDispatcher,
      );
      LoggerService.info('Background service initialized');
    } catch (e) {
      LoggerService.error('Failed to initialize background service: $e');
    }
  }

  static Future<void> registerPeriodicTask() async {
    try {
      await Workmanager().registerPeriodicTask(
        uniqueName,
        taskName,
        // Run every 6 hours minimum
        frequency: const Duration(hours: 6),
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: true,
        ),
      );
      LoggerService.info('Periodic background task registered');
    } catch (e) {
      LoggerService.error('Failed to register periodic task: $e');
    }
  }

  static Future<void> registerOneOffTask() async {
    try {
      await Workmanager().registerOneOffTask(
        '${uniqueName}_once',
        taskName,
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: true,
        ),
      );
      LoggerService.info('One-off background task registered');
    } catch (e) {
      LoggerService.error('Failed to register one-off task: $e');
    }
  }

  static Future<void> cancelAll() async {
    try {
      await Workmanager().cancelAll();
      LoggerService.info('All background tasks cancelled');
    } catch (e) {
      LoggerService.error('Failed to cancel background tasks: $e');
    }
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    LoggerService.info('Background task executed: $task');

    switch (task) {
      case BackgroundService.taskName:
        try {
          // Reschedule all notifications
          // TODO: Load tanings from database and reschedule
          // final scheduler = NotificationScheduler();
          // await scheduler.rescheduleAll(tanings);
          LoggerService.info('Background sync completed');
          return true;
        } catch (e) {
          LoggerService.error('Background task failed: $e');
          return false;
        }
      default:
        return false;
    }
  });
}