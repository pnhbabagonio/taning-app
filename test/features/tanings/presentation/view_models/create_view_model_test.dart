import 'package:flutter_test/flutter_test.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/view_models/create_view_model.dart';

void main() {
  test('buildTaning retains the selected recurrence pattern', () {
    final viewModel = CreateViewModel()
      ..title = 'Payday'
      ..type = TaningType.recurring
      ..startDate = DateTime(2026, 8, 30)
      ..recurrencePattern = const DailyRecurrence(interval: 2);

    final taning = viewModel.buildTaning();

    expect(taning.recurrence, const DailyRecurrence(interval: 2));
  });
}
