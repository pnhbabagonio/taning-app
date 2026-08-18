// lib/features/tanings/domain/entities/taning.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'taning.freezed.dart';
part 'taning.g.dart';

@freezed
class Taning with _$Taning {
  const factory Taning({
    required String id,
    required String title,
    String? description,
    required TaningType type,
    DateTime? startDate,
    DateTime? endDate,
    String? timezone,
    required TaningIcon icon,
    required TaningColor color,
    required TaningTheme theme,
    required CountdownStyle countdownStyle,
    required NotificationSettings notificationSettings,
    required bool isCompleted,
    required bool isArchived,
    required bool isPinned,
    DateTime? completedAt,
    DateTime? lastNotifiedAt,
    required DateTime createdAt,
    DateTime? updatedAt,
    String? categoryId,
    RecurrencePattern? recurrence,
    bool? isAllDay,
  }) = _Taning;
  
  factory Taning.fromJson(Map<String, dynamic> json) => _$TaningFromJson(json);
}

enum TaningType {
  countdown,
  duration,
  countUp,
  recurring,
}

@freezed
class RecurrencePattern with _$RecurrencePattern {
  const factory RecurrencePattern.daily({
    int? interval,
  }) = DailyRecurrence;
  
  const factory RecurrencePattern.weekly({
    required List<int> weekdays,
    int? interval,
  }) = WeeklyRecurrence;
  
  const factory RecurrencePattern.monthly({
    int? dayOfMonth,
    int? interval,
  }) = MonthlyRecurrence;
  
  const factory RecurrencePattern.yearly({
    required int month,
    int? dayOfMonth,
  }) = YearlyRecurrence;
}

@freezed
class TaningIcon with _$TaningIcon {
  const factory TaningIcon({
    required int codePoint,
    String? family,
  }) = _TaningIcon;
  
  const TaningIcon._();
  
  factory TaningIcon.fromJson(Map<String, dynamic> json) => _$TaningIconFromJson(json);
}

@freezed
class TaningColor with _$TaningColor {
  const factory TaningColor({
    required int value,
    String? name,
  }) = _TaningColor;
  
  const TaningColor._();
  
  factory TaningColor.fromJson(Map<String, dynamic> json) => _$TaningColorFromJson(json);
}

enum TaningTheme {
  midnight,
  sunrise,
  forest,
  ocean,
  sakura,
  mono,
  filipino,
}

enum CountdownStyle {
  simple,
  detailed,
  full,
  progress,
  calendar,
}

@freezed
class NotificationSettings with _$NotificationSettings {
  const factory NotificationSettings({
    required bool enabled,
    required bool oneDayBefore,
    required bool threeDaysBefore,
    required bool sevenDaysBefore,
    required bool oneHourBefore,
    required bool thirtyMinutesBefore,
    required bool atExactTime,
    bool? customNotification,
    int? customMinutesBefore,
  }) = _NotificationSettings;
  
  const NotificationSettings._();
  
  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
  
  factory NotificationSettings.defaults() => const NotificationSettings(
    enabled: true,
    oneDayBefore: false,
    threeDaysBefore: false,
    sevenDaysBefore: false,
    oneHourBefore: false,
    thirtyMinutesBefore: false,
    atExactTime: false,
  );
}