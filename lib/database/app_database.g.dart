// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TaningTableTable extends TaningTable
    with TableInfo<$TaningTableTable, TaningTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaningTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<TaningType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TaningType>($TaningTableTable.$convertertype);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<TaningTheme, int> theme =
      GeneratedColumn<int>('theme', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<TaningTheme>($TaningTableTable.$convertertheme);
  @override
  late final GeneratedColumnWithTypeConverter<CountdownStyle, int>
      countdownStyle = GeneratedColumn<int>(
              'countdown_style', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<CountdownStyle>(
              $TaningTableTable.$convertercountdownStyle);
  static const VerificationMeta _notificationSettingsMeta =
      const VerificationMeta('notificationSettings');
  @override
  late final GeneratedColumn<String> notificationSettings =
      GeneratedColumn<String>('notification_settings', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
      'is_completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_completed" IN (0, 1))'));
  static const VerificationMeta _isArchivedMeta =
      const VerificationMeta('isArchived');
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
      'is_archived', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_archived" IN (0, 1))'));
  static const VerificationMeta _isPinnedMeta =
      const VerificationMeta('isPinned');
  @override
  late final GeneratedColumn<bool> isPinned = GeneratedColumn<bool>(
      'is_pinned', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_pinned" IN (0, 1))'));
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastNotifiedAtMeta =
      const VerificationMeta('lastNotifiedAt');
  @override
  late final GeneratedColumn<DateTime> lastNotifiedAt =
      GeneratedColumn<DateTime>('last_notified_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _recurrenceMeta =
      const VerificationMeta('recurrence');
  @override
  late final GeneratedColumn<String> recurrence = GeneratedColumn<String>(
      'recurrence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isAllDayMeta =
      const VerificationMeta('isAllDay');
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
      'is_all_day', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_all_day" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
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
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'taning_table';
  @override
  VerificationContext validateIntegrity(Insertable<TaningTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('notification_settings')) {
      context.handle(
          _notificationSettingsMeta,
          notificationSettings.isAcceptableOrUnknown(
              data['notification_settings']!, _notificationSettingsMeta));
    } else if (isInserting) {
      context.missing(_notificationSettingsMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    } else if (isInserting) {
      context.missing(_isCompletedMeta);
    }
    if (data.containsKey('is_archived')) {
      context.handle(
          _isArchivedMeta,
          isArchived.isAcceptableOrUnknown(
              data['is_archived']!, _isArchivedMeta));
    } else if (isInserting) {
      context.missing(_isArchivedMeta);
    }
    if (data.containsKey('is_pinned')) {
      context.handle(_isPinnedMeta,
          isPinned.isAcceptableOrUnknown(data['is_pinned']!, _isPinnedMeta));
    } else if (isInserting) {
      context.missing(_isPinnedMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    if (data.containsKey('last_notified_at')) {
      context.handle(
          _lastNotifiedAtMeta,
          lastNotifiedAt.isAcceptableOrUnknown(
              data['last_notified_at']!, _lastNotifiedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('recurrence')) {
      context.handle(
          _recurrenceMeta,
          recurrence.isAcceptableOrUnknown(
              data['recurrence']!, _recurrenceMeta));
    }
    if (data.containsKey('is_all_day')) {
      context.handle(_isAllDayMeta,
          isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {id},
      ];
  @override
  TaningTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaningTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: $TaningTableTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color'])!,
      theme: $TaningTableTable.$convertertheme.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}theme'])!),
      countdownStyle: $TaningTableTable.$convertercountdownStyle.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}countdown_style'])!),
      notificationSettings: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}notification_settings'])!,
      isCompleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_completed'])!,
      isArchived: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_archived'])!,
      isPinned: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_pinned'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
      lastNotifiedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_notified_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id']),
      recurrence: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}recurrence']),
      isAllDay: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_all_day']),
    );
  }

  @override
  $TaningTableTable createAlias(String alias) {
    return $TaningTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TaningType, int, int> $convertertype =
      const EnumIndexConverter<TaningType>(TaningType.values);
  static JsonTypeConverter2<TaningTheme, int, int> $convertertheme =
      const EnumIndexConverter<TaningTheme>(TaningTheme.values);
  static JsonTypeConverter2<CountdownStyle, int, int> $convertercountdownStyle =
      const EnumIndexConverter<CountdownStyle>(CountdownStyle.values);
}

class TaningTableData extends DataClass implements Insertable<TaningTableData> {
  final String id;
  final String title;
  final String? description;
  final TaningType type;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? timezone;
  final String icon;
  final String color;
  final TaningTheme theme;
  final CountdownStyle countdownStyle;
  final String notificationSettings;
  final bool isCompleted;
  final bool isArchived;
  final bool isPinned;
  final DateTime? completedAt;
  final DateTime? lastNotifiedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? categoryId;
  final String? recurrence;
  final bool? isAllDay;
  const TaningTableData(
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
      this.isAllDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['type'] = Variable<int>($TaningTableTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<String>(color);
    {
      map['theme'] =
          Variable<int>($TaningTableTable.$convertertheme.toSql(theme));
    }
    {
      map['countdown_style'] = Variable<int>(
          $TaningTableTable.$convertercountdownStyle.toSql(countdownStyle));
    }
    map['notification_settings'] = Variable<String>(notificationSettings);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_pinned'] = Variable<bool>(isPinned);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || lastNotifiedAt != null) {
      map['last_notified_at'] = Variable<DateTime>(lastNotifiedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || recurrence != null) {
      map['recurrence'] = Variable<String>(recurrence);
    }
    if (!nullToAbsent || isAllDay != null) {
      map['is_all_day'] = Variable<bool>(isAllDay);
    }
    return map;
  }

  TaningTableCompanion toCompanion(bool nullToAbsent) {
    return TaningTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      type: Value(type),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      icon: Value(icon),
      color: Value(color),
      theme: Value(theme),
      countdownStyle: Value(countdownStyle),
      notificationSettings: Value(notificationSettings),
      isCompleted: Value(isCompleted),
      isArchived: Value(isArchived),
      isPinned: Value(isPinned),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      lastNotifiedAt: lastNotifiedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastNotifiedAt),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      recurrence: recurrence == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrence),
      isAllDay: isAllDay == null && nullToAbsent
          ? const Value.absent()
          : Value(isAllDay),
    );
  }

  factory TaningTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaningTableData(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      type: $TaningTableTable.$convertertype
          .fromJson(serializer.fromJson<int>(json['type'])),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<String>(json['color']),
      theme: $TaningTableTable.$convertertheme
          .fromJson(serializer.fromJson<int>(json['theme'])),
      countdownStyle: $TaningTableTable.$convertercountdownStyle
          .fromJson(serializer.fromJson<int>(json['countdownStyle'])),
      notificationSettings:
          serializer.fromJson<String>(json['notificationSettings']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isPinned: serializer.fromJson<bool>(json['isPinned']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      lastNotifiedAt: serializer.fromJson<DateTime?>(json['lastNotifiedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      recurrence: serializer.fromJson<String?>(json['recurrence']),
      isAllDay: serializer.fromJson<bool?>(json['isAllDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'type':
          serializer.toJson<int>($TaningTableTable.$convertertype.toJson(type)),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'timezone': serializer.toJson<String?>(timezone),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<String>(color),
      'theme': serializer
          .toJson<int>($TaningTableTable.$convertertheme.toJson(theme)),
      'countdownStyle': serializer.toJson<int>(
          $TaningTableTable.$convertercountdownStyle.toJson(countdownStyle)),
      'notificationSettings': serializer.toJson<String>(notificationSettings),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isPinned': serializer.toJson<bool>(isPinned),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'lastNotifiedAt': serializer.toJson<DateTime?>(lastNotifiedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'categoryId': serializer.toJson<String?>(categoryId),
      'recurrence': serializer.toJson<String?>(recurrence),
      'isAllDay': serializer.toJson<bool?>(isAllDay),
    };
  }

  TaningTableData copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          TaningType? type,
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent(),
          Value<String?> timezone = const Value.absent(),
          String? icon,
          String? color,
          TaningTheme? theme,
          CountdownStyle? countdownStyle,
          String? notificationSettings,
          bool? isCompleted,
          bool? isArchived,
          bool? isPinned,
          Value<DateTime?> completedAt = const Value.absent(),
          Value<DateTime?> lastNotifiedAt = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          Value<String?> categoryId = const Value.absent(),
          Value<String?> recurrence = const Value.absent(),
          Value<bool?> isAllDay = const Value.absent()}) =>
      TaningTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        type: type ?? this.type,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        timezone: timezone.present ? timezone.value : this.timezone,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        theme: theme ?? this.theme,
        countdownStyle: countdownStyle ?? this.countdownStyle,
        notificationSettings: notificationSettings ?? this.notificationSettings,
        isCompleted: isCompleted ?? this.isCompleted,
        isArchived: isArchived ?? this.isArchived,
        isPinned: isPinned ?? this.isPinned,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
        lastNotifiedAt:
            lastNotifiedAt.present ? lastNotifiedAt.value : this.lastNotifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        recurrence: recurrence.present ? recurrence.value : this.recurrence,
        isAllDay: isAllDay.present ? isAllDay.value : this.isAllDay,
      );
  TaningTableData copyWithCompanion(TaningTableCompanion data) {
    return TaningTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      type: data.type.present ? data.type.value : this.type,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      theme: data.theme.present ? data.theme.value : this.theme,
      countdownStyle: data.countdownStyle.present
          ? data.countdownStyle.value
          : this.countdownStyle,
      notificationSettings: data.notificationSettings.present
          ? data.notificationSettings.value
          : this.notificationSettings,
      isCompleted:
          data.isCompleted.present ? data.isCompleted.value : this.isCompleted,
      isArchived:
          data.isArchived.present ? data.isArchived.value : this.isArchived,
      isPinned: data.isPinned.present ? data.isPinned.value : this.isPinned,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
      lastNotifiedAt: data.lastNotifiedAt.present
          ? data.lastNotifiedAt.value
          : this.lastNotifiedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      recurrence:
          data.recurrence.present ? data.recurrence.value : this.recurrence,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaningTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('timezone: $timezone, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('theme: $theme, ')
          ..write('countdownStyle: $countdownStyle, ')
          ..write('notificationSettings: $notificationSettings, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isArchived: $isArchived, ')
          ..write('isPinned: $isPinned, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastNotifiedAt: $lastNotifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('recurrence: $recurrence, ')
          ..write('isAllDay: $isAllDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaningTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.timezone == this.timezone &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.theme == this.theme &&
          other.countdownStyle == this.countdownStyle &&
          other.notificationSettings == this.notificationSettings &&
          other.isCompleted == this.isCompleted &&
          other.isArchived == this.isArchived &&
          other.isPinned == this.isPinned &&
          other.completedAt == this.completedAt &&
          other.lastNotifiedAt == this.lastNotifiedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.categoryId == this.categoryId &&
          other.recurrence == this.recurrence &&
          other.isAllDay == this.isAllDay);
}

class TaningTableCompanion extends UpdateCompanion<TaningTableData> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<TaningType> type;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> timezone;
  final Value<String> icon;
  final Value<String> color;
  final Value<TaningTheme> theme;
  final Value<CountdownStyle> countdownStyle;
  final Value<String> notificationSettings;
  final Value<bool> isCompleted;
  final Value<bool> isArchived;
  final Value<bool> isPinned;
  final Value<DateTime?> completedAt;
  final Value<DateTime?> lastNotifiedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String?> categoryId;
  final Value<String?> recurrence;
  final Value<bool?> isAllDay;
  final Value<int> rowid;
  const TaningTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.timezone = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.theme = const Value.absent(),
    this.countdownStyle = const Value.absent(),
    this.notificationSettings = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isPinned = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.lastNotifiedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TaningTableCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required TaningType type,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.timezone = const Value.absent(),
    required String icon,
    required String color,
    required TaningTheme theme,
    required CountdownStyle countdownStyle,
    required String notificationSettings,
    required bool isCompleted,
    required bool isArchived,
    required bool isPinned,
    this.completedAt = const Value.absent(),
    this.lastNotifiedAt = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.recurrence = const Value.absent(),
    this.isAllDay = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        type = Value(type),
        icon = Value(icon),
        color = Value(color),
        theme = Value(theme),
        countdownStyle = Value(countdownStyle),
        notificationSettings = Value(notificationSettings),
        isCompleted = Value(isCompleted),
        isArchived = Value(isArchived),
        isPinned = Value(isPinned),
        createdAt = Value(createdAt);
  static Insertable<TaningTableData> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? type,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? timezone,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<int>? theme,
    Expression<int>? countdownStyle,
    Expression<String>? notificationSettings,
    Expression<bool>? isCompleted,
    Expression<bool>? isArchived,
    Expression<bool>? isPinned,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? lastNotifiedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? categoryId,
    Expression<String>? recurrence,
    Expression<bool>? isAllDay,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (timezone != null) 'timezone': timezone,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (theme != null) 'theme': theme,
      if (countdownStyle != null) 'countdown_style': countdownStyle,
      if (notificationSettings != null)
        'notification_settings': notificationSettings,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (isArchived != null) 'is_archived': isArchived,
      if (isPinned != null) 'is_pinned': isPinned,
      if (completedAt != null) 'completed_at': completedAt,
      if (lastNotifiedAt != null) 'last_notified_at': lastNotifiedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (categoryId != null) 'category_id': categoryId,
      if (recurrence != null) 'recurrence': recurrence,
      if (isAllDay != null) 'is_all_day': isAllDay,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TaningTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<TaningType>? type,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate,
      Value<String?>? timezone,
      Value<String>? icon,
      Value<String>? color,
      Value<TaningTheme>? theme,
      Value<CountdownStyle>? countdownStyle,
      Value<String>? notificationSettings,
      Value<bool>? isCompleted,
      Value<bool>? isArchived,
      Value<bool>? isPinned,
      Value<DateTime?>? completedAt,
      Value<DateTime?>? lastNotifiedAt,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<String?>? categoryId,
      Value<String?>? recurrence,
      Value<bool?>? isAllDay,
      Value<int>? rowid}) {
    return TaningTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      timezone: timezone ?? this.timezone,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      theme: theme ?? this.theme,
      countdownStyle: countdownStyle ?? this.countdownStyle,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      isCompleted: isCompleted ?? this.isCompleted,
      isArchived: isArchived ?? this.isArchived,
      isPinned: isPinned ?? this.isPinned,
      completedAt: completedAt ?? this.completedAt,
      lastNotifiedAt: lastNotifiedAt ?? this.lastNotifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      categoryId: categoryId ?? this.categoryId,
      recurrence: recurrence ?? this.recurrence,
      isAllDay: isAllDay ?? this.isAllDay,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] =
          Variable<int>($TaningTableTable.$convertertype.toSql(type.value));
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (theme.present) {
      map['theme'] =
          Variable<int>($TaningTableTable.$convertertheme.toSql(theme.value));
    }
    if (countdownStyle.present) {
      map['countdown_style'] = Variable<int>($TaningTableTable
          .$convertercountdownStyle
          .toSql(countdownStyle.value));
    }
    if (notificationSettings.present) {
      map['notification_settings'] =
          Variable<String>(notificationSettings.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isPinned.present) {
      map['is_pinned'] = Variable<bool>(isPinned.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (lastNotifiedAt.present) {
      map['last_notified_at'] = Variable<DateTime>(lastNotifiedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (recurrence.present) {
      map['recurrence'] = Variable<String>(recurrence.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaningTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('timezone: $timezone, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('theme: $theme, ')
          ..write('countdownStyle: $countdownStyle, ')
          ..write('notificationSettings: $notificationSettings, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('isArchived: $isArchived, ')
          ..write('isPinned: $isPinned, ')
          ..write('completedAt: $completedAt, ')
          ..write('lastNotifiedAt: $lastNotifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('recurrence: $recurrence, ')
          ..write('isAllDay: $isAllDay, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TaningTableTable taningTable = $TaningTableTable(this);
  late final TaningDao taningDao = TaningDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [taningTable];
}

typedef $$TaningTableTableCreateCompanionBuilder = TaningTableCompanion
    Function({
  required String id,
  required String title,
  Value<String?> description,
  required TaningType type,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> timezone,
  required String icon,
  required String color,
  required TaningTheme theme,
  required CountdownStyle countdownStyle,
  required String notificationSettings,
  required bool isCompleted,
  required bool isArchived,
  required bool isPinned,
  Value<DateTime?> completedAt,
  Value<DateTime?> lastNotifiedAt,
  required DateTime createdAt,
  Value<DateTime?> updatedAt,
  Value<String?> categoryId,
  Value<String?> recurrence,
  Value<bool?> isAllDay,
  Value<int> rowid,
});
typedef $$TaningTableTableUpdateCompanionBuilder = TaningTableCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<TaningType> type,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
  Value<String?> timezone,
  Value<String> icon,
  Value<String> color,
  Value<TaningTheme> theme,
  Value<CountdownStyle> countdownStyle,
  Value<String> notificationSettings,
  Value<bool> isCompleted,
  Value<bool> isArchived,
  Value<bool> isPinned,
  Value<DateTime?> completedAt,
  Value<DateTime?> lastNotifiedAt,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<String?> categoryId,
  Value<String?> recurrence,
  Value<bool?> isAllDay,
  Value<int> rowid,
});

class $$TaningTableTableFilterComposer
    extends Composer<_$AppDatabase, $TaningTableTable> {
  $$TaningTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TaningType, TaningType, int> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TaningTheme, TaningTheme, int> get theme =>
      $composableBuilder(
          column: $table.theme,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<CountdownStyle, CountdownStyle, int>
      get countdownStyle => $composableBuilder(
          column: $table.countdownStyle,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get notificationSettings => $composableBuilder(
      column: $table.notificationSettings,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastNotifiedAt => $composableBuilder(
      column: $table.lastNotifiedAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurrence => $composableBuilder(
      column: $table.recurrence, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAllDay => $composableBuilder(
      column: $table.isAllDay, builder: (column) => ColumnFilters(column));
}

class $$TaningTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TaningTableTable> {
  $$TaningTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get theme => $composableBuilder(
      column: $table.theme, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get countdownStyle => $composableBuilder(
      column: $table.countdownStyle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notificationSettings => $composableBuilder(
      column: $table.notificationSettings,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPinned => $composableBuilder(
      column: $table.isPinned, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastNotifiedAt => $composableBuilder(
      column: $table.lastNotifiedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurrence => $composableBuilder(
      column: $table.recurrence, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAllDay => $composableBuilder(
      column: $table.isAllDay, builder: (column) => ColumnOrderings(column));
}

class $$TaningTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaningTableTable> {
  $$TaningTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaningType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TaningTheme, int> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CountdownStyle, int> get countdownStyle =>
      $composableBuilder(
          column: $table.countdownStyle, builder: (column) => column);

  GeneratedColumn<String> get notificationSettings => $composableBuilder(
      column: $table.notificationSettings, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
      column: $table.isCompleted, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
      column: $table.isArchived, builder: (column) => column);

  GeneratedColumn<bool> get isPinned =>
      $composableBuilder(column: $table.isPinned, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastNotifiedAt => $composableBuilder(
      column: $table.lastNotifiedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get recurrence => $composableBuilder(
      column: $table.recurrence, builder: (column) => column);

  GeneratedColumn<bool> get isAllDay =>
      $composableBuilder(column: $table.isAllDay, builder: (column) => column);
}

class $$TaningTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TaningTableTable,
    TaningTableData,
    $$TaningTableTableFilterComposer,
    $$TaningTableTableOrderingComposer,
    $$TaningTableTableAnnotationComposer,
    $$TaningTableTableCreateCompanionBuilder,
    $$TaningTableTableUpdateCompanionBuilder,
    (
      TaningTableData,
      BaseReferences<_$AppDatabase, $TaningTableTable, TaningTableData>
    ),
    TaningTableData,
    PrefetchHooks Function()> {
  $$TaningTableTableTableManager(_$AppDatabase db, $TaningTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaningTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaningTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaningTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<TaningType> type = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> timezone = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String> color = const Value.absent(),
            Value<TaningTheme> theme = const Value.absent(),
            Value<CountdownStyle> countdownStyle = const Value.absent(),
            Value<String> notificationSettings = const Value.absent(),
            Value<bool> isCompleted = const Value.absent(),
            Value<bool> isArchived = const Value.absent(),
            Value<bool> isPinned = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime?> lastNotifiedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<String?> recurrence = const Value.absent(),
            Value<bool?> isAllDay = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaningTableCompanion(
            id: id,
            title: title,
            description: description,
            type: type,
            startDate: startDate,
            endDate: endDate,
            timezone: timezone,
            icon: icon,
            color: color,
            theme: theme,
            countdownStyle: countdownStyle,
            notificationSettings: notificationSettings,
            isCompleted: isCompleted,
            isArchived: isArchived,
            isPinned: isPinned,
            completedAt: completedAt,
            lastNotifiedAt: lastNotifiedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            categoryId: categoryId,
            recurrence: recurrence,
            isAllDay: isAllDay,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            required TaningType type,
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String?> timezone = const Value.absent(),
            required String icon,
            required String color,
            required TaningTheme theme,
            required CountdownStyle countdownStyle,
            required String notificationSettings,
            required bool isCompleted,
            required bool isArchived,
            required bool isPinned,
            Value<DateTime?> completedAt = const Value.absent(),
            Value<DateTime?> lastNotifiedAt = const Value.absent(),
            required DateTime createdAt,
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<String?> categoryId = const Value.absent(),
            Value<String?> recurrence = const Value.absent(),
            Value<bool?> isAllDay = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TaningTableCompanion.insert(
            id: id,
            title: title,
            description: description,
            type: type,
            startDate: startDate,
            endDate: endDate,
            timezone: timezone,
            icon: icon,
            color: color,
            theme: theme,
            countdownStyle: countdownStyle,
            notificationSettings: notificationSettings,
            isCompleted: isCompleted,
            isArchived: isArchived,
            isPinned: isPinned,
            completedAt: completedAt,
            lastNotifiedAt: lastNotifiedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            categoryId: categoryId,
            recurrence: recurrence,
            isAllDay: isAllDay,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TaningTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TaningTableTable,
    TaningTableData,
    $$TaningTableTableFilterComposer,
    $$TaningTableTableOrderingComposer,
    $$TaningTableTableAnnotationComposer,
    $$TaningTableTableCreateCompanionBuilder,
    $$TaningTableTableUpdateCompanionBuilder,
    (
      TaningTableData,
      BaseReferences<_$AppDatabase, $TaningTableTable, TaningTableData>
    ),
    TaningTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TaningTableTableTableManager get taningTable =>
      $$TaningTableTableTableManager(_db, _db.taningTable);
}
