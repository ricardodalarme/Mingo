import 'package:app/features/account/data/data_sources/remote/mutations/generated/CancelAccountDeletion.graphql.dart';
import 'package:app/features/account/data/data_sources/remote/mutations/generated/RequestAccountDeletion.graphql.dart';
import 'package:app/features/account/data/data_sources/remote/queries/generated/MyDeletionRequest.graphql.dart';
import 'package:network/network.dart';

class AccountDataSource({required final GQLClient _client}) {
  /// The pending deletion, or `null` when there is none.
  Future<QueryMyDeletionRequestdeletionRequestsByPk?> getDeletion(String userId) async {
    final response = await _client.query(
      OptionsQueryMyDeletionRequest(
        variables: VariablesQueryMyDeletionRequest(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final data = validateResponseData(response, getData: (data) => data);

    return data.deletionRequestsByPk;
  }

  Future<MutationRequestAccountDeletioninsertDeletionRequestsOne> requestDeletion() async {
    final response = await _client.mutate(OptionsMutationRequestAccountDeletion());

    return validateResponseData(response, getData: (data) => data.insertDeletionRequestsOne);
  }

  Future<void> cancelDeletion(String userId) async {
    final response = await _client.mutate(
      OptionsMutationCancelAccountDeletion(
        variables: VariablesMutationCancelAccountDeletion(userId: userId),
      ),
    );

    validateResponse(response);
  }
}
