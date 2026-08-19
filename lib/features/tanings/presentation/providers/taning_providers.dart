import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taning/database/app_database.dart';
import 'package:taning/features/tanings/data/datasources/local_datasource.dart';
import 'package:taning/features/tanings/data/mappers/taning_mapper.dart';
import 'package:taning/features/tanings/data/repositories/taning_repository_impl.dart';
import 'package:taning/features/tanings/domain/engines/countdown_engine.dart';
import 'package:taning/features/tanings/domain/repositories/taning_repository.dart';

// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

// Mapper provider
final tandingMapperProvider = Provider<TaningMapper>((ref) {
  return const TaningMapper();
});

// Data source provider
final localDataSourceProvider = Provider<LocalTaningDataSource>((ref) {
  final db = ref.watch(databaseProvider);
  final mapper = ref.watch(tandingMapperProvider);
  return LocalTaningDataSource(db: db, mapper: mapper);
});

// Repository provider
final tandingRepositoryProvider = Provider<TaningRepository>((ref) {
  final dataSource = ref.watch(localDataSourceProvider);
  return TaningRepositoryImpl(dataSource);
});

// Countdown engine provider
final countdownEngineProvider = Provider<CountdownEngine>((ref) {
  return const CountdownEngine();
});

// Active Tanings provider
final activeTaningsProvider = StreamProvider<List<Taning>>((ref) {
  final repository = ref.watch(tandingRepositoryProvider);
  return repository.watchActive();
});

// All Tanings provider
final allTaningsProvider = StreamProvider<List<Taning>>((ref) {
  final repository = ref.watch(tandingRepositoryProvider);
  return repository.watchAll();
});

// Single Taning provider
final taningProvider = FutureProvider.family<Taning?, String>((ref, id) async {
  final repository = ref.watch(tandingRepositoryProvider);
  return repository.getById(id);
});