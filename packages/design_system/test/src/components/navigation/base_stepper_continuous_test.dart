import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('continuous stepper draws full-width segments for ${variant.name}', (tester) async {
      final semantics = tester.ensureSemantics();
      await tester.pumpWidget(
        galleryHost(
          const BaseStepper.continuous(count: 3, currentIndex: 1, progress: .5),
          variant: variant,
          width: 300,
        ),
      );

      expect(find.bySemanticsLabel('Part 2 of 3'), findsOneWidget);
      final fills = tester
          .widgetList<FractionallySizedBox>(find.byType(FractionallySizedBox))
          .toList();
      expect(fills.map((f) => f.widthFactor), [1, .5, 0]);
      expect(tester.getSize(find.byType(SizedBox).first).height, isNonNegative);
      semantics.dispose();
    });
  }

  testWidgets('progress is clamped to the segment', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        const BaseStepper.continuous(count: 2, currentIndex: 0, progress: 4),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(
      tester.widgetList<FractionallySizedBox>(find.byType(FractionallySizedBox)).first.widthFactor,
      1,
    );
  });
}
