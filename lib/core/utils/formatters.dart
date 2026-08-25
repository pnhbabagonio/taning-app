import 'package:intl/intl.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

class CountdownFormatter {
  const CountdownFormatter();
  
  /// Format a duration for display
  static String formatDuration(Duration duration, CountdownStyle style) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    switch (style) {
      case CountdownStyle.simple:
        if (days > 0) return '${days}d';
        if (hours > 0) return '${hours}h';
        if (minutes > 0) return '${minutes}m';
        return '${seconds}s';
        
      case CountdownStyle.detailed:
        if (days > 0) return '${days}d ${hours}h ${minutes}m';
        if (hours > 0) return '${hours}h ${minutes}m';
        if (minutes > 0) return '${minutes}m ${seconds}s';
        return '${seconds}s';
        
      case CountdownStyle.full:
        final parts = <String>[];
        if (days > 0) parts.add('${days}d');
        if (hours > 0 || days > 0) parts.add('${hours}h');
        if (minutes > 0 || hours > 0 || days > 0) parts.add('${minutes}m');
        parts.add('${seconds}s');
        return parts.join(' ');
        
      case CountdownStyle.progress:
        return '${days}d';
        
      case CountdownStyle.calendar:
        return '${days}d';
    }
  }
  
  /// Format a date for display
  static String formatDate(DateTime date, {bool includeTime = false}) {
    if (includeTime) {
      return DateFormat('MMM d, y h:mm a').format(date);
    }
    return DateFormat('MMM d, y').format(date);
  }
  
  /// Format a date for countdown display
  static String formatCountdownDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now);
    
    if (difference.isNegative) {
      return 'Already passed';
    }
    
    final days = difference.inDays;
    if (days == 0) return 'Today';
    if (days == 1) return 'Tomorrow';
    if (days < 7) return '$days days';
    if (days < 14) return 'Next week';
    if (days < 30) return '$days days';
    if (days < 60) return '${(days / 7).round()} weeks';
    if (days < 365) return '${(days / 30).round()} months';
    return '${(days / 365).round()} years';
  }
  
  /// Format a duration as a readable string
  static String formatDurationReadable(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    
    final parts = <String>[];
    if (days > 0) parts.add('$days day${days > 1 ? 's' : ''}');
    if (hours > 0) parts.add('$hours hour${hours > 1 ? 's' : ''}');
    if (minutes > 0) parts.add('$minutes minute${minutes > 1 ? 's' : ''}');
    if (seconds > 0 && parts.isEmpty) parts.add('$seconds second${seconds > 1 ? 's' : ''}');
    
    if (parts.isEmpty) return 'Just now';
    
    if (parts.length == 1) return parts.first;
    if (parts.length == 2) return '${parts[0]} and ${parts[1]}';
    return '${parts[0]}, ${parts[1]}, and ${parts[2]}';
  }
  
  /// Get time unit label
  static String timeUnitLabel(int value, String unit) {
    return '$value $unit${value != 1 ? 's' : ''}';
  }
}