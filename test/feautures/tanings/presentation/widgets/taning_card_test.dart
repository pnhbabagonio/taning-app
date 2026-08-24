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
        color: TaningColor(value: 0xFF4F46E5),
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
  });
}