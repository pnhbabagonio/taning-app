// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'taning.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Taning _$TaningFromJson(Map<String, dynamic> json) {
  return _Taning.fromJson(json);
}

/// @nodoc
mixin _$Taning {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  TaningType get type => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  TaningIcon get icon => throw _privateConstructorUsedError;
  TaningColor get color => throw _privateConstructorUsedError;
  TaningTheme get theme => throw _privateConstructorUsedError;
  CountdownStyle get countdownStyle => throw _privateConstructorUsedError;
  NotificationSettings get notificationSettings =>
      throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  bool get isArchived => throw _privateConstructorUsedError;
  bool get isPinned => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get lastNotifiedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get categoryId => throw _privateConstructorUsedError;
  RecurrencePattern? get recurrence => throw _privateConstructorUsedError;
  bool? get isAllDay => throw _privateConstructorUsedError;

  /// Serializes this Taning to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaningCopyWith<Taning> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaningCopyWith<$Res> {
  factory $TaningCopyWith(Taning value, $Res Function(Taning) then) =
      _$TaningCopyWithImpl<$Res, Taning>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      TaningType type,
      DateTime? startDate,
      DateTime? endDate,
      String? timezone,
      TaningIcon icon,
      TaningColor color,
      TaningTheme theme,
      CountdownStyle countdownStyle,
      NotificationSettings notificationSettings,
      bool isCompleted,
      bool isArchived,
      bool isPinned,
      DateTime? completedAt,
      DateTime? lastNotifiedAt,
      DateTime createdAt,
      DateTime? updatedAt,
      String? categoryId,
      RecurrencePattern? recurrence,
      bool? isAllDay});

  $TaningIconCopyWith<$Res> get icon;
  $TaningColorCopyWith<$Res> get color;
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
  $RecurrencePatternCopyWith<$Res>? get recurrence;
}

/// @nodoc
class _$TaningCopyWithImpl<$Res, $Val extends Taning>
    implements $TaningCopyWith<$Res> {
  _$TaningCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? timezone = freezed,
    Object? icon = null,
    Object? color = null,
    Object? theme = null,
    Object? countdownStyle = null,
    Object? notificationSettings = null,
    Object? isCompleted = null,
    Object? isArchived = null,
    Object? isPinned = null,
    Object? completedAt = freezed,
    Object? lastNotifiedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? categoryId = freezed,
    Object? recurrence = freezed,
    Object? isAllDay = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TaningType,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as TaningIcon,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as TaningColor,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as TaningTheme,
      countdownStyle: null == countdownStyle
          ? _value.countdownStyle
          : countdownStyle // ignore: cast_nullable_to_non_nullable
              as CountdownStyle,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastNotifiedAt: freezed == lastNotifiedAt
          ? _value.lastNotifiedAt
          : lastNotifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as RecurrencePattern?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaningIconCopyWith<$Res> get icon {
    return $TaningIconCopyWith<$Res>(_value.icon, (value) {
      return _then(_value.copyWith(icon: value) as $Val);
    });
  }

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaningColorCopyWith<$Res> get color {
    return $TaningColorCopyWith<$Res>(_value.color, (value) {
      return _then(_value.copyWith(color: value) as $Val);
    });
  }

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationSettingsCopyWith<$Res> get notificationSettings {
    return $NotificationSettingsCopyWith<$Res>(_value.notificationSettings,
        (value) {
      return _then(_value.copyWith(notificationSettings: value) as $Val);
    });
  }

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecurrencePatternCopyWith<$Res>? get recurrence {
    if (_value.recurrence == null) {
      return null;
    }

    return $RecurrencePatternCopyWith<$Res>(_value.recurrence!, (value) {
      return _then(_value.copyWith(recurrence: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaningImplCopyWith<$Res> implements $TaningCopyWith<$Res> {
  factory _$$TaningImplCopyWith(
          _$TaningImpl value, $Res Function(_$TaningImpl) then) =
      __$$TaningImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      TaningType type,
      DateTime? startDate,
      DateTime? endDate,
      String? timezone,
      TaningIcon icon,
      TaningColor color,
      TaningTheme theme,
      CountdownStyle countdownStyle,
      NotificationSettings notificationSettings,
      bool isCompleted,
      bool isArchived,
      bool isPinned,
      DateTime? completedAt,
      DateTime? lastNotifiedAt,
      DateTime createdAt,
      DateTime? updatedAt,
      String? categoryId,
      RecurrencePattern? recurrence,
      bool? isAllDay});

  @override
  $TaningIconCopyWith<$Res> get icon;
  @override
  $TaningColorCopyWith<$Res> get color;
  @override
  $NotificationSettingsCopyWith<$Res> get notificationSettings;
  @override
  $RecurrencePatternCopyWith<$Res>? get recurrence;
}

/// @nodoc
class __$$TaningImplCopyWithImpl<$Res>
    extends _$TaningCopyWithImpl<$Res, _$TaningImpl>
    implements _$$TaningImplCopyWith<$Res> {
  __$$TaningImplCopyWithImpl(
      _$TaningImpl _value, $Res Function(_$TaningImpl) _then)
      : super(_value, _then);

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? type = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? timezone = freezed,
    Object? icon = null,
    Object? color = null,
    Object? theme = null,
    Object? countdownStyle = null,
    Object? notificationSettings = null,
    Object? isCompleted = null,
    Object? isArchived = null,
    Object? isPinned = null,
    Object? completedAt = freezed,
    Object? lastNotifiedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? categoryId = freezed,
    Object? recurrence = freezed,
    Object? isAllDay = freezed,
  }) {
    return _then(_$TaningImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TaningType,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as TaningIcon,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as TaningColor,
      theme: null == theme
          ? _value.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as TaningTheme,
      countdownStyle: null == countdownStyle
          ? _value.countdownStyle
          : countdownStyle // ignore: cast_nullable_to_non_nullable
              as CountdownStyle,
      notificationSettings: null == notificationSettings
          ? _value.notificationSettings
          : notificationSettings // ignore: cast_nullable_to_non_nullable
              as NotificationSettings,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isArchived: null == isArchived
          ? _value.isArchived
          : isArchived // ignore: cast_nullable_to_non_nullable
              as bool,
      isPinned: null == isPinned
          ? _value.isPinned
          : isPinned // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastNotifiedAt: freezed == lastNotifiedAt
          ? _value.lastNotifiedAt
          : lastNotifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      recurrence: freezed == recurrence
          ? _value.recurrence
          : recurrence // ignore: cast_nullable_to_non_nullable
              as RecurrencePattern?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaningImpl extends _Taning {
  const _$TaningImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.type,
      this.startDate,
      this.endDate,
      this.timezone,
      required this.icon,
      required this.color,
      required this.theme,
      required this.countdownStyle,
      required this.notificationSettings,
      required this.isCompleted,
      required this.isArchived,
      required this.isPinned,
      this.completedAt,
      this.lastNotifiedAt,
      required this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.recurrence,
      this.isAllDay})
      : super._();

  factory _$TaningImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaningImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final TaningType type;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? timezone;
  @override
  final TaningIcon icon;
  @override
  final TaningColor color;
  @override
  final TaningTheme theme;
  @override
  final CountdownStyle countdownStyle;
  @override
  final NotificationSettings notificationSettings;
  @override
  final bool isCompleted;
  @override
  final bool isArchived;
  @override
  final bool isPinned;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? lastNotifiedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final String? categoryId;
  @override
  final RecurrencePattern? recurrence;
  @override
  final bool? isAllDay;

  @override
  String toString() {
    return 'Taning(id: $id, title: $title, description: $description, type: $type, startDate: $startDate, endDate: $endDate, timezone: $timezone, icon: $icon, color: $color, theme: $theme, countdownStyle: $countdownStyle, notificationSettings: $notificationSettings, isCompleted: $isCompleted, isArchived: $isArchived, isPinned: $isPinned, completedAt: $completedAt, lastNotifiedAt: $lastNotifiedAt, createdAt: $createdAt, updatedAt: $updatedAt, categoryId: $categoryId, recurrence: $recurrence, isAllDay: $isAllDay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaningImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.countdownStyle, countdownStyle) ||
                other.countdownStyle == countdownStyle) &&
            (identical(other.notificationSettings, notificationSettings) ||
                other.notificationSettings == notificationSettings) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.isArchived, isArchived) ||
                other.isArchived == isArchived) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.lastNotifiedAt, lastNotifiedAt) ||
                other.lastNotifiedAt == lastNotifiedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.recurrence, recurrence) ||
                other.recurrence == recurrence) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        type,
        startDate,
        endDate,
        timezone,
        icon,
        color,
        theme,
        countdownStyle,
        notificationSettings,
        isCompleted,
        isArchived,
        isPinned,
        completedAt,
        lastNotifiedAt,
        createdAt,
        updatedAt,
        categoryId,
        recurrence,
        isAllDay
      ]);

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaningImplCopyWith<_$TaningImpl> get copyWith =>
      __$$TaningImplCopyWithImpl<_$TaningImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaningImplToJson(
      this,
    );
  }
}

abstract class _Taning extends Taning {
  const factory _Taning(
      {required final String id,
      required final String title,
      final String? description,
      required final TaningType type,
      final DateTime? startDate,
      final DateTime? endDate,
      final String? timezone,
      required final TaningIcon icon,
      required final TaningColor color,
      required final TaningTheme theme,
      required final CountdownStyle countdownStyle,
      required final NotificationSettings notificationSettings,
      required final bool isCompleted,
      required final bool isArchived,
      required final bool isPinned,
      final DateTime? completedAt,
      final DateTime? lastNotifiedAt,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final String? categoryId,
      final RecurrencePattern? recurrence,
      final bool? isAllDay}) = _$TaningImpl;
  const _Taning._() : super._();

  factory _Taning.fromJson(Map<String, dynamic> json) = _$TaningImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  TaningType get type;
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  String? get timezone;
  @override
  TaningIcon get icon;
  @override
  TaningColor get color;
  @override
  TaningTheme get theme;
  @override
  CountdownStyle get countdownStyle;
  @override
  NotificationSettings get notificationSettings;
  @override
  bool get isCompleted;
  @override
  bool get isArchived;
  @override
  bool get isPinned;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get lastNotifiedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  String? get categoryId;
  @override
  RecurrencePattern? get recurrence;
  @override
  bool? get isAllDay;

  /// Create a copy of Taning
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaningImplCopyWith<_$TaningImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecurrencePattern _$RecurrencePatternFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'daily':
      return DailyRecurrence.fromJson(json);
    case 'weekly':
      return WeeklyRecurrence.fromJson(json);
    case 'monthly':
      return MonthlyRecurrence.fromJson(json);
    case 'yearly':
      return YearlyRecurrence.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'RecurrencePattern',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$RecurrencePattern {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int interval) daily,
    required TResult Function(List<int> weekdays, int interval) weekly,
    required TResult Function(int? dayOfMonth, int interval) monthly,
    required TResult Function(int month, int? dayOfMonth) yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int interval)? daily,
    TResult? Function(List<int> weekdays, int interval)? weekly,
    TResult? Function(int? dayOfMonth, int interval)? monthly,
    TResult? Function(int month, int? dayOfMonth)? yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int interval)? daily,
    TResult Function(List<int> weekdays, int interval)? weekly,
    TResult Function(int? dayOfMonth, int interval)? monthly,
    TResult Function(int month, int? dayOfMonth)? yearly,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRecurrence value) daily,
    required TResult Function(WeeklyRecurrence value) weekly,
    required TResult Function(MonthlyRecurrence value) monthly,
    required TResult Function(YearlyRecurrence value) yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRecurrence value)? daily,
    TResult? Function(WeeklyRecurrence value)? weekly,
    TResult? Function(MonthlyRecurrence value)? monthly,
    TResult? Function(YearlyRecurrence value)? yearly,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRecurrence value)? daily,
    TResult Function(WeeklyRecurrence value)? weekly,
    TResult Function(MonthlyRecurrence value)? monthly,
    TResult Function(YearlyRecurrence value)? yearly,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this RecurrencePattern to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurrencePatternCopyWith<$Res> {
  factory $RecurrencePatternCopyWith(
          RecurrencePattern value, $Res Function(RecurrencePattern) then) =
      _$RecurrencePatternCopyWithImpl<$Res, RecurrencePattern>;
}

/// @nodoc
class _$RecurrencePatternCopyWithImpl<$Res, $Val extends RecurrencePattern>
    implements $RecurrencePatternCopyWith<$Res> {
  _$RecurrencePatternCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$DailyRecurrenceImplCopyWith<$Res> {
  factory _$$DailyRecurrenceImplCopyWith(_$DailyRecurrenceImpl value,
          $Res Function(_$DailyRecurrenceImpl) then) =
      __$$DailyRecurrenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int interval});
}

/// @nodoc
class __$$DailyRecurrenceImplCopyWithImpl<$Res>
    extends _$RecurrencePatternCopyWithImpl<$Res, _$DailyRecurrenceImpl>
    implements _$$DailyRecurrenceImplCopyWith<$Res> {
  __$$DailyRecurrenceImplCopyWithImpl(
      _$DailyRecurrenceImpl _value, $Res Function(_$DailyRecurrenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? interval = null,
  }) {
    return _then(_$DailyRecurrenceImpl(
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyRecurrenceImpl extends DailyRecurrence {
  const _$DailyRecurrenceImpl({this.interval = 1, final String? $type})
      : $type = $type ?? 'daily',
        super._();

  factory _$DailyRecurrenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyRecurrenceImplFromJson(json);

  @override
  @JsonKey()
  final int interval;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecurrencePattern.daily(interval: $interval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyRecurrenceImpl &&
            (identical(other.interval, interval) ||
                other.interval == interval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, interval);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyRecurrenceImplCopyWith<_$DailyRecurrenceImpl> get copyWith =>
      __$$DailyRecurrenceImplCopyWithImpl<_$DailyRecurrenceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int interval) daily,
    required TResult Function(List<int> weekdays, int interval) weekly,
    required TResult Function(int? dayOfMonth, int interval) monthly,
    required TResult Function(int month, int? dayOfMonth) yearly,
  }) {
    return daily(interval);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int interval)? daily,
    TResult? Function(List<int> weekdays, int interval)? weekly,
    TResult? Function(int? dayOfMonth, int interval)? monthly,
    TResult? Function(int month, int? dayOfMonth)? yearly,
  }) {
    return daily?.call(interval);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int interval)? daily,
    TResult Function(List<int> weekdays, int interval)? weekly,
    TResult Function(int? dayOfMonth, int interval)? monthly,
    TResult Function(int month, int? dayOfMonth)? yearly,
    required TResult orElse(),
  }) {
    if (daily != null) {
      return daily(interval);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRecurrence value) daily,
    required TResult Function(WeeklyRecurrence value) weekly,
    required TResult Function(MonthlyRecurrence value) monthly,
    required TResult Function(YearlyRecurrence value) yearly,
  }) {
    return daily(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRecurrence value)? daily,
    TResult? Function(WeeklyRecurrence value)? weekly,
    TResult? Function(MonthlyRecurrence value)? monthly,
    TResult? Function(YearlyRecurrence value)? yearly,
  }) {
    return daily?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRecurrence value)? daily,
    TResult Function(WeeklyRecurrence value)? weekly,
    TResult Function(MonthlyRecurrence value)? monthly,
    TResult Function(YearlyRecurrence value)? yearly,
    required TResult orElse(),
  }) {
    if (daily != null) {
      return daily(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyRecurrenceImplToJson(
      this,
    );
  }
}

abstract class DailyRecurrence extends RecurrencePattern {
  const factory DailyRecurrence({final int interval}) = _$DailyRecurrenceImpl;
  const DailyRecurrence._() : super._();

  factory DailyRecurrence.fromJson(Map<String, dynamic> json) =
      _$DailyRecurrenceImpl.fromJson;

  int get interval;

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyRecurrenceImplCopyWith<_$DailyRecurrenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$WeeklyRecurrenceImplCopyWith<$Res> {
  factory _$$WeeklyRecurrenceImplCopyWith(_$WeeklyRecurrenceImpl value,
          $Res Function(_$WeeklyRecurrenceImpl) then) =
      __$$WeeklyRecurrenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<int> weekdays, int interval});
}

/// @nodoc
class __$$WeeklyRecurrenceImplCopyWithImpl<$Res>
    extends _$RecurrencePatternCopyWithImpl<$Res, _$WeeklyRecurrenceImpl>
    implements _$$WeeklyRecurrenceImplCopyWith<$Res> {
  __$$WeeklyRecurrenceImplCopyWithImpl(_$WeeklyRecurrenceImpl _value,
      $Res Function(_$WeeklyRecurrenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekdays = null,
    Object? interval = null,
  }) {
    return _then(_$WeeklyRecurrenceImpl(
      weekdays: null == weekdays
          ? _value._weekdays
          : weekdays // ignore: cast_nullable_to_non_nullable
              as List<int>,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeeklyRecurrenceImpl extends WeeklyRecurrence {
  const _$WeeklyRecurrenceImpl(
      {required final List<int> weekdays,
      this.interval = 1,
      final String? $type})
      : _weekdays = weekdays,
        $type = $type ?? 'weekly',
        super._();

  factory _$WeeklyRecurrenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeeklyRecurrenceImplFromJson(json);

  final List<int> _weekdays;
  @override
  List<int> get weekdays {
    if (_weekdays is EqualUnmodifiableListView) return _weekdays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_weekdays);
  }

  @override
  @JsonKey()
  final int interval;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecurrencePattern.weekly(weekdays: $weekdays, interval: $interval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeeklyRecurrenceImpl &&
            const DeepCollectionEquality().equals(other._weekdays, _weekdays) &&
            (identical(other.interval, interval) ||
                other.interval == interval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_weekdays), interval);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeeklyRecurrenceImplCopyWith<_$WeeklyRecurrenceImpl> get copyWith =>
      __$$WeeklyRecurrenceImplCopyWithImpl<_$WeeklyRecurrenceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int interval) daily,
    required TResult Function(List<int> weekdays, int interval) weekly,
    required TResult Function(int? dayOfMonth, int interval) monthly,
    required TResult Function(int month, int? dayOfMonth) yearly,
  }) {
    return weekly(weekdays, interval);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int interval)? daily,
    TResult? Function(List<int> weekdays, int interval)? weekly,
    TResult? Function(int? dayOfMonth, int interval)? monthly,
    TResult? Function(int month, int? dayOfMonth)? yearly,
  }) {
    return weekly?.call(weekdays, interval);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int interval)? daily,
    TResult Function(List<int> weekdays, int interval)? weekly,
    TResult Function(int? dayOfMonth, int interval)? monthly,
    TResult Function(int month, int? dayOfMonth)? yearly,
    required TResult orElse(),
  }) {
    if (weekly != null) {
      return weekly(weekdays, interval);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRecurrence value) daily,
    required TResult Function(WeeklyRecurrence value) weekly,
    required TResult Function(MonthlyRecurrence value) monthly,
    required TResult Function(YearlyRecurrence value) yearly,
  }) {
    return weekly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRecurrence value)? daily,
    TResult? Function(WeeklyRecurrence value)? weekly,
    TResult? Function(MonthlyRecurrence value)? monthly,
    TResult? Function(YearlyRecurrence value)? yearly,
  }) {
    return weekly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRecurrence value)? daily,
    TResult Function(WeeklyRecurrence value)? weekly,
    TResult Function(MonthlyRecurrence value)? monthly,
    TResult Function(YearlyRecurrence value)? yearly,
    required TResult orElse(),
  }) {
    if (weekly != null) {
      return weekly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WeeklyRecurrenceImplToJson(
      this,
    );
  }
}

abstract class WeeklyRecurrence extends RecurrencePattern {
  const factory WeeklyRecurrence(
      {required final List<int> weekdays,
      final int interval}) = _$WeeklyRecurrenceImpl;
  const WeeklyRecurrence._() : super._();

  factory WeeklyRecurrence.fromJson(Map<String, dynamic> json) =
      _$WeeklyRecurrenceImpl.fromJson;

  List<int> get weekdays;
  int get interval;

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeeklyRecurrenceImplCopyWith<_$WeeklyRecurrenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MonthlyRecurrenceImplCopyWith<$Res> {
  factory _$$MonthlyRecurrenceImplCopyWith(_$MonthlyRecurrenceImpl value,
          $Res Function(_$MonthlyRecurrenceImpl) then) =
      __$$MonthlyRecurrenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int? dayOfMonth, int interval});
}

/// @nodoc
class __$$MonthlyRecurrenceImplCopyWithImpl<$Res>
    extends _$RecurrencePatternCopyWithImpl<$Res, _$MonthlyRecurrenceImpl>
    implements _$$MonthlyRecurrenceImplCopyWith<$Res> {
  __$$MonthlyRecurrenceImplCopyWithImpl(_$MonthlyRecurrenceImpl _value,
      $Res Function(_$MonthlyRecurrenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayOfMonth = freezed,
    Object? interval = null,
  }) {
    return _then(_$MonthlyRecurrenceImpl(
      dayOfMonth: freezed == dayOfMonth
          ? _value.dayOfMonth
          : dayOfMonth // ignore: cast_nullable_to_non_nullable
              as int?,
      interval: null == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyRecurrenceImpl extends MonthlyRecurrence {
  const _$MonthlyRecurrenceImpl(
      {this.dayOfMonth, this.interval = 1, final String? $type})
      : $type = $type ?? 'monthly',
        super._();

  factory _$MonthlyRecurrenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyRecurrenceImplFromJson(json);

  @override
  final int? dayOfMonth;
  @override
  @JsonKey()
  final int interval;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecurrencePattern.monthly(dayOfMonth: $dayOfMonth, interval: $interval)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyRecurrenceImpl &&
            (identical(other.dayOfMonth, dayOfMonth) ||
                other.dayOfMonth == dayOfMonth) &&
            (identical(other.interval, interval) ||
                other.interval == interval));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, dayOfMonth, interval);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyRecurrenceImplCopyWith<_$MonthlyRecurrenceImpl> get copyWith =>
      __$$MonthlyRecurrenceImplCopyWithImpl<_$MonthlyRecurrenceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int interval) daily,
    required TResult Function(List<int> weekdays, int interval) weekly,
    required TResult Function(int? dayOfMonth, int interval) monthly,
    required TResult Function(int month, int? dayOfMonth) yearly,
  }) {
    return monthly(dayOfMonth, interval);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int interval)? daily,
    TResult? Function(List<int> weekdays, int interval)? weekly,
    TResult? Function(int? dayOfMonth, int interval)? monthly,
    TResult? Function(int month, int? dayOfMonth)? yearly,
  }) {
    return monthly?.call(dayOfMonth, interval);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int interval)? daily,
    TResult Function(List<int> weekdays, int interval)? weekly,
    TResult Function(int? dayOfMonth, int interval)? monthly,
    TResult Function(int month, int? dayOfMonth)? yearly,
    required TResult orElse(),
  }) {
    if (monthly != null) {
      return monthly(dayOfMonth, interval);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRecurrence value) daily,
    required TResult Function(WeeklyRecurrence value) weekly,
    required TResult Function(MonthlyRecurrence value) monthly,
    required TResult Function(YearlyRecurrence value) yearly,
  }) {
    return monthly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRecurrence value)? daily,
    TResult? Function(WeeklyRecurrence value)? weekly,
    TResult? Function(MonthlyRecurrence value)? monthly,
    TResult? Function(YearlyRecurrence value)? yearly,
  }) {
    return monthly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRecurrence value)? daily,
    TResult Function(WeeklyRecurrence value)? weekly,
    TResult Function(MonthlyRecurrence value)? monthly,
    TResult Function(YearlyRecurrence value)? yearly,
    required TResult orElse(),
  }) {
    if (monthly != null) {
      return monthly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyRecurrenceImplToJson(
      this,
    );
  }
}

abstract class MonthlyRecurrence extends RecurrencePattern {
  const factory MonthlyRecurrence({final int? dayOfMonth, final int interval}) =
      _$MonthlyRecurrenceImpl;
  const MonthlyRecurrence._() : super._();

  factory MonthlyRecurrence.fromJson(Map<String, dynamic> json) =
      _$MonthlyRecurrenceImpl.fromJson;

  int? get dayOfMonth;
  int get interval;

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyRecurrenceImplCopyWith<_$MonthlyRecurrenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$YearlyRecurrenceImplCopyWith<$Res> {
  factory _$$YearlyRecurrenceImplCopyWith(_$YearlyRecurrenceImpl value,
          $Res Function(_$YearlyRecurrenceImpl) then) =
      __$$YearlyRecurrenceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int month, int? dayOfMonth});
}

/// @nodoc
class __$$YearlyRecurrenceImplCopyWithImpl<$Res>
    extends _$RecurrencePatternCopyWithImpl<$Res, _$YearlyRecurrenceImpl>
    implements _$$YearlyRecurrenceImplCopyWith<$Res> {
  __$$YearlyRecurrenceImplCopyWithImpl(_$YearlyRecurrenceImpl _value,
      $Res Function(_$YearlyRecurrenceImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? dayOfMonth = freezed,
  }) {
    return _then(_$YearlyRecurrenceImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      dayOfMonth: freezed == dayOfMonth
          ? _value.dayOfMonth
          : dayOfMonth // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$YearlyRecurrenceImpl extends YearlyRecurrence {
  const _$YearlyRecurrenceImpl(
      {required this.month, this.dayOfMonth, final String? $type})
      : $type = $type ?? 'yearly',
        super._();

  factory _$YearlyRecurrenceImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearlyRecurrenceImplFromJson(json);

  @override
  final int month;
  @override
  final int? dayOfMonth;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'RecurrencePattern.yearly(month: $month, dayOfMonth: $dayOfMonth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearlyRecurrenceImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.dayOfMonth, dayOfMonth) ||
                other.dayOfMonth == dayOfMonth));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, dayOfMonth);

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearlyRecurrenceImplCopyWith<_$YearlyRecurrenceImpl> get copyWith =>
      __$$YearlyRecurrenceImplCopyWithImpl<_$YearlyRecurrenceImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int interval) daily,
    required TResult Function(List<int> weekdays, int interval) weekly,
    required TResult Function(int? dayOfMonth, int interval) monthly,
    required TResult Function(int month, int? dayOfMonth) yearly,
  }) {
    return yearly(month, dayOfMonth);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(int interval)? daily,
    TResult? Function(List<int> weekdays, int interval)? weekly,
    TResult? Function(int? dayOfMonth, int interval)? monthly,
    TResult? Function(int month, int? dayOfMonth)? yearly,
  }) {
    return yearly?.call(month, dayOfMonth);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int interval)? daily,
    TResult Function(List<int> weekdays, int interval)? weekly,
    TResult Function(int? dayOfMonth, int interval)? monthly,
    TResult Function(int month, int? dayOfMonth)? yearly,
    required TResult orElse(),
  }) {
    if (yearly != null) {
      return yearly(month, dayOfMonth);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(DailyRecurrence value) daily,
    required TResult Function(WeeklyRecurrence value) weekly,
    required TResult Function(MonthlyRecurrence value) monthly,
    required TResult Function(YearlyRecurrence value) yearly,
  }) {
    return yearly(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(DailyRecurrence value)? daily,
    TResult? Function(WeeklyRecurrence value)? weekly,
    TResult? Function(MonthlyRecurrence value)? monthly,
    TResult? Function(YearlyRecurrence value)? yearly,
  }) {
    return yearly?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(DailyRecurrence value)? daily,
    TResult Function(WeeklyRecurrence value)? weekly,
    TResult Function(MonthlyRecurrence value)? monthly,
    TResult Function(YearlyRecurrence value)? yearly,
    required TResult orElse(),
  }) {
    if (yearly != null) {
      return yearly(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$YearlyRecurrenceImplToJson(
      this,
    );
  }
}

abstract class YearlyRecurrence extends RecurrencePattern {
  const factory YearlyRecurrence(
      {required final int month,
      final int? dayOfMonth}) = _$YearlyRecurrenceImpl;
  const YearlyRecurrence._() : super._();

  factory YearlyRecurrence.fromJson(Map<String, dynamic> json) =
      _$YearlyRecurrenceImpl.fromJson;

  int get month;
  int? get dayOfMonth;

  /// Create a copy of RecurrencePattern
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearlyRecurrenceImplCopyWith<_$YearlyRecurrenceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaningIcon _$TaningIconFromJson(Map<String, dynamic> json) {
  return _TaningIcon.fromJson(json);
}

/// @nodoc
mixin _$TaningIcon {
  int get codePoint => throw _privateConstructorUsedError;
  String? get family => throw _privateConstructorUsedError;

  /// Serializes this TaningIcon to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaningIcon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaningIconCopyWith<TaningIcon> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaningIconCopyWith<$Res> {
  factory $TaningIconCopyWith(
          TaningIcon value, $Res Function(TaningIcon) then) =
      _$TaningIconCopyWithImpl<$Res, TaningIcon>;
  @useResult
  $Res call({int codePoint, String? family});
}

/// @nodoc
class _$TaningIconCopyWithImpl<$Res, $Val extends TaningIcon>
    implements $TaningIconCopyWith<$Res> {
  _$TaningIconCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaningIcon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codePoint = null,
    Object? family = freezed,
  }) {
    return _then(_value.copyWith(
      codePoint: null == codePoint
          ? _value.codePoint
          : codePoint // ignore: cast_nullable_to_non_nullable
              as int,
      family: freezed == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaningIconImplCopyWith<$Res>
    implements $TaningIconCopyWith<$Res> {
  factory _$$TaningIconImplCopyWith(
          _$TaningIconImpl value, $Res Function(_$TaningIconImpl) then) =
      __$$TaningIconImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int codePoint, String? family});
}

/// @nodoc
class __$$TaningIconImplCopyWithImpl<$Res>
    extends _$TaningIconCopyWithImpl<$Res, _$TaningIconImpl>
    implements _$$TaningIconImplCopyWith<$Res> {
  __$$TaningIconImplCopyWithImpl(
      _$TaningIconImpl _value, $Res Function(_$TaningIconImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaningIcon
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? codePoint = null,
    Object? family = freezed,
  }) {
    return _then(_$TaningIconImpl(
      codePoint: null == codePoint
          ? _value.codePoint
          : codePoint // ignore: cast_nullable_to_non_nullable
              as int,
      family: freezed == family
          ? _value.family
          : family // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaningIconImpl extends _TaningIcon {
  const _$TaningIconImpl({required this.codePoint, this.family}) : super._();

  factory _$TaningIconImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaningIconImplFromJson(json);

  @override
  final int codePoint;
  @override
  final String? family;

  @override
  String toString() {
    return 'TaningIcon(codePoint: $codePoint, family: $family)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaningIconImpl &&
            (identical(other.codePoint, codePoint) ||
                other.codePoint == codePoint) &&
            (identical(other.family, family) || other.family == family));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, codePoint, family);

  /// Create a copy of TaningIcon
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaningIconImplCopyWith<_$TaningIconImpl> get copyWith =>
      __$$TaningIconImplCopyWithImpl<_$TaningIconImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaningIconImplToJson(
      this,
    );
  }
}

abstract class _TaningIcon extends TaningIcon {
  const factory _TaningIcon(
      {required final int codePoint, final String? family}) = _$TaningIconImpl;
  const _TaningIcon._() : super._();

  factory _TaningIcon.fromJson(Map<String, dynamic> json) =
      _$TaningIconImpl.fromJson;

  @override
  int get codePoint;
  @override
  String? get family;

  /// Create a copy of TaningIcon
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaningIconImplCopyWith<_$TaningIconImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaningColor _$TaningColorFromJson(Map<String, dynamic> json) {
  return _TaningColor.fromJson(json);
}

/// @nodoc
mixin _$TaningColor {
  int get value => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  /// Serializes this TaningColor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaningColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaningColorCopyWith<TaningColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaningColorCopyWith<$Res> {
  factory $TaningColorCopyWith(
          TaningColor value, $Res Function(TaningColor) then) =
      _$TaningColorCopyWithImpl<$Res, TaningColor>;
  @useResult
  $Res call({int value, String? name});
}

/// @nodoc
class _$TaningColorCopyWithImpl<$Res, $Val extends TaningColor>
    implements $TaningColorCopyWith<$Res> {
  _$TaningColorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaningColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaningColorImplCopyWith<$Res>
    implements $TaningColorCopyWith<$Res> {
  factory _$$TaningColorImplCopyWith(
          _$TaningColorImpl value, $Res Function(_$TaningColorImpl) then) =
      __$$TaningColorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int value, String? name});
}

/// @nodoc
class __$$TaningColorImplCopyWithImpl<$Res>
    extends _$TaningColorCopyWithImpl<$Res, _$TaningColorImpl>
    implements _$$TaningColorImplCopyWith<$Res> {
  __$$TaningColorImplCopyWithImpl(
      _$TaningColorImpl _value, $Res Function(_$TaningColorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaningColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
    Object? name = freezed,
  }) {
    return _then(_$TaningColorImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaningColorImpl extends _TaningColor {
  const _$TaningColorImpl({required this.value, this.name}) : super._();

  factory _$TaningColorImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaningColorImplFromJson(json);

  @override
  final int value;
  @override
  final String? name;

  @override
  String toString() {
    return 'TaningColor(value: $value, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaningColorImpl &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value, name);

  /// Create a copy of TaningColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaningColorImplCopyWith<_$TaningColorImpl> get copyWith =>
      __$$TaningColorImplCopyWithImpl<_$TaningColorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaningColorImplToJson(
      this,
    );
  }
}

abstract class _TaningColor extends TaningColor {
  const factory _TaningColor({required final int value, final String? name}) =
      _$TaningColorImpl;
  const _TaningColor._() : super._();

  factory _TaningColor.fromJson(Map<String, dynamic> json) =
      _$TaningColorImpl.fromJson;

  @override
  int get value;
  @override
  String? get name;

  /// Create a copy of TaningColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaningColorImplCopyWith<_$TaningColorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationSettings _$NotificationSettingsFromJson(Map<String, dynamic> json) {
  return _NotificationSettings.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettings {
  bool get enabled => throw _privateConstructorUsedError;
  bool get oneDayBefore => throw _privateConstructorUsedError;
  bool get threeDaysBefore => throw _privateConstructorUsedError;
  bool get sevenDaysBefore => throw _privateConstructorUsedError;
  bool get oneHourBefore => throw _privateConstructorUsedError;
  bool get thirtyMinutesBefore => throw _privateConstructorUsedError;
  bool get atExactTime => throw _privateConstructorUsedError;
  bool? get customNotification => throw _privateConstructorUsedError;
  int? get customMinutesBefore => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsCopyWith<NotificationSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsCopyWith<$Res> {
  factory $NotificationSettingsCopyWith(NotificationSettings value,
          $Res Function(NotificationSettings) then) =
      _$NotificationSettingsCopyWithImpl<$Res, NotificationSettings>;
  @useResult
  $Res call(
      {bool enabled,
      bool oneDayBefore,
      bool threeDaysBefore,
      bool sevenDaysBefore,
      bool oneHourBefore,
      bool thirtyMinutesBefore,
      bool atExactTime,
      bool? customNotification,
      int? customMinutesBefore});
}

/// @nodoc
class _$NotificationSettingsCopyWithImpl<$Res,
        $Val extends NotificationSettings>
    implements $NotificationSettingsCopyWith<$Res> {
  _$NotificationSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? oneDayBefore = null,
    Object? threeDaysBefore = null,
    Object? sevenDaysBefore = null,
    Object? oneHourBefore = null,
    Object? thirtyMinutesBefore = null,
    Object? atExactTime = null,
    Object? customNotification = freezed,
    Object? customMinutesBefore = freezed,
  }) {
    return _then(_value.copyWith(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      oneDayBefore: null == oneDayBefore
          ? _value.oneDayBefore
          : oneDayBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      threeDaysBefore: null == threeDaysBefore
          ? _value.threeDaysBefore
          : threeDaysBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      sevenDaysBefore: null == sevenDaysBefore
          ? _value.sevenDaysBefore
          : sevenDaysBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      oneHourBefore: null == oneHourBefore
          ? _value.oneHourBefore
          : oneHourBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      thirtyMinutesBefore: null == thirtyMinutesBefore
          ? _value.thirtyMinutesBefore
          : thirtyMinutesBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      atExactTime: null == atExactTime
          ? _value.atExactTime
          : atExactTime // ignore: cast_nullable_to_non_nullable
              as bool,
      customNotification: freezed == customNotification
          ? _value.customNotification
          : customNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      customMinutesBefore: freezed == customMinutesBefore
          ? _value.customMinutesBefore
          : customMinutesBefore // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsImplCopyWith<$Res>
    implements $NotificationSettingsCopyWith<$Res> {
  factory _$$NotificationSettingsImplCopyWith(_$NotificationSettingsImpl value,
          $Res Function(_$NotificationSettingsImpl) then) =
      __$$NotificationSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool enabled,
      bool oneDayBefore,
      bool threeDaysBefore,
      bool sevenDaysBefore,
      bool oneHourBefore,
      bool thirtyMinutesBefore,
      bool atExactTime,
      bool? customNotification,
      int? customMinutesBefore});
}

/// @nodoc
class __$$NotificationSettingsImplCopyWithImpl<$Res>
    extends _$NotificationSettingsCopyWithImpl<$Res, _$NotificationSettingsImpl>
    implements _$$NotificationSettingsImplCopyWith<$Res> {
  __$$NotificationSettingsImplCopyWithImpl(_$NotificationSettingsImpl _value,
      $Res Function(_$NotificationSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enabled = null,
    Object? oneDayBefore = null,
    Object? threeDaysBefore = null,
    Object? sevenDaysBefore = null,
    Object? oneHourBefore = null,
    Object? thirtyMinutesBefore = null,
    Object? atExactTime = null,
    Object? customNotification = freezed,
    Object? customMinutesBefore = freezed,
  }) {
    return _then(_$NotificationSettingsImpl(
      enabled: null == enabled
          ? _value.enabled
          : enabled // ignore: cast_nullable_to_non_nullable
              as bool,
      oneDayBefore: null == oneDayBefore
          ? _value.oneDayBefore
          : oneDayBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      threeDaysBefore: null == threeDaysBefore
          ? _value.threeDaysBefore
          : threeDaysBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      sevenDaysBefore: null == sevenDaysBefore
          ? _value.sevenDaysBefore
          : sevenDaysBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      oneHourBefore: null == oneHourBefore
          ? _value.oneHourBefore
          : oneHourBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      thirtyMinutesBefore: null == thirtyMinutesBefore
          ? _value.thirtyMinutesBefore
          : thirtyMinutesBefore // ignore: cast_nullable_to_non_nullable
              as bool,
      atExactTime: null == atExactTime
          ? _value.atExactTime
          : atExactTime // ignore: cast_nullable_to_non_nullable
              as bool,
      customNotification: freezed == customNotification
          ? _value.customNotification
          : customNotification // ignore: cast_nullable_to_non_nullable
              as bool?,
      customMinutesBefore: freezed == customMinutesBefore
          ? _value.customMinutesBefore
          : customMinutesBefore // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsImpl extends _NotificationSettings {
  const _$NotificationSettingsImpl(
      {required this.enabled,
      required this.oneDayBefore,
      required this.threeDaysBefore,
      required this.sevenDaysBefore,
      required this.oneHourBefore,
      required this.thirtyMinutesBefore,
      required this.atExactTime,
      this.customNotification,
      this.customMinutesBefore})
      : super._();

  factory _$NotificationSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsImplFromJson(json);

  @override
  final bool enabled;
  @override
  final bool oneDayBefore;
  @override
  final bool threeDaysBefore;
  @override
  final bool sevenDaysBefore;
  @override
  final bool oneHourBefore;
  @override
  final bool thirtyMinutesBefore;
  @override
  final bool atExactTime;
  @override
  final bool? customNotification;
  @override
  final int? customMinutesBefore;

  @override
  String toString() {
    return 'NotificationSettings(enabled: $enabled, oneDayBefore: $oneDayBefore, threeDaysBefore: $threeDaysBefore, sevenDaysBefore: $sevenDaysBefore, oneHourBefore: $oneHourBefore, thirtyMinutesBefore: $thirtyMinutesBefore, atExactTime: $atExactTime, customNotification: $customNotification, customMinutesBefore: $customMinutesBefore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsImpl &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.oneDayBefore, oneDayBefore) ||
                other.oneDayBefore == oneDayBefore) &&
            (identical(other.threeDaysBefore, threeDaysBefore) ||
                other.threeDaysBefore == threeDaysBefore) &&
            (identical(other.sevenDaysBefore, sevenDaysBefore) ||
                other.sevenDaysBefore == sevenDaysBefore) &&
            (identical(other.oneHourBefore, oneHourBefore) ||
                other.oneHourBefore == oneHourBefore) &&
            (identical(other.thirtyMinutesBefore, thirtyMinutesBefore) ||
                other.thirtyMinutesBefore == thirtyMinutesBefore) &&
            (identical(other.atExactTime, atExactTime) ||
                other.atExactTime == atExactTime) &&
            (identical(other.customNotification, customNotification) ||
                other.customNotification == customNotification) &&
            (identical(other.customMinutesBefore, customMinutesBefore) ||
                other.customMinutesBefore == customMinutesBefore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      enabled,
      oneDayBefore,
      threeDaysBefore,
      sevenDaysBefore,
      oneHourBefore,
      thirtyMinutesBefore,
      atExactTime,
      customNotification,
      customMinutesBefore);

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith =>
          __$$NotificationSettingsImplCopyWithImpl<_$NotificationSettingsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettings extends NotificationSettings {
  const factory _NotificationSettings(
      {required final bool enabled,
      required final bool oneDayBefore,
      required final bool threeDaysBefore,
      required final bool sevenDaysBefore,
      required final bool oneHourBefore,
      required final bool thirtyMinutesBefore,
      required final bool atExactTime,
      final bool? customNotification,
      final int? customMinutesBefore}) = _$NotificationSettingsImpl;
  const _NotificationSettings._() : super._();

  factory _NotificationSettings.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsImpl.fromJson;

  @override
  bool get enabled;
  @override
  bool get oneDayBefore;
  @override
  bool get threeDaysBefore;
  @override
  bool get sevenDaysBefore;
  @override
  bool get oneHourBefore;
  @override
  bool get thirtyMinutesBefore;
  @override
  bool get atExactTime;
  @override
  bool? get customNotification;
  @override
  int? get customMinutesBefore;

  /// Create a copy of NotificationSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsImplCopyWith<_$NotificationSettingsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$NotificationTime {
  DateTime get time => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;

  /// Create a copy of NotificationTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationTimeCopyWith<NotificationTime> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationTimeCopyWith<$Res> {
  factory $NotificationTimeCopyWith(
          NotificationTime value, $Res Function(NotificationTime) then) =
      _$NotificationTimeCopyWithImpl<$Res, NotificationTime>;
  @useResult
  $Res call({DateTime time, NotificationType type});
}

/// @nodoc
class _$NotificationTimeCopyWithImpl<$Res, $Val extends NotificationTime>
    implements $NotificationTimeCopyWith<$Res> {
  _$NotificationTimeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationTimeImplCopyWith<$Res>
    implements $NotificationTimeCopyWith<$Res> {
  factory _$$NotificationTimeImplCopyWith(_$NotificationTimeImpl value,
          $Res Function(_$NotificationTimeImpl) then) =
      __$$NotificationTimeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime time, NotificationType type});
}

/// @nodoc
class __$$NotificationTimeImplCopyWithImpl<$Res>
    extends _$NotificationTimeCopyWithImpl<$Res, _$NotificationTimeImpl>
    implements _$$NotificationTimeImplCopyWith<$Res> {
  __$$NotificationTimeImplCopyWithImpl(_$NotificationTimeImpl _value,
      $Res Function(_$NotificationTimeImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationTime
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? type = null,
  }) {
    return _then(_$NotificationTimeImpl(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
    ));
  }
}

/// @nodoc

class _$NotificationTimeImpl implements _NotificationTime {
  const _$NotificationTimeImpl({required this.time, required this.type});

  @override
  final DateTime time;
  @override
  final NotificationType type;

  @override
  String toString() {
    return 'NotificationTime(time: $time, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationTimeImpl &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, time, type);

  /// Create a copy of NotificationTime
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationTimeImplCopyWith<_$NotificationTimeImpl> get copyWith =>
      __$$NotificationTimeImplCopyWithImpl<_$NotificationTimeImpl>(
          this, _$identity);
}

abstract class _NotificationTime implements NotificationTime {
  const factory _NotificationTime(
      {required final DateTime time,
      required final NotificationType type}) = _$NotificationTimeImpl;

  @override
  DateTime get time;
  @override
  NotificationType get type;

  /// Create a copy of NotificationTime
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationTimeImplCopyWith<_$NotificationTimeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
