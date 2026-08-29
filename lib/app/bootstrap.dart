import 'package:taning/core/services/logger.dart';
import 'package:taning/core/services/timezone_service.dart';
import 'package:taning/core/services/notification_service.dart';
import 'package:taning/core/services/background_service.dart';
import 'package:taning/core/services/analytics_service.dart';
import 'package:taning/database/app_database.dart';
import 'package:taning/plugins/notification_plugin.dart';
import 'package:taning/plugins/share_plugin.dart';
import 'package:taning/plugins/widget_plugin.dart';

Future<void> bootstrap() async {
  // Initialize logger
  LoggerService.initialize();

  // Initialize database
  await AppDatabase.initialize();

  // Set timezone
  await TimezoneService.initialize();

  // Initialize notifications
  await NotificationService().initialize();

  // Initialize background service
  await BackgroundService.initialize();

  // Register periodic sync
  await BackgroundService.registerPeriodicTask();

  // Initialize analytics
  AnalyticsService().initialize();
  AnalyticsService().logAppOpened();

  // Initialize plugins
  await NotificationPlugin.initialize();
  await SharePlugin.initialize();
  await WidgetPlugin.initialize();

  LoggerService.info('App initialized successfully');
}
