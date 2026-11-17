import 'package:app/features/today/data/data_sources/remote/queries/generated/TodayHome.graphql.dart';
import 'package:app/features/today/data/data_sources/remote/subscriptions/generated/WatchTodaySignals.graphql.dart';
import 'package:network/network.dart';

/// What Hoje shows that can change on the server, compared to tell whether a new read is due.
typedef TodaySignals = ({
  DateTime? localDate,
  String? partnerId,
  String? partnerName,
  int? unopenedCards,
  int? slipsThisWeek,
  int? slipsTotal,
  bool? hasPendingInvite,
  int? unseenSignals,
  String? cardStatus,
  bool? hasPlus,
});

class TodayDataSource({required final GQLClient _client}) {
  Future<QueryTodayHome> getHome() async {
    final response = await _client.query(
      OptionsQueryTodayHome(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response);
  }

  /// Emits the signals of Hoje now and each time the server changes one of them.
  Stream<TodaySignals> watchSignals() {
    return _client.subscribe(OptionsSubscriptionWatchTodaySignals()).mapResponseData((data) {
      final row = data.today.firstOrNull;
      if (row == null) return null;

      return (
        localDate: row.localDate,
        partnerId: row.partnerId,
        partnerName: row.partnerName,
        unopenedCards: row.unopenedCards,
        slipsThisWeek: row.slipsThisWeek,
        slipsTotal: row.slipsTotal,
        hasPendingInvite: row.hasPendingInvite,
        unseenSignals: row.unseenSignals,
        cardStatus: row.card?.status.name,
        hasPlus: row.plus?.hasPlus,
      );
    });
  }
}
