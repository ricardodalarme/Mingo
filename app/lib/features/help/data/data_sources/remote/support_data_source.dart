import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/help/data/data_sources/remote/mutations/generated/CreateSupportRequest.graphql.dart';
import 'package:core/core.dart';
import 'package:network/network.dart';

class SupportDataSource({required final GQLClient _client}) {
  /// Creates a request and throws when the server stored no row.
  Future<void> createSupportRequest({
    required EnumSupportTopic_enum topic,
    required String message,
    String? replyEmail,
    String? appVersion,
  }) async {
    final response = await _client.mutate(
      OptionsMutationCreateSupportRequest(
        variables: VariablesMutationCreateSupportRequest(
          topic: topic,
          message: message,
          replyEmail: replyEmail,
          appVersion: appVersion,
        ),
      ),
    );
    final created = validateResponseData(
      response,
      getData: (data) => data.insertSupportRequests?.affected_rows ?? 0,
    );
    if (created == 0) throw const LocalizedException(l10nKey: 'SUPPORT_NOT_SENT');
  }
}
