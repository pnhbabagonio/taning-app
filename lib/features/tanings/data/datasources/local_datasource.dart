import 'package:taning/database/app_database.dart';
import 'package:taning/database/daos/taning_dao.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/data/mappers/taning_mapper.dart';

/// Local data source implementation using Drift
class LocalTaningDataSource {
  final AppDatabase db;
  final TaningMapper mapper;
  
  LocalTaningDataSource({
    required this.db,
    required this.mapper,
  });
  
  Future<List<Taning>> getAllTanings() async {
    final results = await db.taningDao.getAllTanings();
    return results.map(mapper.toDomain).toList();
  }
  
  Future<List<Taning>> getActiveTanings() async {
    final results = await db.taningDao.getActiveTanings();
    return results.map(mapper.toDomain).toList();
  }
  
  Future<List<Taning>> getCompletedTanings() async {
    final results = await db.taningDao.getCompletedTanings();
    return results.map(mapper.toDomain).toList();
  }
  
  Future<Taning?> getTaningById(String id) async {
    final result = await db.taningDao.getTaningById(id);
    return result != null ? mapper.toDomain(result) : null;
  }
  
  Future<void> insertTaning(Taning taning) async {
    final companion = mapper.toCompanion(taning);
    await db.taningDao.insertTaning(companion);
  }
  
  Future<void> updateTaning(Taning taning) async {
    final companion = mapper.toCompanion(taning);
    await db.taningDao.updateTaning(companion);
  }
  
  Future<void> deleteTaning(String id) async {
    await db.taningDao.deleteTaning(id);
  }
  
  Future<void> markTaningCompleted(String id) async {
    await db.taningDao.markAsCompleted(id);
  }
  
  Stream<List<Taning>> watchAllTanings() {
    return db.taningDao.watchAllTanings().map(
      (results) => results.map(mapper.toDomain).toList(),
    );
  }
  
  Stream<List<Taning>> watchActiveTanings() {
    return db.taningDao.watchActiveTanings().map(
      (results) => results.map(mapper.toDomain).toList(),
    );
  }
}