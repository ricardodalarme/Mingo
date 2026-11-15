import 'package:app/features/share/presentation/widgets/quote_share_card.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('quotes the card with who wrote it and when it arrived', (tester) async {
    await tester.pumpApp(
      Center(
        child: QuoteShareCard(
          quote: 'Você percebeu que eu estava cansada antes de eu falar.',
          authorName: 'Marina',
          date: DateTime(2026, 11, 8),
        ),
      ),
    );

    expect(find.text('DE UM CARTÃO'), findsOneWidget);
    expect(
      find.text('“Você percebeu que eu estava cansada antes de eu falar.”'),
      findsOneWidget,
    );
    expect(find.text('— Marina'), findsOneWidget);
    expect(find.text('Cartão de 8 de novembro'), findsOneWidget);
    expect(find.text('Mingo'), findsOneWidget);
  });

  testWidgets('a card without a name still shows the quote and its date', (tester) async {
    await tester.pumpApp(
      Center(child: QuoteShareCard(quote: 'Fez café sem eu pedir.', date: DateTime(2026, 11, 8))),
    );

    expect(find.text('“Fez café sem eu pedir.”'), findsOneWidget);
    expect(find.text('— Marina'), findsNothing);
    expect(find.text('Cartão de 8 de novembro'), findsOneWidget);
  });

  testWidgets('a long note shrinks to fit instead of being cut', (tester) async {
    final note = List.filled(6, 'Você ficou comigo o dia inteiro sem eu precisar pedir nada.').join(' ');

    await tester.pumpApp(
      Center(child: QuoteShareCard(quote: note, authorName: 'Marina', date: DateTime(2026, 11, 8))),
    );

    expect(tester.takeException(), isNull);
    expect(find.text('— Marina'), findsOneWidget);
    expect(find.text('Cartão de 8 de novembro'), findsOneWidget);
  });
}
