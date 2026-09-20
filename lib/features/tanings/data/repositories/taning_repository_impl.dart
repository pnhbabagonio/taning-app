// lib/features/tanings/data/repositories/taning_repository_impl.dart
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/domain/repositories/taning_repository.dart';
import 'package:taning/features/tanings/data/datasources/local_datasource.dart';
import 'package:taning/core/services/logger.dart';
import 'package:taning/plugins/widget_bridge.dart';

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
  Stream<Taning?> watchById(String id) {
    return localDataSource.watchTaningById(id);
  }

  @override
  Future<Taning> save(Taning taning) async {
    try {
      final existing = await localDataSource.getTaningById(taning.id);
      if (existing != null) {
        final updated = taning.copyWith(
          updatedAt: DateTime.now(),
          id: existing.id,
          createdAt: existing.createdAt,
          completedAt: existing.completedAt,
          lastNotifiedAt: existing.lastNotifiedAt,
        );
        LoggerService.info(
          'Updating Taning: ${updated.id} - ${updated.title}',
        );
        await localDataSource.updateTaning(updated);
        await _refreshWidget();
        return updated;
      } else {
        LoggerService.info(
          'Creating new Taning: ${taning.id} - ${taning.title}',
        );
        await localDataSource.insertTaning(taning);
        await _refreshWidget();
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
    await _refreshWidget();
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
    await _refreshWidget();
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
    await _refreshWidget();
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
    await _refreshWidget();
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
    await _refreshWidget();
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

  /// Refresh the home screen widget with the latest data.
  /// Best-effort: never crash the app if widget update fails.
  Future<void> _refreshWidget() async {
    try {
      final all = await getAll();
      await WidgetBridge.updateWidgetsWithAllTanings(all);
    } catch (e) {
      LoggerService.debug('Widget refresh skipped: $e');
    }
  }
}