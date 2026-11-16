import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('timeline lists items in the given order for ${variant.name}', (tester) async {
      var taps = 0;
      await tester.pumpWidget(
        galleryHost(
          BaseTimeline(
            children: [
              BaseTimelineItem(title: 'We met', meta: 'Mar 14, 2024', onTap: () => taps++),
              const BaseTimelineItem(title: 'First trip', meta: 'Jul 2025'),
              BaseTimelineItem.add(label: 'Add a milestone', onTap: () => taps += 10),
            ],
          ),
          variant: variant,
        ),
      );

      final first = tester.getTopLeft(find.text('We met')).dy;
      final second = tester.getTopLeft(find.text('First trip')).dy;
      expect(first, lessThan(second));
      expect(find.text('Add a milestone'), findsOneWidget);

      await tester.tap(find.text('We met'));
      await tester.tap(find.text('Add a milestone'));
      expect(taps, 11);
    });
  }

  testWidgets('a thumbnail takes a 44 point slot', (tester) async {
    await tester.pumpWidget(
      galleryHost(
        const BaseTimeline(
          children: [
            BaseTimelineItem(
              title: 'Trip',
              thumbnail: ColoredBox(color: AppPalette.neutral100),
            ),
          ],
        ),
        variant: AppThemeVariant.rose,
      ),
    );

    final box = find
        .ancestor(of: find.byType(ColoredBox).last, matching: find.byType(SizedBox))
        .first;
    expect(tester.getSize(box), const Size(44, 44));
  });
}
