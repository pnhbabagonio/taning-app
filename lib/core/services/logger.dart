// lib/core/services/logger.dart
import 'dart:developer' as developer;

class LoggerService {
  static bool _isInitialized = false;
  static bool _debugMode = false;
  
  static void initialize({bool debugMode = true}) {
    _isInitialized = true;
    _debugMode = debugMode;
  }
  
  static void debug(String message, {String? tag}) {
    if (_debugMode) {
      developer.log(
        message,
        name: tag ?? 'Taning',
        level: 0,
      );
    }
  }
  
  static void info(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? 'Taning',
      level: 1,
    );
  }
  
  static void warning(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? 'Taning',
      level: 2,
      error: 'WARNING',
    );
  }
  
  static void error(String message, {String? tag, Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: tag ?? 'Taning',
      level: 3,
      error: error,
      stackTrace: stackTrace,
    );
  }
}