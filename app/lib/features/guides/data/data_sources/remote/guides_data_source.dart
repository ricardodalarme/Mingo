import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/guides/data/data_sources/remote/mutations/generated/InsertConversationPrep.graphql.dart';
import 'package:app/features/guides/data/data_sources/remote/mutations/generated/UpdateConversationPrep.graphql.dart';
import 'package:network/network.dart';

class GuidesDataSource({required final GQLClient _client}) {
  /// Inserts a private preparation and returns the row id.
  Future<String> insertPrep({
    required String id,
    required EnumConversationGuide_enum guide,
    required String topic,
    required String? notes,
    required String? draft,
  }) async {
    final response = await _client.mutate(
      OptionsMutationInsertConversationPrep(
        variables: VariablesMutationInsertConversationPrep(
          id: id,
          guide: guide,
          topic: topic,
          notes: notes,
          draft: draft,
        ),
      ),
    );
    final record = validateResponseData(
      response,
      getData: (data) => data.insertConversationPrepsOne,
    );

    return record.id;
  }

  Future<void> updatePrep({
    required String id,
    required EnumConversationGuide_enum guide,
    required String topic,
    required String? notes,
    required String? draft,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateConversationPrep(
        variables: VariablesMutationUpdateConversationPrep(
          id: id,
          guide: guide,
          topic: topic,
          notes: notes,
          draft: draft,
        ),
      ),
    );
    validateResponseData(response, getData: (data) => data.updateConversationPrepsByPk?.id);
  }
}
