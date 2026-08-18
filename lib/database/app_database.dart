// lib/database/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:taning/database/tables/taning_table.dart';
import 'package:taning/database/daos/taning_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    TaningTable,
  ],
  daos: [
    TaningDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  static Future<void> initialize() async {
    final db = AppDatabase();
    await db.ensureInitialized();
  }
  
  @override
  int get schemaVersion => 1;
  
  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Handle migrations
    },
  );
  
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'taning.sqlite'));
      
      if (!await file.exists()) {
        await file.create(recursive: true);
      }
      
      return NativeDatabase.createInBackground(file);
    });
  }
}