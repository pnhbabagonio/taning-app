import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taning/features/tanings/domain/entities/taning.dart';
import 'package:taning/features/tanings/presentation/widgets/taning_card.dart';

void main() {
  group('TaningCard Widget Tests', () {
    testWidgets('displays title and countdown correctly', (tester) async {
      final taning = Taning.create(
        title: 'Vacation',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24),
        color: const TaningColor(value: 0xFF4F46E5),
        icon: const TaningIcon(codePoint: 0xE8ED),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: TaningCard(
                taning: taning,
                variant: TaningCardVariant.standard,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Vacation'), findsOneWidget);
    });

    testWidgets('handles tap gesture', (tester) async {
      var tapped = false;
      final taning = Taning.create(
        title: 'Test',
        type: TaningType.countdown,
        endDate: DateTime(2026, 8, 24),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: TaningCard(
                taning: taning,
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TaningCard));
      expect(tapped, true);
    });

    testWidgets('fits focus card content in a compact square', (tester) async {
      final taning = Taning.create(
        title: 'A long focus card title that needs two lines',
        type: TaningType.countdown,
        endDate: DateTime.now().add(const Duration(days: 2, hours: 3)),
        color: const TaningColor(value: 0xFF4F46E5),
        icon: const TaningIcon(codePoint: 0xE8ED),
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 274,
                  height: 290,
                  child: TaningCard(
                    taning: taning,
                    variant: TaningCardVariant.focus,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.textContaining('A long focus card'), findsOneWidget);
    });
  });
}
