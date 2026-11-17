import 'package:app/features/account/data/data_sources/remote/fragments/generated/DeletionRequestFragment.graphql.dart';
import 'package:app/features/account/data/data_sources/remote/mutations/generated/CancelAccountDeletion.graphql.dart';
import 'package:app/features/account/data/data_sources/remote/mutations/generated/RequestAccountDeletion.graphql.dart';
import 'package:app/features/account/data/data_sources/remote/queries/generated/MyDeletionRequest.graphql.dart';
import 'package:network/network.dart';

class AccountDataSource({required final GQLClient _client, required final RestClient _restClient}) {
  /// The pending deletion, or `null` when there is none.
  Future<FragmentDeletionRequestFragment?> getDeletion(String userId) async {
    final response = await _client.query(
      OptionsQueryMyDeletionRequest(
        variables: VariablesQueryMyDeletionRequest(userId: userId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final data = validateResponseData(response, getData: (data) => data);

    return data.deletionRequestsByPk;
  }

  Future<FragmentDeletionRequestFragment> requestDeletion() async {
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

  /// Builds the person's data file and returns a short-lived link to it.
  ///
  /// Fails with `EXPORT_LIMIT` when a file was already built in the last 24 hours.
  Future<Uri> exportData({required String? accessToken}) async {
    try {
      final response = await _restClient.post<Map<String, Object?>>(
        '/export',
        headers: {'authorization': 'Bearer $accessToken'},
      );
      final url = response.data?['url'];
      if (url is! String) throw const NoDataException();

      return Uri.parse(url);
    } on DioException catch (exception) {
      final body = exception.response?.data;
      final code = body is Map<String, Object?> ? body['error'] : null;

      throw ServerResponseException(code is String ? code : null, exception);
    }
  }
}
