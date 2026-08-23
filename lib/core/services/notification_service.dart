import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:taning/core/services/logger.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  late FlutterLocalNotificationsPlugin _plugin;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialize timezone
      tz.initializeTimeZones();

      // Initialize plugin
      _plugin = FlutterLocalNotificationsPlugin();

      // Android settings
      const androidSettings = AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );

      // iOS settings
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      );

      const settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _plugin.initialize(
        settings,
        onDidReceiveNotificationResponse: _onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: _onNotificationTapBackground,
      );

      _isInitialized = true;
      LoggerService.info('Notification service initialized');
    } catch (e) {
      LoggerService.error('Failed to initialize notifications: $e');
    }
  }

  Future<void> requestPermissions() async {
    try {
      final iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      final settings = InitializationSettings(
        iOS: iosSettings,
      );

      await _plugin.initialize(settings);
      LoggerService.info('Notification permissions requested');
    } catch (e) {
      LoggerService.error('Failed to request notification permissions: $e');
    }
  }

  Future<void> scheduleNotification({
    required String id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    Map<String, String>? payload,
    String? taningId,
    String? channelId,
  }) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // Don't schedule for past times
      if (scheduledTime.isBefore(DateTime.now())) {
        LoggerService.debug('Skipping past notification: $title');
        return;
      }

      final androidDetails = AndroidNotificationDetails(
        channelId ?? 'taning_channel',
        'Taning Notifications',
        channelDescription: 'Reminders for your Tanings',
        importance: Importance.high,
        priority: Priority.high,
        visibility: NotificationVisibility.public,
        playSound: true,
        enableVibration: true,
        icon: '@mipmap/ic_launcher',
        color: const Color(0xFF4F46E5),
        colorized: true,
        styleInformation: const BigTextStyleInformation(''),
        actions: [
          AndroidNotificationAction(
            'snooze',
            'Snooze 15m',
            icon: '@mipmap/ic_launcher',
          ),
          AndroidNotificationAction(
            'mark_done',
            'Mark as Done',
            icon: '@mipmap/ic_launcher',
          ),
        ],
      );

      final iosDetails = DarwinNotificationDetails(
        sound: 'default.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        categoryIdentifier: 'taning_category',
        interruptionLevel: InterruptionLevel.active,
        relevanceScore: 0.5,
      );

      final details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final notificationId = _generateNotificationId(id);
      final tzDateTime = tz.TZDateTime.from(scheduledTime, tz.local);

      await _plugin.zonedSchedule(
        notificationId,
        title,
        body,
        tzDateTime,
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: payload != null ? payload.toString() : null,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      LoggerService.info('Notification scheduled: $title at $scheduledTime');
    } catch (e) {
      LoggerService.error('Failed to schedule notification: $e');
    }
  }

  Future<void> cancelNotification(String id) async {
    try {
      final notificationId = _generateNotificationId(id);
      await _plugin.cancel(notificationId);
      LoggerService.debug('Notification cancelled: $id');
    } catch (e) {
      LoggerService.error('Failed to cancel notification: $e');
    }
  }

  Future<void> cancelAllNotifications() async {
    try {
      await _plugin.cancelAll();
      LoggerService.info('All notifications cancelled');
    } catch (e) {
      LoggerService.error('Failed to cancel all notifications: $e');
    }
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    try {
      return await _plugin.pendingNotificationRequests();
    } catch (e) {
      LoggerService.error('Failed to get pending notifications: $e');
      return [];
    }
  }

  Future<void> showImmediateNotification({
    required String title,
    required String body,
    Map<String, String>? payload,
  }) async {
    try {
      const androidDetails = AndroidNotificationDetails(
        'taning_channel',
        'Taning Notifications',
        channelDescription: 'Reminders for your Tanings',
        importance: Importance.max,
        priority: Priority.max,
        icon: '@mipmap/ic_launcher',
        color: const Color(0xFF4F46E5),
        colorized: true,
      );

      const iosDetails = DarwinNotificationDetails(
        sound: 'default.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final notificationId = DateTime.now().millisecondsSinceEpoch % 100000;
      await _plugin.show(
        notificationId,
        title,
        body,
        details,
        payload: payload != null ? payload.toString() : null,
      );

      LoggerService.info('Immediate notification shown: $title');
    } catch (e) {
      LoggerService.error('Failed to show immediate notification: $e');
    }
  }

  int _generateNotificationId(String id) {
    // Generate a consistent ID based on the string
    return id.hashCode.abs();
  }

  void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap in foreground
    LoggerService.info('Notification tapped: ${response.payload}');
    
    if (response.payload != null) {
      // Parse payload and navigate
      // TODO: Handle navigation from notification
    }

    if (response.actionId == 'snooze') {
      // Handle snooze action
      LoggerService.info('Snooze action triggered');
    } else if (response.actionId == 'mark_done') {
      // Handle mark done action
      LoggerService.info('Mark done action triggered');
    }
  }

  static void _onNotificationTapBackground(NotificationResponse response) {
    // Handle notification tap in background
    LoggerService.info('Background notification tapped: ${response.payload}');
  }
}