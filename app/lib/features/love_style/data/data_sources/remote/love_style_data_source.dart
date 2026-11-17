import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/InsertLoveStyleManualEntry.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/InsertLoveStyleResult.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/UpdateLoveStyleManualEntry.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/UpdateLoveStyleResult.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/mutations/generated/UpdateLoveStyleShare.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/queries/generated/LoveStyleManualEntry.graphql.dart';
import 'package:app/features/love_style/data/data_sources/remote/queries/generated/LoveStyleResults.graphql.dart';
import 'package:network/network.dart';

/// A saved love-style result with its row id and share time, before the domain mapping.
typedef LoveStyleRecord = ({String id, String authorId, List<String> ranked, DateTime? sharedAt});

/// The person and whichever results they may read.
typedef LoveStyleResultsRecord = ({String selfId, List<LoveStyleRecord> rows});

/// A saved manual entry with its row id, before the domain mapping.
typedef ManualEntryRecord = ({String id, String value});

class LoveStyleDataSource({required final GQLClient _client}) {
  Future<LoveStyleResultsRecord> getResults() async {
    final response = await _client.query(
      OptionsQueryLoveStyleResults(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryLoveStyleResults, QueryLoveStyleResults>(response);
    final selfId = data.today.firstOrNull?.userId;
    if (selfId == null) throw const NoDataException();

    return (
      selfId: selfId,
      rows: [
        for (final row in data.quizResults)
          (id: row.id, authorId: row.authorId, ranked: row.ranked, sharedAt: row.sharedAt),
      ],
    );
  }

  Future<String> insertResult(List<String> ranked) async {
    final response = await _client.mutate(
      OptionsMutationInsertLoveStyleResult(
        variables: VariablesMutationInsertLoveStyleResult(ranked: ranked),
      ),
    );

    return validateResponseData(response, getData: (data) => data.insertQuizResultsOne!.id);
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

  /// Shows the result to the partner, or hides it again.
  Future<void> setShared({required String id, required DateTime? sharedAt}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateLoveStyleShare(
        variables: VariablesMutationUpdateLoveStyleShare(id: id, sharedAt: sharedAt),
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
}
