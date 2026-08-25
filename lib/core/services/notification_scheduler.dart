import 'package:taning/core/services/notification_service.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';

class NotificationScheduler {
  final NotificationService _notificationService;
  final CountdownEngine _countdownEngine;

  NotificationScheduler({
    NotificationService? notificationService,
    CountdownEngine? countdownEngine,
  })  : _notificationService = notificationService ?? NotificationService(),
        _countdownEngine = countdownEngine ?? const CountdownEngine();

  Future<void> scheduleForTaning(Taning taning) async {
    // Cancel old notifications first
    await _notificationService.cancelNotification(taning.id);

    // Check if notifications are enabled
    if (!taning.notificationSettings.enabled) {
      return;
    }

    // Get notification times based on type
    final times = calculateNotificationTimes(taning);
    if (times.isEmpty) return;

    // Schedule each notification
    for (final time in times) {
      await _notificationService.scheduleNotification(
        id: '${taning.id}_${time.type.name}',
        title: _getNotificationTitle(taning, time),
        body: _getNotificationBody(taning, time),
        scheduledTime: time.time,
        taningId: taning.id,
        payload: {
          'taningId': taning.id,
          'type': time.type.toString(),
        },
      );
    }
  }

  Future<void> rescheduleAll(List<Taning> tanings) async {
    // Cancel all existing notifications
    await _notificationService.cancelAllNotifications();

    // Schedule for each Taning
    for (final taning in tanings) {
      await scheduleForTaning(taning);
    }
  }

  List<NotificationTime> calculateNotificationTimes(Taning taning) {
    final times = <NotificationTime>[];
    final settings = taning.notificationSettings;

    if (!settings.enabled) return times;

    switch (taning.type) {
      case TaningType.countdown:
        if (taning.endDate == null) return times;
        times.addAll(_calculateCountdownTimes(taning));
        break;

      case TaningType.duration:
        if (taning.endDate == null) return times;
        times.addAll(_calculateDurationTimes(taning));
        break;

      case TaningType.recurring:
        // Recurring events use the same logic as countdown
        if (taning.endDate == null) return times;
        times.addAll(_calculateCountdownTimes(taning));
        break;

      case TaningType.countUp:
        // Count-up doesn't have typical notifications
        times.addAll(_calculateCountUpTimes(taning));
        break;
    }

    return times;
  }

  List<NotificationTime> _calculateCountdownTimes(Taning taning) {
    final target = taning.endDate!;
    final settings = taning.notificationSettings;
    final times = <NotificationTime>[];

    if (settings.sevenDaysBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(days: 7)),
        type: NotificationType.sevenDaysBefore,
      ));
    }

    if (settings.threeDaysBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(days: 3)),
        type: NotificationType.threeDaysBefore,
      ));
    }

    if (settings.oneDayBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(days: 1)),
        type: NotificationType.oneDayBefore,
      ));
    }

    if (settings.oneHourBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(hours: 1)),
        type: NotificationType.oneHourBefore,
      ));
    }

    if (settings.thirtyMinutesBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(minutes: 30)),
        type: NotificationType.thirtyMinutesBefore,
      ));
    }

    if (settings.atExactTime) {
      times.add(NotificationTime(
        time: target,
        type: NotificationType.exactTime,
      ));
    }

    // Progress notifications for duration
    if (taning.type == TaningType.duration) {
      times.addAll(_calculateProgressNotifications(taning));
    }

    return times;
  }

  List<NotificationTime> _calculateDurationTimes(Taning taning) {
    final times = <NotificationTime>[];

    // Same as countdown plus progress notifications
    times.addAll(_calculateCountdownTimes(taning));

    // Progress milestones
    times.addAll(_calculateProgressNotifications(taning));

    return times;
  }

  List<NotificationTime> _calculateCountUpTimes(Taning taning) {
    final times = <NotificationTime>[];

    // Send reminders at milestones for count-up
    if (taning.startDate != null) {
      final start = taning.startDate!;
      final now = DateTime.now();

      // Milestones: 7 days, 30 days, 100 days, 365 days
      final milestones = [7, 30, 100, 365];
      for (final days in milestones) {
        final milestoneDate = start.add(Duration(days: days));
        if (milestoneDate.isAfter(now)) {
          times.add(NotificationTime(
            time: milestoneDate,
            type: NotificationType.milestone,
          ));
        }
      }
    }

    return times;
  }

  List<NotificationTime> _calculateProgressNotifications(Taning taning) {
    final times = <NotificationTime>[];
    
    if (taning.startDate == null || taning.endDate == null) return times;

    final start = taning.startDate!;
    final end = taning.endDate!;
    final total = end.difference(start);
    final totalDays = total.inDays;

    // Send notifications at 25%, 50%, 75% complete
    final milestones = [0.25, 0.50, 0.75, 0.90];
    for (final milestone in milestones) {
      final days = (totalDays * milestone).round();
      final milestoneDate = start.add(Duration(days: days));
      if (milestoneDate.isAfter(DateTime.now())) {
        times.add(NotificationTime(
          time: milestoneDate,
          type: NotificationType.progress,
        ));
      }
    }

    return times;
  }

  String _getNotificationTitle(Taning taning, NotificationTime time) {
    switch (time.type) {
      case NotificationType.oneDayBefore:
        return '⏰ ${taning.title} is tomorrow!';
      case NotificationType.threeDaysBefore:
        return '📅 ${taning.title} is in 3 days';
      case NotificationType.sevenDaysBefore:
        return '📅 ${taning.title} is in 1 week';
      case NotificationType.oneHourBefore:
        return '⚡ ${taning.title} is in 1 hour!';
      case NotificationType.thirtyMinutesBefore:
        return '🔥 ${taning.title} is in 30 minutes!';
      case NotificationType.exactTime:
        return '🎉 ${taning.title} is here!';
      case NotificationType.progress:
        return '📊 ${taning.title} progress update';
      case NotificationType.milestone:
        return '🏆 ${taning.title} milestone reached!';
    }
  }

  String _getNotificationBody(Taning taning, NotificationTime time) {
    final state = _countdownEngine.calculate(
      now: DateTime.now(),
      taning: taning,
    );

    switch (time.type) {
      case NotificationType.oneDayBefore:
        return 'One day left! ${state.formattedRemaining} remaining.';
      case NotificationType.threeDaysBefore:
        return '3 days left! ${state.formattedRemaining} remaining.';
      case NotificationType.sevenDaysBefore:
        return '7 days left! ${state.formattedRemaining} remaining.';
      case NotificationType.oneHourBefore:
        return 'Just 1 hour to go! ${state.formattedRemaining} remaining.';
      case NotificationType.thirtyMinutesBefore:
        return 'Only 30 minutes left! ${state.formattedRemaining} remaining.';
      case NotificationType.exactTime:
        if (taning.type == TaningType.countdown) {
          return 'Your Taning "${taning.title}" has arrived! 🎉';
        } else {
          return 'It\'s time for "${taning.title}"! 🎉';
        }
      case NotificationType.progress:
        final progress = state.progressPercentage ?? 0;
        final percent = (progress * 100).toStringAsFixed(0);
        if (taning.type == TaningType.duration) {
          return 'Day ${state.currentDay} of ${state.totalDays} - $percent% complete! Keep going! 💪';
        }
        return '$percent% complete! Keep going! 💪';
      case NotificationType.milestone:
        final elapsed = state.elapsedDuration?.inDays ?? 0;
        return '$elapsed days since you started! Keep up the momentum! 🚀';
    }
  }
}

// MARK: - Notification Models

enum NotificationType {
  oneDayBefore,
  threeDaysBefore,
  sevenDaysBefore,
  oneHourBefore,
  thirtyMinutesBefore,
  exactTime,
  progress,
  milestone,
}

class NotificationTime {
  final DateTime time;
  final NotificationType type;

  const NotificationTime({
    required this.time,
    required this.type,
  });
}