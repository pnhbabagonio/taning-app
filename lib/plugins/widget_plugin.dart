import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taning/core/services/logger.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';

/// Plugin for handling widget taps and native widget updates
class WidgetPlugin {
  static const MethodChannel _channel = MethodChannel('com.taning.app/widget');

  static Future<void> initialize() async {
    _channel.setMethodCallHandler(_handleMethodCall);
    LoggerService.info('WidgetPlugin initialized');
  }

  static Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'widgetTapped':
        return _handleWidgetTap(call.arguments);
      case 'getWidgetData':
        return _getWidgetData();
      case 'updateWidget':
        return _updateWidget();
      case 'getWidgetConfig':
        return _getWidgetConfig();
      case 'updateWidgetData':
        return _handleUpdateWidgetData(call.arguments);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'Method ${call.method} not implemented',
        );
    }
  }

  static Future<void> _handleWidgetTap(Map<String, dynamic>? args) async {
    if (args == null) return;
    
    final taningId = args['taningId'] as String?;
    final action = args['action'] as String? ?? 'open';
    
    LoggerService.info('Widget tapped: taningId=$taningId, action=$action');
    
    // The actual navigation will be handled by the app
    // This just notifies the app that a widget was tapped
  }

  static Future<String?> _getWidgetData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('widget_data');
    } catch (e) {
      LoggerService.error('Failed to get widget data: $e');
      return null;
    }
  }

  static Future<bool> _updateWidget() async {
    try {
      // Trigger widget update
      // This will be called from native side
      LoggerService.info('Widget update triggered from native');
      return true;
    } catch (e) {
      LoggerService.error('Failed to update widget: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> _getWidgetConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final config = {
        'taningId': prefs.getString('widget_config_taning_id') ?? '',
        'showProgress': prefs.getBool('widget_config_show_progress') ?? true,
        'showIcon': prefs.getBool('widget_config_show_icon') ?? true,
        'theme': prefs.getInt('widget_config_theme') ?? 0,
      };
      return config;
    } catch (e) {
      LoggerService.error('Failed to get widget config: $e');
      return {};
    }
  }

  static Future<bool> _handleUpdateWidgetData(Map<String, dynamic>? args) async {
    if (args == null) return false;
    
    try {
      // Parse the Taning data
      final taning = Taning(
        id: args['id'] as String? ?? '',
        title: args['title'] as String? ?? 'Taning',
        type: TaningType.values.firstWhere(
          (e) => e.toString() == args['type'],
          orElse: () => TaningType.countdown,
        ),
        endDate: args['endDate'] != null ? DateTime.parse(args['endDate'] as String) : null,
        color: TaningColor(value: args['color'] as int? ?? 0xFF4F46E5),
        icon: TaningIcon(codePoint: args['iconCodePoint'] as int? ?? 0xE8E9),
        theme: TaningTheme.midnight,
        countdownStyle: CountdownStyle.detailed,
        // ... other fields with defaults
        notificationSettings: NotificationSettings.defaults(),
        isCompleted: args['isCompleted'] as bool? ?? false,
        isArchived: false,
        isPinned: false,
        createdAt: DateTime.now(),
      );
      
      // Calculate countdown state
      const engine = CountdownEngine();
      final state = engine.calculate(
        now: DateTime.now(),
        taning: taning,
      );
      
      // Update widget data
      final prefs = await SharedPreferences.getInstance();
      final widgetData = {
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
        'taningId': taning.id,
      };
      
      await prefs.setString('widget_data', widgetData.toString());
      LoggerService.info('Widget data updated via native bridge');
      return true;
    } catch (e) {
      LoggerService.error('Failed to update widget data from native: $e');
      return false;
    }
  }

  /// Save widget configuration
  static Future<void> saveWidgetConfig({
    String? taningId,
    bool? showProgress,
    bool? showIcon,
    int? theme,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (taningId != null) {
        await prefs.setString('widget_config_taning_id', taningId);
      }
      if (showProgress != null) {
        await prefs.setBool('widget_config_show_progress', showProgress);
      }
      if (showIcon != null) {
        await prefs.setBool('widget_config_show_icon', showIcon);
      }
      if (theme != null) {
        await prefs.setInt('widget_config_theme', theme);
      }
      LoggerService.info('Widget config saved');
    } catch (e) {
      LoggerService.error('Failed to save widget config: $e');
    }
  }
}