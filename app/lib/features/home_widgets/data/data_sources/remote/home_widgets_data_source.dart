import 'package:app/features/home_widgets/data/data_sources/remote/queries/generated/HomeWidgetCardStatus.graphql.dart';
import 'package:app/features/home_widgets/data/data_sources/remote/queries/generated/HomeWidgetOverview.graphql.dart';
import 'package:network/network.dart';

/// The home widget state and the status of the card it points at.
typedef HomeWidgetOverviewResponse = ({QueryHomeWidgetOverview overview, String? cardStatus});

class HomeWidgetsDataSource({required final GQLClient _client}) {
  Future<HomeWidgetOverviewResponse> getOverview({
    required String userId,
    required DateTime today,
  }) async {
    final response = await _client.query(
      OptionsQueryHomeWidgetOverview(
        variables: VariablesQueryHomeWidgetOverview(userId: userId, today: today),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final overview = validateResponseData(response, getData: (data) => data);
    final cardId = overview.today.firstOrNull?.cardId;
    final cardStatus = cardId == null ? null : await _cardStatus(cardId);

    return (overview: overview, cardStatus: cardStatus);
  }

  Future<String?> _cardStatus(String cardId) async {
    final response = await _client.query(
      OptionsQueryHomeWidgetCardStatus(
        variables: VariablesQueryHomeWidgetCardStatus(cardId: cardId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final card = validateResponseData(response, getData: (data) => data);

    return card.cardsByPk?.status.name;
  }
}
