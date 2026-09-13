import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/plugins/widget_bridge.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';

final widgetBridgeProvider = Provider<WidgetBridge>((ref) {
  return WidgetBridge();
});

final widgetUpdateProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(taningRepositoryProvider);
  final tanings = await repository.getAll();
  await WidgetBridge.updateWidgetsWithAllTanings(tanings);
});

final widgetConfigProvider = StateProvider<WidgetConfig>((ref) {
  return WidgetConfig.defaults();
});

class WidgetConfig {
  final bool showIcons;
  final bool showDates;
  final bool showProgress;

  const WidgetConfig({
    this.showIcons = true,
    this.showDates = true,
    this.showProgress = true,
  });

  factory WidgetConfig.defaults() {
    return const WidgetConfig();
  }

  WidgetConfig copyWith({
    bool? showIcons,
    bool? showDates,
    bool? showProgress,
  }) {
    return WidgetConfig(
      showIcons: showIcons ?? this.showIcons,
      showDates: showDates ?? this.showDates,
      showProgress: showProgress ?? this.showProgress,
    );
  }
}