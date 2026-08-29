import 'package:flutter/services.dart';
import 'package:taning/core/services/logger.dart';
import 'package:taning/core/services/notification_service.dart';

/// Plugin for handling native notification actions and deep linking
class NotificationPlugin {
  static const MethodChannel _channel = MethodChannel('com.taning.app/notifications');

  static Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethodCall);
    LoggerService.info('NotificationPlugin initialized');
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'notificationTapped':
        return _handleNotificationTap(call.arguments);
      case 'notificationAction':
        return _handleNotificationAction(call.arguments);
      case 'getPendingNotifications':
        return _getPendingNotifications();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'Method ${call.method} not implemented',
        );
    }
  }

  static Future<void> _handleNotificationTap(Map<String, dynamic>? args) async {
    if (args == null) return;
    
    final taningId = args['taningId'] as String?;
    final action = args['action'] as String?;
    
    LoggerService.info('Notification tapped: taningId=$taningId, action=$action');
    
    // Handle different actions
    switch (action) {
      case 'snooze':
        await _handleSnooze(taningId);
        break;
      case 'mark_done':
        await _handleMarkDone(taningId);
        break;
      default:
        // Open the app to the detail screen
        if (taningId != null) {
          // Navigate to detail screen
          // This will be handled by the app's navigation system
        }
        break;
    }
  }

  static Future<void> _handleNotificationAction(Map<String, dynamic>? args) async {
    if (args == null) return;
    
    final action = args['action'] as String?;
    final taningId = args['taningId'] as String?;
    
    switch (action) {
      case 'snooze':
        await _handleSnooze(taningId);
        break;
      case 'mark_done':
        await _handleMarkDone(taningId);
        break;
      default:
        LoggerService.debug('Unknown notification action: $action');
    }
  }

  static Future<void> _handleSnooze(String? taningId) async {
    if (taningId == null) return;
    
    LoggerService.info('Snoozing notification for Taning: $taningId');
    
    // Reschedule notification 15 minutes later
    final now = DateTime.now();
    final snoozeTime = now.add(const Duration(minutes: 15));
    
    // Re-schedule the notification
    // This would need access to the Taning data to reschedule
    // For now, we just log it
    LoggerService.info('Notification snoozed until $snoozeTime');
  }

  static Future<void> _handleMarkDone(String? taningId) async {
    if (taningId == null) return;
    
    LoggerService.info('Marking Taning as done: $taningId');
    
    // Mark the Taning as completed
    // This requires access to the repository
    // We'll handle this via the app's providers
  }

  static Future<List<Map<String, dynamic>>> _getPendingNotifications() async {
    try {
      final notificationService = NotificationService();
      final pending = await notificationService.getPendingNotifications();
      return pending.map((p) => {
        'id': p.id,
        'title': p.title,
        'body': p.body,
      }).toList();
    } catch (e) {
      LoggerService.error('Failed to get pending notifications: $e');
      return [];
    }
  }

  /// Register notification action handlers
  static void registerActionHandlers({
    required VoidCallback onSnooze,
    required VoidCallback onMarkDone,
  }) {
    // Store handlers for use when notifications are tapped
    // This is called from the main app initialization
  }
}