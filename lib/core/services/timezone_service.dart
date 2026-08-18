// lib/core/services/timezone_service.dart
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TimezoneService {
  static bool _initialized = false;
  
  static Future<void> initialize() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    _initialized = true;
  }
  
  static tz.TZDateTime now() {
    return tz.TZDateTime.now(tz.local);
  }
  
  static DateTime toLocal(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }
  
  static tz.TZDateTime toTZDateTime(DateTime dateTime) {
    return tz.TZDateTime.from(dateTime, tz.local);
  }
  
  static String getTimeZoneName() {
    return tz.local.name;
  }
}