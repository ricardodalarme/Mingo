import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('compact calendar draws round cells and marks days for ${variant.name}', (
      tester,
    ) async {
      final tapped = <DateTime>[];
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        galleryHost(
          BaseCompactCalendar(
            month: DateTime(2026, 11),
            today: DateTime(2026, 11, 12),
            marked: {DateTime(2026, 11, 3)},
            onDayTap: tapped.add,
          ),
          variant: variant,
        ),
      );

      expect(find.text('30'), findsOneWidget);
      expect(find.text('31'), findsNothing);
      expect(find.bySemanticsLabel(RegExp('3 November 2026, Has an entry')), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('12 November 2026, Today')), findsOneWidget);

      await tester.tap(find.text('3'));
      expect(tapped, [DateTime(2026, 11, 3)]);
      semantics.dispose();
    });
  }

  testWidgets('a marker builder replaces the day number', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        BaseCompactCalendar(
          month: DateTime(2026, 11),
          marked: {DateTime(2026, 11, 3)},
          markerBuilder: (_) => const Text('•'),
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.text('•'), findsOneWidget);
  });

  testWidgets('week can start on Monday', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        BaseCompactCalendar(month: DateTime(2026, 11), weekStart: .monday),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(
      tester.getTopLeft(find.text('M').first).dx,
      lessThan(tester.getTopLeft(find.text('T').first).dx),
    );
  });
}
