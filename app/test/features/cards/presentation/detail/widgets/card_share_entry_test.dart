import 'package:app/features/cards/data/models/card_detail.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/cards/presentation/detail/widgets/card_share_entry.dart';
import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_image_entry.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

CardDetail _detail({
  required bool isMine,
  String? note,
  List<CardItem> items = const [],
  String? authorName = 'Marina',
}) => CardDetail(
  card: SundayCard(
    id: 'card-1',
    status: CardStatus.sent,
    weekStart: DateTime(2026, 11, 8),
    items: items,
    note: note,
  ),
  isMine: isMine,
  authorName: authorName,
);

ShareQuoteCard _quoteOf(WidgetTester tester) =>
    tester.widget<ShareImageEntry>(find.byType(ShareImageEntry)).cards.single as ShareQuoteCard;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('quotes the note of a card the person received', (tester) async {
    await tester.pumpApp(
      Center(
        child: CardShareEntry(
          detail: _detail(
            isMine: false,
            note: 'Obrigada por cada café.',
            items: const [CardItem(slipId: 's1', body: 'Fez café')],
          ),
        ),
      ),
    );

    expect(find.text('Compartilhar imagem'), findsOneWidget);
    expect(find.text('Uma frase do cartão que chegou para você.'), findsOneWidget);

    final quote = _quoteOf(tester);
    expect(quote.quote, 'Obrigada por cada café.');
    expect(quote.authorName, 'Marina');
    expect(quote.date, DateTime(2026, 11, 8));
  });

  testWidgets('falls back to the first good thing when the card has no note', (tester) async {
    await tester.pumpApp(
      Center(
        child: CardShareEntry(
          detail: _detail(
            isMine: false,
            items: const [
              CardItem(slipId: 's1', body: 'Fez café'),
              CardItem(slipId: 's2', body: 'Me ouviu'),
            ],
          ),
        ),
      ),
    );

    expect(_quoteOf(tester).quote, 'Fez café');
  });

  testWidgets('a card the person sent offers no quote', (tester) async {
    await tester.pumpApp(
      Center(
        child: CardShareEntry(
          detail: _detail(
            isMine: true,
            note: 'Uma semana boa.',
            items: const [CardItem(slipId: 's1', body: 'Fez café')],
          ),
        ),
      ),
    );

    expect(find.byType(ShareImageEntry), findsNothing);
  });

  testWidgets('a received card with nothing written offers no quote', (tester) async {
    await tester.pumpApp(Center(child: CardShareEntry(detail: _detail(isMine: false))));

    expect(find.byType(ShareImageEntry), findsNothing);
  });
}
