import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('date badge shows a three letter month and the day for ${variant.name}', (
      tester,
    ) async {
      await tester.pumpWidget(
        galleryHost(BaseDateBadge(date: DateTime(2026, 11, 8)), variant: variant),
      );

      expect(find.text('NOV'), findsOneWidget);
      expect(find.text('08'), findsOneWidget);
      expect(
        tester
            .getSize(
              find
                  .descendant(of: find.byType(BaseDateBadge), matching: find.byType(Container))
                  .first,
            )
            .width,
        54,
      );
    });
  }

  testWidgets('flat badge does not rotate and is hidden from the reader', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      galleryHost(
        BaseDateBadge(date: DateTime(2026, 11, 20), isTilted: false),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.byType(Transform), findsNothing);
    expect(find.bySemanticsLabel('NOV'), findsNothing);
    semantics.dispose();
  });

  testWidgets('past badge uses the muted strip', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        BaseDateBadge(date: DateTime(2026, 11, 8), isPast: true, isTilted: false),
        variant: AppThemeVariant.rose,
      ),
    );

    final colors = tester.widgetList<Container>(find.byType(Container)).map((c) => c.color);
    expect(colors, contains(AppPalette.neutral400));
  });
}
