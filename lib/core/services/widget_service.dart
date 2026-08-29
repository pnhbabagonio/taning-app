import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taning/core/services/logger.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';

class WidgetService {
  static const String _prefKey = 'widget_data';

  /// Update widget data for a specific Taning
  static Future<bool> updateWidgetData(Taning taning) async {
    try {
      const engine = CountdownEngine();
      final state = engine.calculate(
        now: DateTime.now(),
        taning: taning,
      );

      final data = {
        'title': taning.title,
        'days': state.remainingDuration?.inDays ?? 0,
        'hours': state.remainingDuration?.inHours.remainder(24) ?? 0,
        'minutes': state.remainingDuration?.inMinutes.remainder(60) ?? 0,
        'seconds': state.remainingDuration?.inSeconds.remainder(60) ?? 0,
        'color': taning.color.value,
        'red': (taning.color.value >> 16 & 0xFF) / 255.0,
        'green': (taning.color.value >> 8 & 0xFF) / 255.0,
        'blue': (taning.color.value & 0xFF) / 255.0,
        'icon': String.fromCharCode(taning.icon.codePoint),
        'progress': state.progressPercentage ?? 0.0,
        'isComplete': state.isFinished || state.isOverdue,
        'updatedAt': DateTime.now().toIso8601String(),
      };

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, data.toString());

      // Trigger widget updates
      await _updateAndroidWidget();
      await _updateIosWidget();

      LoggerService.info('Widget data updated for: ${taning.title}');
      return true;
    } catch (e) {
      LoggerService.error('Failed to update widget data: $e');
      return false;
    }
  }

  /// Update widgets with the best available Taning
  static Future<bool> updateWidgetsWithAllTanings(List<Taning> tanings) async {
    if (tanings.isEmpty) {
      LoggerService.debug('No Tanings available for widget');
      return false;
    }

    // Find the best Taning to show on widget
    Taning? selected;

    // Prefer pinned active Tanings
    for (final taning in tanings) {
      if (taning.isArchived || taning.isCompleted) continue;
      if (taning.isPinned) {
        selected = taning;
        break;
      }
    }

    // If no pinned, choose the soonest active
    selected ??= tanings
          .where((t) => !t.isArchived && !t.isCompleted)
          .fold<Taning?>(
            null,
            (prev, current) {
              if (prev == null) return current;
              if (current.endDate == null) return prev;
              if (prev.endDate == null) return current;
              return current.endDate!.isBefore(prev.endDate!) ? current : prev;
            },
          );

    if (selected != null) {
      return await updateWidgetData(selected);
    }

    return false;
  }

  static Future<void> _updateAndroidWidget() async {
    try {
      const platform = MethodChannel('com.taning.app/widget');
      await platform.invokeMethod('updateWidget');
    } catch (e) {
      LoggerService.debug('Android widget update failed: $e');
    }
  }

  static Future<void> _updateIosWidget() async {
    try {
      const platform = MethodChannel('com.taning.app/widget');
      await platform.invokeMethod('updateWidget');
    } catch (e) {
      LoggerService.debug('iOS widget update failed: $e');
    }
  }
}