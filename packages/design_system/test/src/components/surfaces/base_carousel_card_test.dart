import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/widget_host.dart';

void main() {
  for (final variant in AppThemeVariant.values) {
    testWidgets('carousel card renders in ${variant.name}', (tester) async {
      await tester.pumpWidget(
        themedHost(
          const BaseCarouselCard(
            tag: 'Cartão',
            title: 'A Luanna te mandou um cartão',
            supportText: '3 coisas boas desta semana.',
            actionText: 'Abrir',
          ),
          variant: variant,
        ),
      );

      expect(find.text('CARTÃO'), findsOneWidget);
      expect(find.text('Abrir'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the action and the card both open when a tap is given', (tester) async {
    var opened = 0;
    await tester.pumpWidget(
      themedHost(
        BaseCarouselCard(
          tag: 'Cartão',
          title: 'Título',
          actionText: 'Abrir',
          onTap: () => opened++,
        ),
      ),
    );

    await tester.tap(find.text('Abrir'));
    await tester.tap(find.text('Título'));

    expect(opened, 2);
  });

  testWidgets('a card without an action shows no button', (tester) async {
    await tester.pumpWidget(themedHost(const BaseCarouselCard(tag: 'Só seu', title: 'Título')));

    expect(find.byType(BaseButton), findsNothing);
  });
}
