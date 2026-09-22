// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taning.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaningImpl _$$TaningImplFromJson(Map<String, dynamic> json) => _$TaningImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: $enumDecode(_$TaningTypeEnumMap, json['type']),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      timezone: json['timezone'] as String?,
      icon: TaningIcon.fromJson(json['icon'] as Map<String, dynamic>),
      color: TaningColor.fromJson(json['color'] as Map<String, dynamic>),
      theme: $enumDecode(_$TaningThemeEnumMap, json['theme']),
      countdownStyle:
          $enumDecode(_$CountdownStyleEnumMap, json['countdownStyle']),
      notificationSettings: NotificationSettings.fromJson(
          json['notificationSettings'] as Map<String, dynamic>),
      isCompleted: json['isCompleted'] as bool,
      isArchived: json['isArchived'] as bool,
      isPinned: json['isPinned'] as bool,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      lastNotifiedAt: json['lastNotifiedAt'] == null
          ? null
          : DateTime.parse(json['lastNotifiedAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      categoryId: json['categoryId'] as String?,
      recurrence: json['recurrence'] == null
          ? null
          : RecurrencePattern.fromJson(
              json['recurrence'] as Map<String, dynamic>),
      isAllDay: json['isAllDay'] as bool?,
    );

Map<String, dynamic> _$$TaningImplToJson(_$TaningImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$TaningTypeEnumMap[instance.type]!,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'timezone': instance.timezone,
      'icon': instance.icon,
      'color': instance.color,
      'theme': _$TaningThemeEnumMap[instance.theme]!,
      'countdownStyle': _$CountdownStyleEnumMap[instance.countdownStyle]!,
      'notificationSettings': instance.notificationSettings,
      'isCompleted': instance.isCompleted,
      'isArchived': instance.isArchived,
      'isPinned': instance.isPinned,
      'completedAt': instance.completedAt?.toIso8601String(),
      'lastNotifiedAt': instance.lastNotifiedAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'categoryId': instance.categoryId,
      'recurrence': instance.recurrence,
      'isAllDay': instance.isAllDay,
    };

const _$TaningTypeEnumMap = {
  TaningType.countdown: 'countdown',
  TaningType.duration: 'duration',
  TaningType.countUp: 'countUp',
  TaningType.recurring: 'recurring',
};

const _$TaningThemeEnumMap = {
  TaningTheme.midnight: 'midnight',
  TaningTheme.sunrise: 'sunrise',
  TaningTheme.forest: 'forest',
  TaningTheme.ocean: 'ocean',
  TaningTheme.sakura: 'sakura',
  TaningTheme.mono: 'mono',
  TaningTheme.filipino: 'filipino',
};

const _$CountdownStyleEnumMap = {
  CountdownStyle.simple: 'simple',
  CountdownStyle.detailed: 'detailed',
  CountdownStyle.full: 'full',
  CountdownStyle.progress: 'progress',
  CountdownStyle.calendar: 'calendar',
};

_$DailyRecurrenceImpl _$$DailyRecurrenceImplFromJson(
        Map<String, dynamic> json) =>
    _$DailyRecurrenceImpl(
      interval: (json['interval'] as num?)?.toInt() ?? 1,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$DailyRecurrenceImplToJson(
        _$DailyRecurrenceImpl instance) =>
    <String, dynamic>{
      'interval': instance.interval,
      'runtimeType': instance.$type,
    };

_$WeeklyRecurrenceImpl _$$WeeklyRecurrenceImplFromJson(
        Map<String, dynamic> json) =>
    _$WeeklyRecurrenceImpl(
      weekdays: (json['weekdays'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      interval: (json['interval'] as num?)?.toInt() ?? 1,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$WeeklyRecurrenceImplToJson(
        _$WeeklyRecurrenceImpl instance) =>
    <String, dynamic>{
      'weekdays': instance.weekdays,
      'interval': instance.interval,
      'runtimeType': instance.$type,
    };

_$MonthlyRecurrenceImpl _$$MonthlyRecurrenceImplFromJson(
        Map<String, dynamic> json) =>
    _$MonthlyRecurrenceImpl(
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      interval: (json['interval'] as num?)?.toInt() ?? 1,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$MonthlyRecurrenceImplToJson(
        _$MonthlyRecurrenceImpl instance) =>
    <String, dynamic>{
      'dayOfMonth': instance.dayOfMonth,
      'interval': instance.interval,
      'runtimeType': instance.$type,
    };

_$YearlyRecurrenceImpl _$$YearlyRecurrenceImplFromJson(
        Map<String, dynamic> json) =>
    _$YearlyRecurrenceImpl(
      month: (json['month'] as num).toInt(),
      dayOfMonth: (json['dayOfMonth'] as num?)?.toInt(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$YearlyRecurrenceImplToJson(
        _$YearlyRecurrenceImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'dayOfMonth': instance.dayOfMonth,
      'runtimeType': instance.$type,
    };

_$TaningIconImpl _$$TaningIconImplFromJson(Map<String, dynamic> json) =>
    _$TaningIconImpl(
      codePoint: (json['codePoint'] as num).toInt(),
      family: json['family'] as String?,
      imagePath: json['imagePath'] as String?,
    );

Map<String, dynamic> _$$TaningIconImplToJson(_$TaningIconImpl instance) =>
    <String, dynamic>{
      'codePoint': instance.codePoint,
      'family': instance.family,
      'imagePath': instance.imagePath,
    };

_$TaningColorImpl _$$TaningColorImplFromJson(Map<String, dynamic> json) =>
    _$TaningColorImpl(
      value: (json['value'] as num).toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$TaningColorImplToJson(_$TaningColorImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'name': instance.name,
    };

_$NotificationSettingsImpl _$$NotificationSettingsImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationSettingsImpl(
      enabled: json['enabled'] as bool,
      oneDayBefore: json['oneDayBefore'] as bool,
      threeDaysBefore: json['threeDaysBefore'] as bool,
      sevenDaysBefore: json['sevenDaysBefore'] as bool,
      oneHourBefore: json['oneHourBefore'] as bool,
      thirtyMinutesBefore: json['thirtyMinutesBefore'] as bool,
      atExactTime: json['atExactTime'] as bool,
      customNotification: json['customNotification'] as bool?,
      customMinutesBefore: (json['customMinutesBefore'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NotificationSettingsImplToJson(
        _$NotificationSettingsImpl instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'oneDayBefore': instance.oneDayBefore,
      'threeDaysBefore': instance.threeDaysBefore,
      'sevenDaysBefore': instance.sevenDaysBefore,
      'oneHourBefore': instance.oneHourBefore,
      'thirtyMinutesBefore': instance.thirtyMinutesBefore,
      'atExactTime': instance.atExactTime,
      'customNotification': instance.customNotification,
      'customMinutesBefore': instance.customMinutesBefore,
    };
