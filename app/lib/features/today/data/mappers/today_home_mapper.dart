import 'package:app/features/today/data/data_sources/remote/queries/generated/TodayHome.graphql.dart';
import 'package:app/features/today/data/models/today_home.dart';

extension TodayHomeMapper on QueryTodayHome {
  /// The home state, or `null` when the server returned no `today` row.
  TodayHome? toModel() {
    final state = today.firstOrNull;
    if (state == null) return null;
    final question = this.question.firstOrNull;
    final idea = this.idea.firstOrNull;

    return TodayHome(
      isPaired: state.partnerId != null,
      unopenedCards: state.unopenedCards ?? 0,
      slipsThisWeek: state.slipsThisWeek ?? 0,
      slipsTotal: state.slipsTotal ?? 0,
      hasPendingInvite: state.hasPendingInvite ?? false,
      hasPlus: state.plus?.hasPlus ?? false,
      unseenSignals: state.unseenSignals ?? 0,
      partnerName: state.partnerName,
      localDate: state.localDate,
      cardStatus: state.card?.status.name,
      togetherSince: state.togetherSince,
      slipDays: state.slipDays ?? const [],
      question: question == null
          ? null
          : Suggestion(slug: question.slug, title: question.title, tags: question.tags),
      idea: idea == null ? null : Suggestion(slug: idea.slug, title: idea.title, body: idea.body),
    );
  }
}
