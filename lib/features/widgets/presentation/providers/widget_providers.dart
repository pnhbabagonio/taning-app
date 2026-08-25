import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/plugins/widget_bridge.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/providers/taning_providers.dart';

final widgetBridgeProvider = Provider<WidgetBridge>((ref) {
  return WidgetBridge();
});

final widgetUpdateProvider = FutureProvider<void>((ref) async {
  final repository = ref.watch(taningRepositoryProvider);
  final tanings = await repository.getAll();
  await WidgetBridge.updateWidgetsWithAllTanings(tanings);
});

final selectedWidgetTaningProvider = StateProvider<Taning?>((ref) {
  return null;
});

final widgetConfigProvider = StateProvider<WidgetConfig>((ref) {
  return WidgetConfig.defaults();
});

class WidgetConfig {
  final String taningId;
  final bool showProgress;
  final bool showIcon;
  final int theme;

  const WidgetConfig({
    required this.taningId,
    this.showProgress = true,
    this.showIcon = true,
    this.theme = 0,
  });

  factory WidgetConfig.defaults() {
    return const WidgetConfig(taningId: '');
  }

  WidgetConfig copyWith({
    String? taningId,
    bool? showProgress,
    bool? showIcon,
    int? theme,
  }) {
    return WidgetConfig(
      taningId: taningId ?? this.taningId,
      showProgress: showProgress ?? this.showProgress,
      showIcon: showIcon ?? this.showIcon,
      theme: theme ?? this.theme,
    );
  }
}