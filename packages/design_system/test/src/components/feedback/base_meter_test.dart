import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets(
      'meter fills in the action color and never changes near the limit for ${variant.name}',
      (tester) async {
        await tester.pumpWidget(
          galleryHost(const BaseMeter(value: 5, max: 5, label: 'Back tomorrow'), variant: variant),
        );
        await tester.pumpAndSettle();

        expect(find.text('Back tomorrow'), findsOneWidget);
        final fill = tester.widget<ColoredBox>(
          find.descendant(of: find.byType(FractionallySizedBox), matching: find.byType(ColoredBox)),
        );
        expect(fill.color, colorsOf(variant).actionPrimary);
        expect(
          tester.widget<FractionallySizedBox>(find.byType(FractionallySizedBox)).widthFactor,
          1,
        );
      },
    );
  }

  testWidgets('track is 6 high, 4 when thin, and the fraction follows the value', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        const BaseMeter(value: 2, max: 5, label: '2 of 5 today'),
        variant: AppThemeVariant.rose,
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.widget<FractionallySizedBox>(find.byType(FractionallySizedBox)).widthFactor,
      closeTo(.4, .001),
    );
    expect(
      tester
          .getSize(
            find.descendant(of: find.byType(BaseMeter), matching: find.byType(SizedBox)).first,
          )
          .height,
      6,
    );

    await tester.pumpWidget(
      galleryHost(const BaseMeter(value: 2, max: 5, isThin: true), variant: AppThemeVariant.rose),
    );
    expect(
      tester
          .getSize(
            find.descendant(of: find.byType(BaseMeter), matching: find.byType(SizedBox)).first,
          )
          .height,
      4,
    );
  });

  testWidgets('reads the label as its value and clamps an over-full value', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      galleryHost(
        const BaseMeter(value: 9, max: 5, label: '2 of 5 today'),
        variant: AppThemeVariant.rose,
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.getSemantics(find.byType(BaseMeter)).value, '2 of 5 today');
    expect(tester.widget<FractionallySizedBox>(find.byType(FractionallySizedBox)).widthFactor, 1);
    semantics.dispose();
  });

  testWidgets('the label can sit on the right', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        const BaseMeter(value: 1, max: 5, label: '1 of 5', labelOnRight: true),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.byType(Row), findsWidgets);
    expect(tester.getTopLeft(find.text('1 of 5')).dx, greaterThan(150));
  });
}
