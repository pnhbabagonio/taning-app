import 'package:flutter_test/flutter_test.dart';
import 'package:taning/database/app_database.dart';
import 'package:taning/database/tables/taning_table.dart' as database;
import 'package:taning/features/tanings/data/mappers/taning_mapper.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';

void main() {
  const mapper = TaningMapper();

  test('uses safe defaults for legacy malformed customization data', () {
    final taning = mapper.toDomain(
      TaningTableData(
        id: 'legacy-id',
        title: 'Legacy taning',
        type: database.TaningType.countdown,
        icon: 'not-json',
        color: 'not-json',
        theme: database.TaningTheme.midnight,
        countdownStyle: database.CountdownStyle.detailed,
        notificationSettings: 'not-json',
        isCompleted: false,
        isArchived: false,
        isPinned: false,
        createdAt: DateTime(2026, 8, 30),
        recurrence: 'not-json',
      ),
    );

    expect(taning.icon, TaningIcon.defaultIcon());
    expect(taning.color, TaningColor.defaultColor());
    expect(taning.notificationSettings, NotificationSettings.defaults());
    expect(taning.recurrence, isNull);
  });
}
