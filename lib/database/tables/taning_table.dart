// lib/database/tables/taning_table.dart
import 'package:drift/drift.dart';

class TaningTable extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  
  // Use IntColumn for enum values
  IntColumn get type => intEnum<TaningType>()();
  
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get timezone => text().nullable()();
  
  TextColumn get icon => text()(); // JSON string
  TextColumn get color => text()(); // JSON string
  IntColumn get theme => intEnum<TaningTheme>()();
  IntColumn get countdownStyle => intEnum<CountdownStyle>()();
  
  TextColumn get notificationSettings => text()(); // JSON string
  
  BoolColumn get isCompleted => boolean()();
  BoolColumn get isArchived => boolean()();
  BoolColumn get isPinned => boolean()();
  
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get lastNotifiedAt => dateTime().nullable()();
  
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  
  TextColumn get categoryId => text().nullable()();
  TextColumn get recurrence => text().nullable()(); // JSON string
  BoolColumn get isAllDay => boolean().nullable()();
  
  @override
  List<Set<Column>> get uniqueKeys => [
    {id},
  ];
}

enum TaningType { countdown, duration, countUp, recurring }
enum TaningTheme { midnight, sunrise, forest, ocean, sakura, mono, filipino }
enum CountdownStyle { simple, detailed, full, progress, calendar }