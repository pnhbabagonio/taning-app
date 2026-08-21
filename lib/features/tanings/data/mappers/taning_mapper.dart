import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:taning/database/app_database.dart';
import 'package:taning/database/tables/taning_table.dart' as database;
import 'package:taning/features/tanings/domain/entities/taning.dart' as domain;

/// Mapper between domain Taning and database TaningTable
class TaningMapper {
  const TaningMapper();
  
  domain.Taning toDomain(TaningTableData data) {
    return domain.Taning(
      id: data.id,
      title: data.title,
      description: data.description,
        type: domain.TaningType.values[data.type.index],
      startDate: data.startDate,
      endDate: data.endDate,
      timezone: data.timezone,
      icon: domain.TaningIcon.fromJson(jsonDecode(data.icon)),
      color: domain.TaningColor.fromJson(jsonDecode(data.color)),
        theme: domain.TaningTheme.values[data.theme.index],
        countdownStyle: domain.CountdownStyle.values[data.countdownStyle.index],
      notificationSettings: domain.NotificationSettings.fromJson(
        jsonDecode(data.notificationSettings),
      ),
      isCompleted: data.isCompleted,
      isArchived: data.isArchived,
      isPinned: data.isPinned,
      completedAt: data.completedAt,
      lastNotifiedAt: data.lastNotifiedAt,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      categoryId: data.categoryId,
      recurrence: data.recurrence != null
          ? domain.RecurrencePattern.fromJson(jsonDecode(data.recurrence!))
          : null,
      isAllDay: data.isAllDay,
    );
  }
  
  TaningTableCompanion toCompanion(domain.Taning taning) {
    return TaningTableCompanion(
      id: Value(taning.id),
      title: Value(taning.title),
      description: Value(taning.description),
      type: Value(database.TaningType.values[taning.type.index]),
      startDate: Value(taning.startDate),
      endDate: Value(taning.endDate),
      timezone: Value(taning.timezone),
      icon: Value(jsonEncode(taning.icon.toJson())),
      color: Value(jsonEncode(taning.color.toJson())),
      theme: Value(database.TaningTheme.values[taning.theme.index]),
      countdownStyle: Value(database.CountdownStyle.values[taning.countdownStyle.index]),
      notificationSettings: Value(jsonEncode(taning.notificationSettings.toJson())),
      isCompleted: Value(taning.isCompleted),
      isArchived: Value(taning.isArchived),
      isPinned: Value(taning.isPinned),
      completedAt: Value(taning.completedAt),
      lastNotifiedAt: Value(taning.lastNotifiedAt),
      createdAt: Value(taning.createdAt),
      updatedAt: Value(taning.updatedAt ?? DateTime.now()),
      categoryId: Value(taning.categoryId),
      recurrence: Value(taning.recurrence != null 
          ? jsonEncode(taning.recurrence!.toJson())
          : null),
      isAllDay: Value(taning.isAllDay),
    );
  }
}