import 'package:app/features/widgets/data/data_sources/remote/mutations/generated/UpdateWidgetSettings.graphql.dart';
import 'package:app/features/widgets/data/data_sources/remote/queries/generated/WidgetCardStatus.graphql.dart';
import 'package:app/features/widgets/data/data_sources/remote/queries/generated/WidgetOverview.graphql.dart';
import 'package:network/network.dart';

/// The widget state and the status of the card it points at.
typedef WidgetOverviewResponse = ({QueryWidgetOverview overview, String? cardStatus});

class WidgetsDataSource({required final GQLClient _client}) {
  Future<WidgetOverviewResponse> getOverview(String userId) async {
    final response = await _client.query(
      OptionsQueryWidgetOverview(
        variables: VariablesQueryWidgetOverview(userId: userId),
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
      OptionsQueryWidgetCardStatus(
        variables: VariablesQueryWidgetCardStatus(cardId: cardId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final card = validateResponseData(response, getData: (data) => data);

    return card.cardsByPk?.status.name;
  }

  Future<void> updateSettings({
    required String userId,
    required bool showNames,
    required bool allowPartnerNotes,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateWidgetSettings(
        variables: VariablesMutationUpdateWidgetSettings(
          userId: userId,
          showNames: showNames,
          allowPartnerNotes: allowPartnerNotes,
        ),
      ),
    );

    validateResponse(response);
  }
}
