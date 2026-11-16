import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/InsertLoveStyleManualEntry.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/InsertLoveStyleResult.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/RevokeLoveStyleShare.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/ShareLoveStyle.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/UpdateLoveStyleManualEntry.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/UpdateLoveStyleResult.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/queries/generated/LoveStyleManualEntry.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/queries/generated/LoveStyleResult.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/queries/generated/LoveStyleSharedMessage.graphql.dart';
import 'package:network/network.dart';

/// A saved love-style result with its row id, before the domain mapping.
typedef LoveStyleRecord = ({String id, List<String> ranked});

/// A saved manual entry with its row id, before the domain mapping.
typedef ManualEntryRecord = ({String id, String value});

class LoveStyleDataSource({required final GQLClient _client}) {
  Future<LoveStyleRecord?> getResult() async {
    final response = await _client.query(
      OptionsQueryLoveStyleResult(fetchPolicy: FetchPolicy.networkOnly),
    );
    final rows = validateResponseData(response, getData: (data) => data.quizResults);
    final node = rows.firstOrNull;

    return node == null ? null : (id: node.id, ranked: node.ranked);
  }

  Future<void> insertResult(List<String> ranked) async {
    final response = await _client.mutate(
      OptionsMutationInsertLoveStyleResult(
        variables: VariablesMutationInsertLoveStyleResult(ranked: ranked),
      ),
    );

    validateResponseData(response, getData: (data) => data.insertQuizResultsOne);
  }

  Future<void> updateResult({required String id, required List<String> ranked}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateLoveStyleResult(
        variables: VariablesMutationUpdateLoveStyleResult(id: id, ranked: ranked),
      ),
    );
    final affectedCount = validateResponseData(
      response,
      getData: (data) => data.updateQuizResults?.affected_rows ?? 0,
    );
    if (affectedCount == 0) throw const NoDataException();
  }

  Future<ManualEntryRecord?> getManualEntry(String authorId) async {
    final response = await _client.query(
      OptionsQueryLoveStyleManualEntry(
        variables: VariablesQueryLoveStyleManualEntry(authorId: authorId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.manualEntries);
    final node = rows.firstOrNull;

    return node == null ? null : (id: node.id, value: node.value);
  }

  Future<void> insertManualEntry(String value) async {
    final response = await _client.mutate(
      OptionsMutationInsertLoveStyleManualEntry(
        variables: VariablesMutationInsertLoveStyleManualEntry(value: value),
      ),
    );

    validateResponseData(response, getData: (data) => data.insertManualEntriesOne);
  }

  Future<void> updateManualEntry({required String id, required String value}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateLoveStyleManualEntry(
        variables: VariablesMutationUpdateLoveStyleManualEntry(id: id, value: value),
      ),
    );
    final affectedCount = validateResponseData(
      response,
      getData: (data) => data.updateManualEntries?.affected_rows ?? 0,
    );
    if (affectedCount == 0) throw const NoDataException();
  }

  /// Sends the short description as a note and returns the stored message id.
  Future<String> shareMessage(String body) async {
    final response = await _client.mutate(
      OptionsMutationShareLoveStyle(variables: VariablesMutationShareLoveStyle(body: body)),
    );

    return validateResponseData(response, getData: (data) => data.insertPartnerMessagesOne?.id);
  }

  /// Whether the sender still has a message with [id], so a stored share can be trusted.
  Future<bool> sharedMessageExists(String id) async {
    final response = await _client.query(
      OptionsQueryLoveStyleSharedMessage(
        variables: VariablesQueryLoveStyleSharedMessage(id: id),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    validateResponse(response);

    return response.parsedData?.partnerMessagesByPk != null;
  }

  /// Deletes one of the person's own notes.
  ///
  /// Returns `false` when the row was already gone.
  Future<bool> revokeShare(String id) async {
    final response = await _client.mutate(
      OptionsMutationRevokeLoveStyleShare(variables: VariablesMutationRevokeLoveStyleShare(id: id)),
    );

    return validateResponseData<MutationRevokeLoveStyleShare, bool>(
      response,
      getData: (data) => data.deletePartnerMessagesByPk != null,
    );
  }
}
