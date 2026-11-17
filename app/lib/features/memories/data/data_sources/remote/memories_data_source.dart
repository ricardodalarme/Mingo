import 'package:app/features/memories/data/data_sources/remote/mutations/generated/AddMemory.graphql.dart';
import 'package:app/features/memories/data/data_sources/remote/mutations/generated/DeleteMemory.graphql.dart';
import 'package:app/features/memories/data/data_sources/remote/queries/generated/Memories.graphql.dart';
import 'package:network/network.dart';

class MemoriesDataSource({required final GQLClient _client}) {
  Future<List<QueryMemoriesmemories>> getMemories() async {
    final response = await _client.query(
      OptionsQueryMemories(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.memories);
  }

  Future<void> addMemory({
    required String id,
    required String title,
    required DateTime happenedOn,
    String? body,
    String? place,
    String? coupleId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationAddMemory(
        variables: VariablesMutationAddMemory(
          id: id,
          title: title,
          body: body,
          happenedOn: happenedOn,
          place: place,
          coupleId: coupleId,
        ),
      ),
    );

    validateResponse(response);
  }

  Future<void> deleteMemory(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteMemory(variables: VariablesMutationDeleteMemory(id: id)),
    );

    validateResponse(response);
  }
}
