import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_section.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_helpers/pump_app.dart';

TodayHome _home({
  bool isPaired = true,
  int unopenedCards = 0,
  int slipsThisWeek = 0,
  String? cardStatus,
  Suggestion? question = const Suggestion(slug: 'mania', title: 'Qual é uma mania dele?'),
  Suggestion? idea = const Suggestion(slug: 'bilhete', title: 'Deixe um bilhete'),
}) => TodayHome(
  isPaired: isPaired,
  unopenedCards: unopenedCards,
  slipsThisWeek: slipsThisWeek,
  slipsTotal: slipsThisWeek,
  hasPendingInvite: false,
  hasPlus: false,
  partnerName: 'Luanna',
  cardStatus: cardStatus,
  question: question,
  idea: idea,
);

List<String> _tags(WidgetTester tester) => [
  for (final child in tester.widget<BaseCarousel>(find.byType(BaseCarousel)).children)
    (child as BaseCarouselCard).tag,
];

void main() {
  setUp(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  testWidgets('the carousel keeps the board order and shows the section title', (tester) async {
    await tester.pumpApp(
      TodaySection(
        home: _home(unopenedCards: 1, slipsThisWeek: 2),
        isSoloOnly: false,
        partnerMood: PartnerMood(day: DateTime(2026, 11, 8), mood: MoodKind.tired),
        partnerName: 'Luanna',
        onSeeIdeas: () {},
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Para hoje'), findsOneWidget);
    expect(_tags(tester), ['Cartão', 'Para este momento', 'Hoje', 'Sua semana', 'Ideia do dia']);
  });

  testWidgets('a single card is a row with its own action, not a carousel', (tester) async {
    await tester.pumpApp(
      TodaySection(
        home: _home(isPaired: false, question: null),
        isSoloOnly: true,
        partnerMood: null,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(BaseCarousel), findsNothing);
    final card = tester.widget<BaseListCard>(find.byType(BaseListCard));
    expect(card.categoryLabel, 'Ideia do dia');
    expect(card.onTap, isNotNull);
  });

  testWidgets('the moment card names the mood and offers the ideas', (tester) async {
    await tester.pumpApp(
      TodaySection(
        home: _home(slipsThisWeek: 1),
        isSoloOnly: false,
        partnerMood: PartnerMood(day: DateTime(2026, 11, 8), mood: MoodKind.tired),
        partnerName: 'Luanna',
        onSeeIdeas: () {},
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Luanna está sem energia hoje'), findsWidgets);
    expect(find.text('Uma ideia pequena pode ajudar.'), findsWidgets);
    expect(find.text('Ver ideias'), findsWidgets);
  });

  testWidgets('every carousel card has an action', (tester) async {
    await tester.pumpApp(
      TodaySection(home: _home(unopenedCards: 2, slipsThisWeek: 2), isSoloOnly: false),
    );
    await tester.pumpAndSettle();

    for (final child in tester.widget<BaseCarousel>(find.byType(BaseCarousel)).children) {
      final card = child as BaseCarouselCard;
      expect(card.actionText, isNotEmpty, reason: card.tag);
      expect(card.onAction, isNotNull, reason: card.tag);
    }
  });

  testWidgets('nothing to offer leaves the section out', (tester) async {
    await tester.pumpApp(
      TodaySection(home: _home(question: null, idea: null), isSoloOnly: true, partnerMood: null),
    );
    await tester.pumpAndSettle();

    expect(find.text('Para hoje'), findsNothing);
    expect(find.byType(BaseCarousel), findsNothing);
  });
}
