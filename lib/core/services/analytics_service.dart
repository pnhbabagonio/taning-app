import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:taning/core/services/logger.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  FirebaseAnalytics? _analytics;
  bool _isEnabled = false;

  void initialize() {
    try {
      _analytics = FirebaseAnalytics.instance;
      _isEnabled = true;
      LoggerService.info('Analytics initialized');
    } catch (e) {
      LoggerService.warning('Analytics initialization failed: $e');
      _isEnabled = false;
    }
  }

  void logScreenView(String screenName, {String? screenClass}) {
    if (!_isEnabled) return;
    try {
      _analytics?.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
    } catch (e) {
      LoggerService.debug('Failed to log screen view: $e');
    }
  }

  void logEvent(String name, {Map<String, dynamic>? parameters}) {
    if (!_isEnabled) return;
    try {
      _analytics?.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (e) {
      LoggerService.debug('Failed to log event: $e');
    }
  }

  // Product-specific events
  void logTaningCreated({required String type, required String? category}) {
    logEvent(
      'taning_created',
      parameters: {
        'type': type,
        'category': category ?? 'uncategorized',
      },
    );
  }

  void logTaningCompleted() {
    logEvent('taning_completed');
  }

  void logTaningDeleted() {
    logEvent('taning_deleted');
  }

  void logTaningShared() {
    logEvent('taning_shared');
  }

  void logNotificationEnabled() {
    logEvent('notification_enabled');
  }

  void logWidgetAdded() {
    logEvent('widget_added');
  }

  void logThemeChanged(String theme) {
    logEvent('theme_changed', parameters: {'theme': theme});
  }

  void logAppOpened() {
    logEvent('app_opened');
  }

  void logError(String error, {String? context}) {
    logEvent(
      'error_occurred',
      parameters: {
        'error': error,
        'context': context ?? 'unknown',
      },
    );
  }
}