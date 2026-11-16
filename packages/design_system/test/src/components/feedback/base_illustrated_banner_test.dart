import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets(
      'illustrated banner has radius 28, a compact action and a decorative drawing for ${variant.name}',
      (tester) async {
        var opened = 0;
        await tester.pumpWidget(
          galleryHost(
            BaseIllustratedBanner(
              illustration: const SizedBox(width: 48, height: 40),
              title: 'A card arrived',
              message: '3 good things this week',
              actionLabel: 'Open',
              onAction: () => opened++,
            ),
            variant: variant,
          ),
        );

        final container = tester.widget<Container>(
          find
              .descendant(of: find.byType(BaseIllustratedBanner), matching: find.byType(Container))
              .first,
        );
        expect(
          ((container.decoration! as BoxDecoration).borderRadius! as BorderRadius).topLeft.x,
          28,
        );
        expect(find.text('3 good things this week'), findsOneWidget);
        await tester.tap(find.text('Open'));
        expect(opened, 1);
      },
    );
  }

  testWidgets('tapping the card calls onTap when supplied', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      galleryHost(
        BaseIllustratedBanner(
          illustration: const SizedBox(),
          title: 'A card arrived',
          actionLabel: 'Open',
          onAction: () {},
          onTap: () => taps++,
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    await tester.tap(find.text('A card arrived'));
    expect(taps, 1);
  });
}
