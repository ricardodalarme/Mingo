import 'package:app/features/annoyances/data/data_sources/remote/fragments/generated/GentleRequestFragment.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/DeleteAnnoyance.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/MarkGentleRequestSeen.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/RespondGentleRequest.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/SaveAnnoyance.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/SendGentleRequest.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/mutations/generated/ThankGentleRequest.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/queries/generated/GentleRequestById.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/queries/generated/MyAnnoyance.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/subscriptions/generated/WatchGentleRequest.graphql.dart';
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

  /// One gentle request the person sent or received, or null when it is gone.
  Future<FragmentGentleRequestFragment?> getGentleRequest(String id) async {
    final response = await _client.query(
      OptionsQueryGentleRequestById(
        variables: VariablesQueryGentleRequestById(id: id),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    validateResponse(response);

    return response.parsedData?.gentleRequestsByPk;
  }

  /// Emits the request now and each time the other person answers, sees or thanks for it.
  Stream<FragmentGentleRequestFragment> watchGentleRequest(String id) {
    return _client
        .subscribe(
          OptionsSubscriptionWatchGentleRequest(
            variables: VariablesSubscriptionWatchGentleRequest(id: id),
          ),
        )
        .mapResponseData((data) => data.gentleRequestsByPk);
  }

  Future<void> respond({required String id, required String response}) async {
    final result = await _client.mutate(
      OptionsMutationRespondGentleRequest(
        variables: VariablesMutationRespondGentleRequest(
          id: id,
          response: response,
          seenAt: DateTime.now().toUtc(),
        ),
      ),
    );

    validateResponse(result);
  }

  Future<void> markSeen(String id) async {
    final result = await _client.mutate(
      OptionsMutationMarkGentleRequestSeen(
        variables: VariablesMutationMarkGentleRequestSeen(id: id, seenAt: DateTime.now().toUtc()),
      ),
    );

    validateResponse(result);
  }

  /// Thanks for a kept promise; the thanks becomes a good slip for the sender.
  Future<void> thank({required String requestId, required String body}) async {
    final result = await _client.mutate(
      OptionsMutationThankGentleRequest(
        variables: VariablesMutationThankGentleRequest(requestId: requestId, body: body),
      ),
    );

    validateResponse(result);
  }
}
