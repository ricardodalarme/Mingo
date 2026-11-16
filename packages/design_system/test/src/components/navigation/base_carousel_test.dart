import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

Widget _card(String text) => Container(
  height: 120,
  decoration: const BoxDecoration(color: AppPalette.neutral100),
  child: Text(text),
);

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('carousel shows dots and announces each card for ${variant.name}', (tester) async {
      final semantics = tester.ensureSemantics();
      final pages = <int>[];
      await tester.pumpWidget(
        galleryHost(
          BaseCarousel(
            onPageChanged: pages.add,
            children: [_card('one'), _card('two'), _card('three')],
          ),
          variant: variant,
          width: 390,
        ),
      );
      await tester.pump();

      expect(find.byType(BasePageDots), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Card 1 of 3')), findsOneWidget);
      expect(tester.getSize(find.byType(BaseCarousel)).height, greaterThanOrEqualTo(178));

      await tester.drag(find.text('one').last, const Offset(-300, 0));
      await tester.pumpAndSettle();
      expect(pages, [1]);
      semantics.dispose();
    });
  }

  testWidgets('a single page is full width with no dots', (tester) async {
    await tester.pumpWidget(
      galleryHost(BaseCarousel(children: [_card('only')]), variant: AppThemeVariant.rose),
    );

    expect(find.byType(BasePageDots), findsNothing);
    expect(find.text('only'), findsOneWidget);
  });

  testWidgets('page dots stretch the active page', (tester) async {
    await tester.pumpWidget(
      galleryHost(const BasePageDots(count: 3, index: 1), variant: AppThemeVariant.rose),
    );
    await tester.pumpAndSettle();

    final sizes = tester
        .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
        .map((c) => c.constraints?.maxWidth)
        .toList();
    expect(sizes, [6, 18, 6]);
  });

  testWidgets('cards are the screen width minus 90 and start 20 from the edge', (tester) async {
    await tester.pumpWidget(
      themedHost(
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 390,
            child: BaseCarousel(
              children: [
                Container(key: const Key('a'), height: 120),
                Container(key: const Key('b'), height: 120),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    final first = tester.getRect(find.byKey(const Key('a')).last);
    final second = tester.getRect(find.byKey(const Key('b')).last);
    expect(first.left, 20);
    expect(first.width, 300);
    expect(second.left - first.right, 12);
  });
}
