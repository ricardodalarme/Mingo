import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notes/data/data_sources/remote/mutations/generated/DeletePartnerMessage.graphql.dart';
import 'package:app/features/notes/data/data_sources/remote/mutations/generated/SendPartnerMessage.graphql.dart';
import 'package:app/features/notes/data/data_sources/remote/queries/generated/SentPartnerMessages.graphql.dart';
import 'package:network/network.dart';

class NotesDataSource({required final GQLClient _client}) {
  Future<List<QuerySentPartnerMessagespartnerMessages>> getSent(String senderId) async {
    final response = await _client.query(
      OptionsQuerySentPartnerMessages(
        variables: VariablesQuerySentPartnerMessages(senderId: senderId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.partnerMessages);

    return rows;
  }

  Future<void> send({
    required EnumPartnerMessageKind_enum kind,
    String? body,
    String? mediaFileId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSendPartnerMessage(
        variables: VariablesMutationSendPartnerMessage(
          kind: kind,
          body: body,
          mediaFileId: mediaFileId,
        ),
      ),
    );

    validateResponse(response);
  }

  /// Whether the server removed the row; `false` means it was already gone.
  Future<bool> delete(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeletePartnerMessage(
        variables: VariablesMutationDeletePartnerMessage(messageId: id),
      ),
    );

    return validateResponseData(
      response,
      getData: (data) => data.deletePartnerMessagesByPk != null,
    );
  }
}
