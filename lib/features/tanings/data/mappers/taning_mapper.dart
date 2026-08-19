import 'dart:convert';
import 'package:taning/database/tables/taning_table.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

/// Mapper between domain Taning and database TaningTable
class TaningMapper {
  const TaningMapper();
  
  Taning toDomain(TaningTableData data) {
    return Taning(
      id: data.id,
      title: data.title,
      description: data.description,
      type: TaningType.values[data.type],
      startDate: data.startDate,
      endDate: data.endDate,
      timezone: data.timezone,
      icon: TaningIcon.fromJson(jsonDecode(data.icon)),
      color: TaningColor.fromJson(jsonDecode(data.color)),
      theme: TaningTheme.values[data.theme],
      countdownStyle: CountdownStyle.values[data.countdownStyle],
      notificationSettings: NotificationSettings.fromJson(
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
          ? RecurrencePattern.fromJson(jsonDecode(data.recurrence!))
          : null,
      isAllDay: data.isAllDay,
    );
  }
  
  TaningTableCompanion toCompanion(Taning domain) {
    return TaningTableCompanion(
      id: Value(domain.id),
      title: Value(domain.title),
      description: Value(domain.description),
      type: Value(domain.type.index),
      startDate: Value(domain.startDate),
      endDate: Value(domain.endDate),
      timezone: Value(domain.timezone),
      icon: Value(jsonEncode(domain.icon.toJson())),
      color: Value(jsonEncode(domain.color.toJson())),
      theme: Value(domain.theme.index),
      countdownStyle: Value(domain.countdownStyle.index),
      notificationSettings: Value(jsonEncode(domain.notificationSettings.toJson())),
      isCompleted: Value(domain.isCompleted),
      isArchived: Value(domain.isArchived),
      isPinned: Value(domain.isPinned),
      completedAt: Value(domain.completedAt),
      lastNotifiedAt: Value(domain.lastNotifiedAt),
      createdAt: Value(domain.createdAt),
      updatedAt: Value(domain.updatedAt ?? DateTime.now()),
      categoryId: Value(domain.categoryId),
      recurrence: Value(domain.recurrence != null 
          ? jsonEncode(domain.recurrence!.toJson())
          : null),
      isAllDay: Value(domain.isAllDay),
    );
  }
}