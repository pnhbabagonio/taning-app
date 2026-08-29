// lib/database/daos/taning_dao.dart
import 'package:drift/drift.dart';
import 'package:taning/database/app_database.dart';
import 'package:taning/database/tables/taning_table.dart';

part 'taning_dao.g.dart';

@DriftAccessor(tables: [TaningTable])
class TaningDao extends DatabaseAccessor<AppDatabase> with _$TaningDaoMixin {
  TaningDao(super.db);
  
  Future<int> insertTaning(TaningTableCompanion taning) {
    return into(taningTable).insert(taning);
  }
  
  // FIX: Use update() instead of replace() for better error handling
  Future<bool> updateTaning(TaningTableCompanion taning) {
    return update(taningTable).replace(taning);
  }
  
  // Alternative: Update specific fields only
  Future<bool> updateTaningFields(
    String id, {
    String? title,
    String? description,
    DateTime? startDate,
    DateTime? endDate,
    String? timezone,
    String? icon,
    String? color,
    database.TaningType? type,
    database.TaningTheme? theme,
    database.CountdownStyle? countdownStyle,
    String? notificationSettings,
    bool? isCompleted,
    bool? isArchived,
    bool? isPinned,
    DateTime? completedAt,
    DateTime? lastNotifiedAt,
    DateTime? updatedAt,
    String? categoryId,
    String? recurrence,
    bool? isAllDay,
  }) {
    final companion = TaningTableCompanion(
      id: Value(id),
      title: Value(title ?? ''),
      description: Value(description),
      startDate: Value(startDate),
      endDate: Value(endDate),
      timezone: Value(timezone),
      icon: Value(icon ?? '{"codePoint":59625}'),
      color: Value(color ?? '{"value":4282568421}'),
      type: Value(type ?? database.TaningType.countdown),
      theme: Value(theme ?? database.TaningTheme.midnight),
      countdownStyle: Value(countdownStyle ?? database.CountdownStyle.detailed),
      notificationSettings: Value(notificationSettings ?? '{"enabled":true,"oneDayBefore":false,"threeDaysBefore":false,"sevenDaysBefore":false,"oneHourBefore":false,"thirtyMinutesBefore":false,"atExactTime":false}'),
      isCompleted: Value(isCompleted ?? false),
      isArchived: Value(isArchived ?? false),
      isPinned: Value(isPinned ?? false),
      completedAt: Value(completedAt),
      lastNotifiedAt: Value(lastNotifiedAt),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(updatedAt ?? DateTime.now()),
      categoryId: Value(categoryId),
      recurrence: Value(recurrence),
      isAllDay: Value(isAllDay),
    );
    
    return update(taningTable).replace(companion);
  }
  
  Future<void> deleteTaning(String id) {
    return (delete(taningTable)..where((t) => t.id.equals(id))).go();
  }
  
  Future<TaningTableData?> getTaningById(String id) {
    return (select(taningTable)..where((t) => t.id.equals(id))).getSingleOrNull();
  }
  
  Future<List<TaningTableData>> getAllTanings() {
    return select(taningTable).get();
  }
  
  Future<List<TaningTableData>> getActiveTanings() {
    return (select(taningTable)
      ..where((t) => t.isArchived.equals(false))
      ..where((t) => t.isCompleted.equals(false))).get();
  }
  
  Future<List<TaningTableData>> getCompletedTanings() {
    return (select(taningTable)
      ..where((t) => t.isCompleted.equals(true))).get();
  }
  
  Future<List<TaningTableData>> getArchivedTanings() {
    return (select(taningTable)
      ..where((t) => t.isArchived.equals(true))).get();
  }
  
  Future<void> markAsCompleted(String id) {
    return (update(taningTable)
      ..where((t) => t.id.equals(id)))
      .write(TaningTableCompanion(
        isCompleted: const Value(true),
        completedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
      ));
  }
  
  Stream<List<TaningTableData>> watchAllTanings() {
    return select(taningTable).watch();
  }
  
  Stream<List<TaningTableData>> watchActiveTanings() {
    return (select(taningTable)
      ..where((t) => t.isArchived.equals(false))
      ..where((t) => t.isCompleted.equals(false))).watch();
  }
}