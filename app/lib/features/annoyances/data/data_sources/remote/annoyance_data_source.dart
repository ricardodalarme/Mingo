import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/DeleteAnnoyance.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/SaveAnnoyance.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/SendGentleRequest.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/queries/generated/MyAnnoyance.graphql.dart';
import 'package:network/network.dart';

class AnnoyanceDataSource({required final GQLClient _client}) {
  Future<MutationSaveAnnoyanceinsertAnnoyancesOne> save(String body) async {
    final response = await _client.mutate(
      OptionsMutationSaveAnnoyance(variables: VariablesMutationSaveAnnoyance(body: body)),
    );

    return validateResponseData(response, getData: (data) => data.insertAnnoyancesOne);
  }

  /// The annoyance, or null when it is gone or not the person's.
  Future<QueryMyAnnoyanceannoyancesByPk?> get(String id) async {
    final response = await _client.query(
      OptionsQueryMyAnnoyance(
        variables: VariablesQueryMyAnnoyance(id: id),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    validateResponse(response);

    return response.parsedData?.annoyancesByPk;
  }

  Future<void> delete(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteAnnoyance(variables: VariablesMutationDeleteAnnoyance(id: id)),
    );

    validateResponse(response);
  }

  /// Sends the three sentences to the partner and, when [annoyanceId] is given, removes that annoyance.
  ///
  /// Returns whether a request was created; there is none without a partner.
  Future<bool> sendGentleRequest({
    required String whenText,
    required String feelText,
    required String wishText,
    String? annoyanceId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSendGentleRequest(
        variables: VariablesMutationSendGentleRequest(
          whenText: whenText,
          feelText: feelText,
          wishText: wishText,
          annoyanceId: annoyanceId,
        ),
      ),
    );
    validateResponse(response);

    return response.parsedData?.sendGentleRequest.isNotEmpty ?? false;
  }
}
