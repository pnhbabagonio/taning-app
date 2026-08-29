import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:taning/database/app_database.dart';
import 'package:taning/database/tables/taning_table.dart' as database;
import 'package:taning/features/tanings/domain/entities/taning.dart' as domain;

/// Mapper between domain Taning and database TaningTable
class TaningMapper {
  const TaningMapper();
  
  domain.Taning toDomain(TaningTableData data) {
    try {
      return domain.Taning(
        id: data.id,
        title: data.title,
        description: data.description,
        type: domain.TaningType.values[data.type.index],
        startDate: data.startDate,
        endDate: data.endDate,
        timezone: data.timezone,
        icon: _decodeIcon(data.icon),
        color: _decodeColor(data.color),
        theme: domain.TaningTheme.values[data.theme.index],
        countdownStyle: domain.CountdownStyle.values[data.countdownStyle.index],
        notificationSettings: _decodeNotificationSettings(
          data.notificationSettings,
        ),
        isCompleted: data.isCompleted,
        isArchived: data.isArchived,
        isPinned: data.isPinned,
        completedAt: data.completedAt,
        lastNotifiedAt: data.lastNotifiedAt,
        createdAt: data.createdAt,
        updatedAt: data.updatedAt,
        categoryId: data.categoryId,
        recurrence: _decodeRecurrence(data.recurrence),
        isAllDay: data.isAllDay,
      );
    } catch (e) {
      debugPrint('Error decoding Taning: $e');
      rethrow;
    }
  }
  
  TaningTableCompanion toCompanion(domain.Taning taning) {
    try {
      return TaningTableCompanion(
        id: Value(taning.id),
        title: Value(taning.title),
        description: Value(taning.description),
        type: Value(database.TaningType.values[taning.type.index]),
        startDate: Value(taning.startDate),
        endDate: Value(taning.endDate),
        timezone: Value(taning.timezone),
        icon: Value(_encodeIcon(taning.icon)),
        color: Value(_encodeColor(taning.color)),
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
    } catch (e) {
      debugPrint('Error encoding Taning: $e');
      rethrow;
    }
  }
  
  /// Safely decode icon JSON with fallback
  domain.TaningIcon _decodeIcon(String json) {
    try {
      final decoded = jsonDecode(json);
      return domain.TaningIcon.fromJson(decoded as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error decoding icon: $e');
      return domain.TaningIcon.defaultIcon();
    }
  }
  
  /// Safely decode color JSON with fallback
  domain.TaningColor _decodeColor(String json) {
    try {
      final decoded = jsonDecode(json);
      return domain.TaningColor.fromJson(decoded as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error decoding color: $e');
      return domain.TaningColor.defaultColor();
    }
  }

  domain.NotificationSettings _decodeNotificationSettings(String json) {
    try {
      final decoded = jsonDecode(json);
      return domain.NotificationSettings.fromJson(decoded as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error decoding notification settings: $e');
      return domain.NotificationSettings.defaults();
    }
  }

  domain.RecurrencePattern? _decodeRecurrence(String? json) {
    if (json == null || json.isEmpty) return null;

    try {
      final decoded = jsonDecode(json);
      return domain.RecurrencePattern.fromJson(decoded as Map<String, dynamic>);
    } catch (e) {
      debugPrint('Error decoding recurrence: $e');
      return null;
    }
  }
  
  /// Safely encode icon to JSON
  String _encodeIcon(domain.TaningIcon icon) {
    try {
      return jsonEncode(icon.toJson());
    } catch (e) {
      debugPrint('Error encoding icon: $e');
      return jsonEncode(domain.TaningIcon.defaultIcon().toJson());
    }
  }
  
  /// Safely encode color to JSON
  String _encodeColor(domain.TaningColor color) {
    try {
      return jsonEncode(color.toJson());
    } catch (e) {
      debugPrint('Error encoding color: $e');
      return jsonEncode(domain.TaningColor.defaultColor().toJson());
    }
  }
}
