import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';
import 'package:taning/core/services/logger.dart';

class WidgetBridge {
  static const String _prefKey = 'widget_data';
  static const String _iosGroupKey = 'widget_data_ios';

  static Future<void> updateWidgetData(Taning taning) async {
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
      await prefs.setString(_prefKey, jsonEncode(data));

      // iOS app group shared preferences
      try {
        // For iOS app group
        final iosPrefs = await SharedPreferences.getInstance();
        await iosPrefs.setString(_iosGroupKey, jsonEncode(data));
      } catch (e) {
        LoggerService.debug('iOS group preferences not available: $e');
      }

      // Trigger widget updates
      await _updateAndroidWidget();
      await _updateIosWidget();

      LoggerService.info('Widget data updated for: ${taning.title}');
    } catch (e) {
      LoggerService.error('Failed to update widget data: $e');
    }
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
      // Method channel for iOS widget update
      const platform = MethodChannel('com.taning.app/widget');
      await platform.invokeMethod('updateWidget');
    } catch (e) {
      LoggerService.debug('iOS widget update failed: $e');
    }
  }

  static Future<void> updateWidgetsWithAllTanings(List<Taning> tanings) async {
    // Find the best Taning to show on widget
    Taning? selected;

    // Prefer pinned or soonest active Taning
    for (final taning in tanings) {
      if (taning.isArchived || taning.isCompleted) continue;

      if (taning.isPinned) {
        selected = taning;
        break;
      }
    }

    if (selected == null && tanings.isNotEmpty) {
      // Choose the one with soonest end date
      selected =
          tanings.where((t) => !t.isArchived && !t.isCompleted).fold<Taning?>(
        null,
        (prev, current) {
          if (prev == null) return current;
          if (current.endDate == null) return prev;
          if (prev.endDate == null) return current;
          return current.endDate!.isBefore(prev.endDate!) ? current : prev;
        },
      );
    }

    if (selected != null) {
      await updateWidgetData(selected);
    }
  }
}

// Method Channel setup
class WidgetPlugin {
  static const MethodChannel _channel = MethodChannel('com.taning.app/widget');

  static Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getWidgetData':
        final prefs = await SharedPreferences.getInstance();
        final data = prefs.getString(WidgetBridge._prefKey);
        return data;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'Method ${call.method} not implemented',
        );
    }
  }
}
