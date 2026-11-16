import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

BoxDecoration _decoration(WidgetTester tester) {
  final container = tester.widget<Container>(
    find.descendant(of: find.byType(BaseBubble), matching: find.byType(Container)).first,
  );

  return container.decoration! as BoxDecoration;
}

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('own bubble is dark with radius 22 and an 8 tail for ${variant.name}', (
      tester,
    ) async {
      await tester.pumpWidget(
        galleryHost(
          const BaseBubble(variant: .own, text: 'Hi'),
          variant: variant,
        ),
      );

      final decoration = _decoration(tester);
      expect(decoration.color, colorsOf(variant).actionPrimary);
      final radius = decoration.borderRadius! as BorderRadius;
      expect(radius.topLeft.x, 22);
      expect(radius.bottomRight.x, 8);
      expect(radius.bottomLeft.x, 22);
      expect(tester.widget<Text>(find.text('Hi')).style!.color, colorsOf(variant).textOnAction);
    });

    testWidgets(
      'other bubble is white with a hair border and the tail on the left for ${variant.name}',
      (tester) async {
        await tester.pumpWidget(galleryHost(const BaseBubble(text: 'Hello'), variant: variant));

        final decoration = _decoration(tester);
        expect(decoration.color, AppPalette.white);
        expect(decoration.border, isNotNull);
        expect((decoration.borderRadius! as BorderRadius).bottomLeft.x, 8);
      },
    );
  }

  testWidgets('max width is 84% of the available width', (tester) async {
    await tester.pumpWidget(
      galleryHost(BaseBubble(text: 'word ' * 60), variant: AppThemeVariant.rose, width: 350),
    );

    expect(
      tester.getSize(find.byType(ConstrainedBox).last).width,
      lessThanOrEqualTo(310 * .84 + 1),
    );
  });

  testWidgets('typing bubble is 62 by 44 and says Typing', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      galleryHost(const BaseBubble(variant: .typing), variant: AppThemeVariant.rose),
    );

    final size = tester.getSize(
      find.descendant(of: find.byType(BaseBubble), matching: find.byType(Container)).first,
    );
    expect(size.width, greaterThanOrEqualTo(62));
    expect(size.height, 44);
    expect(find.bySemanticsLabel('Typing'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('failure keeps the surface with an error border and a retry link', (tester) async {
    var retries = 0;
    await tester.pumpWidget(
      galleryHost(
        BaseBubble(variant: .failure, text: 'See you at eight', onRetry: () => retries++),
        variant: AppThemeVariant.rose,
      ),
    );

    final decoration = _decoration(tester);
    expect(decoration.color, AppPalette.white);
    expect(decoration.border, isA<Border>());
    await tester.tap(find.text('Try again'));
    expect(retries, 1);
  });

  testWidgets('own bubble announces the speaker and sending dims it', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      galleryHost(
        const BaseBubble(variant: .own, text: 'On my way', isSending: true),
        variant: AppThemeVariant.rose,
      ),
    );

    expect(find.bySemanticsLabel('You said: On my way'), findsOneWidget);
    expect(tester.widget<Opacity>(find.byType(Opacity).first).opacity, .6);
    semantics.dispose();
  });
}
