import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/repositories/taning_repository.dart';
import 'package:taning/features/tanings/data/datasources/local_datasource.dart';
import 'package:taning/core/services/logger.dart';

class TaningRepositoryImpl implements TaningRepository {
  final LocalTaningDataSource localDataSource;
  
  TaningRepositoryImpl(this.localDataSource);
  
  @override
  Future<List<Taning>> getAll() async {
    return await localDataSource.getAllTanings();
  }
  
  @override
  Future<List<Taning>> getActive() async {
    return await localDataSource.getActiveTanings();
  }
  
  @override
  Future<List<Taning>> getCompleted() async {
    return await localDataSource.getCompletedTanings();
  }
  
  @override
  Future<List<Taning>> getArchived() async {
    final all = await localDataSource.getAllTanings();
    return all.where((t) => t.isArchived).toList();
  }
  
  @override
  Future<Taning?> getById(String id) async {
    return await localDataSource.getTaningById(id);
  }
  
  @override
  Future<Taning> save(Taning taning) async {
    try {
      // Check if it's new or existing
      final existing = await localDataSource.getTaningById(taning.id);
      if (existing != null) {
        // Update with new values - preserve id and createdAt
        final updated = taning.copyWith(
          updatedAt: DateTime.now(),
          // Preserve these from existing
          id: existing.id,
          createdAt: existing.createdAt,
          completedAt: existing.completedAt,
          lastNotifiedAt: existing.lastNotifiedAt,
        );
        LoggerService.info('Updating Taning: ${updated.id} - ${updated.title}');
        await localDataSource.updateTaning(updated);
        return updated;
      } else {
        // Insert new
        LoggerService.info('Creating new Taning: ${taning.id} - ${taning.title}');
        await localDataSource.insertTaning(taning);
        return taning;
      }
    } catch (e) {
      LoggerService.error('Error saving Taning: $e');
      rethrow;
    }
  }
  
  @override
  Future<void> delete(String id) async {
    await localDataSource.deleteTaning(id);
  }
  
  @override
  Future<Taning> markCompleted(String id) async {
    final taning = await getById(id);
    if (taning == null) throw Exception('Taning not found');
    
    final updated = taning.copyWith(
      isCompleted: true,
      completedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await localDataSource.updateTaning(updated);
    return updated;
  }
  
  @override
  Future<Taning> archive(String id) async {
    final taning = await getById(id);
    if (taning == null) throw Exception('Taning not found');
    
    final updated = taning.copyWith(
      isArchived: true,
      updatedAt: DateTime.now(),
    );
    await localDataSource.updateTaning(updated);
    return updated;
  }
  
  @override
  Future<Taning> unarchive(String id) async {
    final taning = await getById(id);
    if (taning == null) throw Exception('Taning not found');
    
    final updated = taning.copyWith(
      isArchived: false,
      updatedAt: DateTime.now(),
    );
    await localDataSource.updateTaning(updated);
    return updated;
  }
  
  @override
  Future<Taning> togglePin(String id) async {
    final taning = await getById(id);
    if (taning == null) throw Exception('Taning not found');
    
    final updated = taning.copyWith(
      isPinned: !taning.isPinned,
      updatedAt: DateTime.now(),
    );
    await localDataSource.updateTaning(updated);
    return updated;
  }
  
  @override
  Stream<List<Taning>> watchAll() {
    return localDataSource.watchAllTanings();
  }
  
  @override
  Stream<List<Taning>> watchActive() {
    return localDataSource.watchActiveTanings();
  }
}