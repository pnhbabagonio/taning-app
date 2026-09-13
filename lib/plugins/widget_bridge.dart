import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taning/features/tanings/domain/entities/countdown_state.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';
import 'package:taning/core/services/logger.dart';

class WidgetBridge {
  static const String _prefKey = 'widget_data';
  static const String _iosGroupKey = 'widget_data_ios';
  static const int _maxTanings = 6;

  static Future<void> updateWidgetsWithAllTanings(List<Taning> tanings) async {
    try {
      final activeTanings = tanings
          .where((t) => !t.isArchived && !t.isCompleted)
          .toList();

      activeTanings.sort((a, b) {
        if (a.isPinned && !b.isPinned) return -1;
        if (!a.isPinned && b.isPinned) return 1;
        final aDate = a.endDate ?? a.startDate ?? DateTime(2100);
        final bDate = b.endDate ?? b.startDate ?? DateTime(2100);
        return aDate.compareTo(bDate);
      });

      final selected = activeTanings.take(_maxTanings).toList();
      final engine = const CountdownEngine();
      final now = DateTime.now();

      final List<Map<String, dynamic>> taningsData = selected.map((taning) {
        final state = engine.calculate(now: now, taning: taning);

        String countdownText;
        if (state.isFinished || state.isOverdue) {
          countdownText = state.isOverdue ? 'Overdue' : 'Done';
        } else if (state.status == CountdownStatus.today) {
          countdownText = 'Today';
        } else {
          final d = state.remainingDuration;
          if (d == null) {
            countdownText = '—';
          } else if (d.inDays > 0) {
            countdownText = '${d.inDays}d ${d.inHours.remainder(24)}h';
          } else if (d.inHours > 0) {
            countdownText = '${d.inHours}h ${d.inMinutes.remainder(60)}m';
          } else {
            countdownText = '${d.inMinutes}m';
          }
        }

        String dateText = '';
        final targetDate = state.targetDate;
        if (targetDate != null) {
          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
          dateText =
              '${months[targetDate.month - 1]} ${targetDate.day}, ${targetDate.year}';
        }

        return {
          'id': taning.id,
          'title': taning.title,
          'countdown': countdownText,
          'date': dateText,
          'icon': String.fromCharCode(taning.icon.codePoint),
          'color': taning.color.value,
          'red': (taning.color.value >> 16 & 0xFF) / 255.0,
          'green': (taning.color.value >> 8 & 0xFF) / 255.0,
          'blue': (taning.color.value & 0xFF) / 255.0,
          'progress': state.progressPercentage ?? 0.0,
          'isPinned': taning.isPinned,
          'isComplete': state.isFinished || state.isOverdue,
          'isOverdue': state.isOverdue,
        };
      }).toList();

      final data = {
        'tanings': taningsData,
        'count': taningsData.length,
        'updatedAt': now.toIso8601String(),
      };

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefKey, jsonEncode(data));

      try {
        final iosPrefs = await SharedPreferences.getInstance();
        await iosPrefs.setString(_iosGroupKey, jsonEncode(data));
      } catch (e) {
        LoggerService.debug('iOS group preferences not available: $e');
      }

      await _updateAndroidWidget();
      await _updateIosWidget();

      LoggerService.info(
        'Widget data updated with ${taningsData.length} Tanings',
      );
    } catch (e) {
      LoggerService.error('Failed to update widget data: $e');
    }
  }

  static Future<void> updateWidgetData(Taning taning) async {
    await updateWidgetsWithAllTanings([taning]);
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

// NOTE: WidgetPlugin class has been moved to lib/plugins/widget_plugin.dart