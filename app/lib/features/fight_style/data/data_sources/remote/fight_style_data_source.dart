import 'package:app/features/fight_style/data/data_sources/remote/mutations/generated/AddRepairTool.graphql.dart';
import 'package:app/features/fight_style/data/data_sources/remote/mutations/generated/InsertFightStyleResult.graphql.dart';
import 'package:app/features/fight_style/data/data_sources/remote/mutations/generated/UpdateFightStyleResult.graphql.dart';
import 'package:app/features/fight_style/data/data_sources/remote/queries/generated/FightStyleResult.graphql.dart';
import 'package:network/network.dart';

/// A saved reaction result with its row id, before the domain mapping.
typedef FightStyleRecord = ({String id, List<String> ranked});

class FightStyleDataSource({required final GQLClient _client}) {
  Future<FightStyleRecord?> getResult() async {
    final response = await _client.query(
      OptionsQueryFightStyleResult(fetchPolicy: FetchPolicy.networkOnly),
    );
    final rows = validateResponseData(response, getData: (data) => data.quizResults);
    final node = rows.firstOrNull;

    return node == null ? null : (id: node.id, ranked: node.ranked);
  }

  Future<void> insertResult(List<String> ranked) async {
    final response = await _client.mutate(
      OptionsMutationInsertFightStyleResult(
        variables: VariablesMutationInsertFightStyleResult(ranked: ranked),
      ),
    );

    validateResponseData(response, getData: (data) => data.insertQuizResultsOne);
  }

  Future<void> updateResult({required String id, required List<String> ranked}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateFightStyleResult(
        variables: VariablesMutationUpdateFightStyleResult(id: id, ranked: ranked),
      ),
    );
    final affectedCount = validateResponseData(
      response,
      getData: (data) => data.updateQuizResults?.affected_rows ?? 0,
    );
    if (affectedCount == 0) throw const NoDataException();
  }

  /// Adds a private repair tool as a `trigger` learning row.
  Future<void> addRepairTool({required String id, required String note}) async {
    final response = await _client.mutate(
      OptionsMutationAddRepairTool(
        variables: VariablesMutationAddRepairTool(id: id, note: note),
      ),
    );

    validateResponse(response);
  }
}
