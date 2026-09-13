import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/core/services/logger.dart';
import 'package:taning/core/services/timezone_service.dart';
import 'package:taning/core/services/notification_service.dart';
import 'package:taning/core/services/background_service.dart';
import 'package:taning/core/services/analytics_service.dart';
import 'package:taning/database/app_database.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';
import 'package:taning/plugins/notification_plugin.dart';
import 'package:taning/plugins/share_plugin.dart';
import 'package:taning/plugins/widget_plugin.dart';
import 'package:taning/plugins/widget_bridge.dart';

Future<void> bootstrap(ProviderContainer container) async {
  LoggerService.initialize();
  LoggerService.info('Starting bootstrap...');

  await AppDatabase.initialize();
  await TimezoneService.initialize();
  await NotificationService().initialize();
  await BackgroundService.initialize();
  await BackgroundService.registerPeriodicTask();

  AnalyticsService().initialize();
  AnalyticsService().logAppOpened();

  await NotificationPlugin.initialize();
  await SharePlugin.initialize();
  await WidgetPlugin.initialize();

  // Load widget data on startup
  await _prePopulateWidgetData(container);

  // Refresh widget whenever Tanings change
  _listenForTaningChanges(container);

  LoggerService.info('App initialized successfully');
}

Future<void> _prePopulateWidgetData(ProviderContainer container) async {
  try {
    final repository = container.read(taningRepositoryProvider);
    final tanings = await repository.getAll();
    await WidgetBridge.updateWidgetsWithAllTanings(tanings);
    LoggerService.info(
      'Pre-populated widget with ${tanings.length} Taning(s)',
    );
  } catch (e) {
    LoggerService.error('Failed to pre-populate widget data: $e');
  }
}

void _listenForTaningChanges(ProviderContainer container) {
  container.listen(
    activeTaningsProvider,
    (previous, next) {
      next.whenData((tanings) {
        WidgetBridge.updateWidgetsWithAllTanings(tanings);
      });
    },
    fireImmediately: false,
  );
}