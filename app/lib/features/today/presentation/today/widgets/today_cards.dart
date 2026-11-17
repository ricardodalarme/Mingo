import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';

/// A card "Para hoje" can show, in the fixed order: what is urgent, then what is for the two of
/// you, then what is yours, the invite and the tip last.
enum TodayCardKind() {
  receivedCard,
  ownCard,
  partnerMoment,
  question,
  invite,
  weekSummary,
  idea,
}

/// The most cards "Para hoje" shows at once.
const int todayCardLimit = 5;

/// The cards of "Para hoje" for [home], in the fixed order and capped at [todayCardLimit].
///
/// A card is only listed when Hoje has the content to fill it: no received card without an
/// unopened one, no moment without a shared mood, no question without today's question. On the
/// first day the section keeps to the idea, so the screen explains itself before asking for more.
List<TodayCardKind> todayCardsFor({
  required TodayHome home,
  required bool isSoloOnly,
  required bool partnerMoodVisible,
  bool isFirstDay = false,
}) {
  if (isFirstDay) return [if (home.idea != null) TodayCardKind.idea];

  final isAlone = !home.isPaired;
  final canInvite = isAlone && !isSoloOnly && !home.hasPendingInvite;

  return [
    if (home.unopenedCards > 0) TodayCardKind.receivedCard,
    if (home.hasCardToSend) TodayCardKind.ownCard,
    if (!isAlone && partnerMoodVisible) TodayCardKind.partnerMoment,
    if (home.question != null) TodayCardKind.question,
    if (canInvite) TodayCardKind.invite,
    if (home.slipsThisWeek > 0) TodayCardKind.weekSummary,
    if (home.idea != null) TodayCardKind.idea,
  ].take(todayCardLimit).toList();
}

/// The screen a card opens, or null when the card acts on Hoje itself.
PageRouteInfo<void>? todayCardRoute(TodayCardKind kind, {required TodayHome home}) {
  return switch (kind) {
    TodayCardKind.receivedCard => const CardsListRoute(),
    TodayCardKind.ownCard => const SundayCardRoute(),
    TodayCardKind.weekSummary => const WeeklyReviewRoute(),
    TodayCardKind.idea => IdeaDetailRoute(slug: home.idea?.slug ?? ''),
    TodayCardKind.invite => const InviteRoute(),
    TodayCardKind.partnerMoment || TodayCardKind.question => null,
  };
}
