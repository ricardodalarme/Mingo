import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_cards.dart';
import 'package:app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

TodayHome _home({
  bool isPaired = true,
  int unopenedCards = 0,
  int slipsThisWeek = 0,
  bool hasPendingInvite = false,
  String? cardStatus,
  Suggestion? question = const Suggestion(slug: 'mania', title: 'Qual é uma mania dele?'),
  Suggestion? idea = const Suggestion(slug: 'bilhete', title: 'Deixe um bilhete'),
}) => TodayHome(
  isPaired: isPaired,
  unopenedCards: unopenedCards,
  slipsThisWeek: slipsThisWeek,
  slipsTotal: slipsThisWeek,
  hasPendingInvite: hasPendingInvite,
  hasPlus: false,
  partnerName: 'Luanna',
  cardStatus: cardStatus,
  question: question,
  idea: idea,
);

void main() {
  group('todayCardsFor', () {
    test('the connected carousel follows the board order', () {
      final kinds = todayCardsFor(
        home: _home(unopenedCards: 1, slipsThisWeek: 2, cardStatus: 'draft'),
        isSoloOnly: false,
        partnerMoodVisible: true,
      );

      expect(kinds, [
        TodayCardKind.receivedCard,
        TodayCardKind.ownCard,
        TodayCardKind.partnerMoment,
      ]);
    });

    test('a received card and the idea make two cards', () {
      final kinds = todayCardsFor(
        home: _home(unopenedCards: 1, slipsThisWeek: 2),
        isSoloOnly: false,
        partnerMoodVisible: false,
      );

      expect(kinds, [TodayCardKind.receivedCard, TodayCardKind.idea]);
    });

    test('on your own the invite comes first', () {
      final kinds = todayCardsFor(
        home: _home(isPaired: false, slipsThisWeek: 2),
        isSoloOnly: false,
        partnerMoodVisible: false,
      );

      expect(kinds, [TodayCardKind.invite, TodayCardKind.idea]);
    });

    test('solo-only drops the invite', () {
      final kinds = todayCardsFor(
        home: _home(isPaired: false, slipsThisWeek: 2),
        isSoloOnly: true,
        partnerMoodVisible: false,
      );

      expect(kinds, isNot(contains(TodayCardKind.invite)));
    });

    test('a pending invite has no invite card of its own', () {
      final kinds = todayCardsFor(
        home: _home(isPaired: false, hasPendingInvite: true, slipsThisWeek: 2),
        isSoloOnly: false,
        partnerMoodVisible: false,
      );

      expect(kinds, isNot(contains(TodayCardKind.invite)));
    });

    test('never more than the board limit', () {
      final kinds = todayCardsFor(
        home: _home(unopenedCards: 1, slipsThisWeek: 2, cardStatus: 'held'),
        isSoloOnly: false,
        partnerMoodVisible: true,
      );

      expect(kinds.length, lessThanOrEqualTo(todayCardLimit));
      expect(kinds, contains(TodayCardKind.idea));
    });

    test('the first day keeps para hoje to the idea', () {
      final kinds = todayCardsFor(
        home: _home(isPaired: false, slipsThisWeek: 1),
        isSoloOnly: false,
        partnerMoodVisible: false,
        isFirstDay: true,
      );

      expect(kinds, [TodayCardKind.idea]);
    });

    test('no card without content to fill it', () {
      final kinds = todayCardsFor(
        home: _home(question: null, idea: null),
        isSoloOnly: false,
        partnerMoodVisible: false,
      );

      expect(kinds, isEmpty);
    });

    test("the partner's mood card needs a partner", () {
      final kinds = todayCardsFor(
        home: _home(isPaired: false),
        isSoloOnly: false,
        partnerMoodVisible: true,
      );

      expect(kinds, isNot(contains(TodayCardKind.partnerMoment)));
    });
  });

  group('todayCardRoute', () {
    final home = _home();

    test('a received card opens the cards', () {
      expect(todayCardRoute(TodayCardKind.receivedCard, home: home), isA<CardsListRoute>());
    });

    test('a ready card opens the Sunday card', () {
      expect(todayCardRoute(TodayCardKind.ownCard, home: home), isA<SundayCardRoute>());
    });

    test('the idea opens its own detail', () {
      final route = todayCardRoute(TodayCardKind.idea, home: home)! as IdeaDetailRoute;

      expect(route.args?.slug, 'bilhete');
    });

    test('the invite opens the invite screen', () {
      expect(todayCardRoute(TodayCardKind.invite, home: home), isA<InviteRoute>());
    });

    test('the moment acts on Hoje', () {
      expect(todayCardRoute(TodayCardKind.partnerMoment, home: home), isNull);
    });
  });
}
