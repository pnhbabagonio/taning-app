import 'package:flutter/widgets.dart';

class PerformanceUtils {
  static bool _isPerformanceMode = false;

  static void enablePerformanceMode() {
    _isPerformanceMode = true;
  }

  static void disablePerformanceMode() {
    _isPerformanceMode = false;
  }

  /// Track widget rebuild count
  static void trackRebuild(String widgetName) {
    if (!_isPerformanceMode) return;
    
    debugPrint('🔄 Rebuild: $widgetName');
  }

  /// Measure function execution time
  static Future<T> measure<T>(
    String operation,
    Future<T> Function() action,
  ) async {
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = await action();
      stopwatch.stop();
      
      if (stopwatch.elapsedMilliseconds > 100) {
        debugPrint('⏱️ Slow operation: $operation took ${stopwatch.elapsedMilliseconds}ms');
      }
      
      return result;
    } catch (e) {
      stopwatch.stop();
      debugPrint('❌ Failed operation: $operation after ${stopwatch.elapsedMilliseconds}ms');
      rethrow;
    }
  }

  /// Measure synchronous function execution time
  static T measureSync<T>(
    String operation,
    T Function() action,
  ) {
    final stopwatch = Stopwatch()..start();
    
    try {
      final result = action();
      stopwatch.stop();
      
      if (stopwatch.elapsedMicroseconds > 100000) {
        debugPrint('⏱️ Slow sync operation: $operation took ${stopwatch.elapsedMicroseconds}µs');
      }
      
      return result;
    } catch (e) {
      stopwatch.stop();
      debugPrint('❌ Failed sync operation: $operation after ${stopwatch.elapsedMicroseconds}µs');
      rethrow;
    }
  }

  /// Optimize list building with keyed widgets
  static String getListKey(int index, Object item) {
    return '${item.hashCode}_$index';
  }
}

/// Rebuild tracker mixin for widgets
mixin RebuildTrackerMixin on State<StatefulWidget> {
  String get widgetName;
  
  @override
  void reassemble() {
    super.reassemble();
    PerformanceUtils.trackRebuild(widgetName);
  }
}