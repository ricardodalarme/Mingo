import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SetSpiceEnabled.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/MySpiceSetting.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceCards.graphql.dart';
import 'package:network/network.dart';

class SpiceDataSource({required final GQLClient _client}) {
  /// Whether the person switched the mode on; false when no settings row is found.
  Future<bool> getEnabled(String userId) async {
    final response = await _client.query(
      OptionsQueryMySpiceSetting(
        variables: VariablesQueryMySpiceSetting(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    validateResponse(response);

    return response.parsedData?.userSettingsByPk?.spiceEnabled ?? false;
  }

  Future<int> setEnabled({required String userId, required bool enabled}) async {
    final response = await _client.mutate(
      OptionsMutationSetSpiceEnabled(
        variables: VariablesMutationSetSpiceEnabled(userId: userId, enabled: enabled),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.updateUserSettings?.affected_rows ?? 0,
    );
  }

  /// The card texts; the server returns none unless both people switched the mode on.
  Future<List<String>> getCards(String locale) async {
    final response = await _client.query(
      OptionsQuerySpiceCards(
        variables: VariablesQuerySpiceCards(locale: locale),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final cards = validateResponseData(response, getData: (data) => data.contentItems);

    return [for (final card in cards) card.title];
  }
}
