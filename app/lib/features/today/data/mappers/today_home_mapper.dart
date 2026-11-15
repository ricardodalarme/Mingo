import 'package:app/features/today/data/data_sources/remote/queries/generated/TodayHome.graphql.dart';
import 'package:app/features/today/data/models/today_home.dart';

extension TodayHomeMapper on QueryTodayHome {
  /// The home state, or `null` when the server returned no `today` row.
  TodayHome? toModel() {
    final state = today;
    if (state == null) return null;

    return TodayHome(
      isPaired: state.isPaired ?? false,
      unopenedCards: state.unopenedCards ?? 0,
      slipsThisWeek: state.slipsThisWeek ?? 0,
      slipsTotal: state.slipsTotal ?? 0,
      hasPendingInvite: state.hasPendingInvite ?? false,
      hasPlus: state.hasPlus ?? false,
      unseenSignals: state.unseenSignals ?? 0,
      partnerName: state.partnerName,
      localDate: state.localDate,
      cardStatus: state.cardStatus,
      togetherSince: state.togetherSince,
      slipDays: [for (final day in state.slipDays ?? const <DateTime?>[]) ?day],
      question: question == null
          ? null
          : Suggestion(
              slug: question!.slug,
              title: question!.title,
              tags: question!.tags.whereType<String>().toList(),
            ),
      idea: idea == null
          ? null
          : Suggestion(slug: idea!.slug, title: idea!.title, body: idea!.body),
    );
  }
}
