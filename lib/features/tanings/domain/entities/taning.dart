import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

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

  const Taning._();

  factory Taning.create({
    required String title,
    required TaningType type,
    DateTime? startDate,
    DateTime? endDate,
    TaningIcon? icon,
    TaningColor? color,
    CountdownStyle? countdownStyle,
    NotificationSettings? notificationSettings,
    RecurrencePattern? recurrence,
    String? description,
  }) {
    return Taning(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      type: type,
      startDate: startDate,
      endDate: endDate,
      timezone: 'local',
      icon: icon ?? TaningIcon.defaultIcon(),
      color: color ?? TaningColor.defaultColor(),
      theme: TaningTheme.midnight,
      countdownStyle: countdownStyle ?? CountdownStyle.simple,
      notificationSettings:
          notificationSettings ?? NotificationSettings.defaults(),
      isCompleted: false,
      isArchived: false,
      isPinned: false,
      recurrence: recurrence,
      createdAt: DateTime.now(),
      isAllDay: false,
    );
  }
}

enum TaningType { countdown, duration, countUp, recurring }

@freezed
class RecurrencePattern with _$RecurrencePattern {
  const factory RecurrencePattern.daily({
    @Default(1) int interval,
  }) = DailyRecurrence;

  const factory RecurrencePattern.weekly({
    required List<int> weekdays,
    @Default(1) int interval,
  }) = WeeklyRecurrence;

  const factory RecurrencePattern.monthly({
    int? dayOfMonth,
    @Default(1) int interval,
  }) = MonthlyRecurrence;

  const factory RecurrencePattern.yearly({
    required int month,
    int? dayOfMonth,
  }) = YearlyRecurrence;

  const RecurrencePattern._();

  factory RecurrencePattern.fromJson(Map<String, dynamic> json) =>
      _$RecurrencePatternFromJson(json);
}

@freezed
class TaningIcon with _$TaningIcon {
  const factory TaningIcon({
    required int codePoint,
    String? family,
    String? imagePath,
  }) = _TaningIcon;

  const TaningIcon._();

  factory TaningIcon.fromJson(Map<String, dynamic> json) =>
      _$TaningIconFromJson(json);

  static TaningIcon defaultIcon() => const TaningIcon(codePoint: 0xE8E9);
  static TaningIcon vacation() => const TaningIcon(codePoint: 0xE8ED);
  static TaningIcon birthday() => const TaningIcon(codePoint: 0xE8F0);
  static TaningIcon graduation() => const TaningIcon(codePoint: 0xE8F5);
  static TaningIcon deadline() => const TaningIcon(codePoint: 0xE8F8);
  static TaningIcon challenge() => const TaningIcon(codePoint: 0xE8FB);
  static TaningIcon anniversary() => const TaningIcon(codePoint: 0xE8FE);
}

@freezed
class TaningColor with _$TaningColor {
  const factory TaningColor({
    required int value,
    String? name,
  }) = _TaningColor;

  const TaningColor._();

  factory TaningColor.fromJson(Map<String, dynamic> json) =>
      _$TaningColorFromJson(json);

  static TaningColor defaultColor() => const TaningColor(value: 0xFF4F46E5);

  Color toColor() => Color(value);

  static const List<TaningColor> presets = [
    TaningColor(value: 0xFF4F46E5, name: 'Indigo'),
    TaningColor(value: 0xFF7C3AED, name: 'Purple'),
    TaningColor(value: 0xFFEC4899, name: 'Pink'),
    TaningColor(value: 0xFFEF4444, name: 'Red'),
    TaningColor(value: 0xFFF97316, name: 'Orange'),
    TaningColor(value: 0xFFFCD34D, name: 'Gold'),
    TaningColor(value: 0xFF22C55E, name: 'Green'),
    TaningColor(value: 0xFF14B8A6, name: 'Teal'),
    TaningColor(value: 0xFF0EA5E9, name: 'Sky'),
  ];
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

  List<NotificationTime> getNotificationTimes(DateTime target) {
    final times = <NotificationTime>[];
    if (!enabled) return times;

    if (oneDayBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(days: 1)),
        type: NotificationType.oneDayBefore,
      ));
    }
    if (threeDaysBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(days: 3)),
        type: NotificationType.threeDaysBefore,
      ));
    }
    if (sevenDaysBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(days: 7)),
        type: NotificationType.sevenDaysBefore,
      ));
    }
    if (oneHourBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(hours: 1)),
        type: NotificationType.oneHourBefore,
      ));
    }
    if (thirtyMinutesBefore) {
      times.add(NotificationTime(
        time: target.subtract(const Duration(minutes: 30)),
        type: NotificationType.thirtyMinutesBefore,
      ));
    }
    if (atExactTime) {
      times.add(NotificationTime(
        time: target,
        type: NotificationType.exactTime,
      ));
    }
    if (customNotification == true && customMinutesBefore != null) {
      times.add(NotificationTime(
        time: target.subtract(Duration(minutes: customMinutesBefore!)),
        type: NotificationType.custom,
      ));
    }
    return times;
  }
}

enum NotificationType {
  oneDayBefore,
  threeDaysBefore,
  sevenDaysBefore,
  oneHourBefore,
  thirtyMinutesBefore,
  exactTime,
  custom,
}

@freezed
class NotificationTime with _$NotificationTime {
  const factory NotificationTime({
    required DateTime time,
    required NotificationType type,
  }) = _NotificationTime;
}