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
  
  Future<bool> updateTaning(TaningTableCompanion taning) {
    return update(taningTable).replace(taning);
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