import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/chat/data/data_sources/remote/mutations/generated/AddLearnedItem.graphql.dart';
import 'package:app/features/chat/data/data_sources/remote/mutations/generated/DeleteLearnedItem.graphql.dart';
import 'package:app/features/chat/data/data_sources/remote/mutations/generated/SetLearnedItemStatus.graphql.dart';
import 'package:app/features/chat/data/data_sources/remote/mutations/generated/UpdateLearnedItem.graphql.dart';
import 'package:app/features/chat/data/data_sources/remote/queries/generated/LearnedItems.graphql.dart';
import 'package:network/network.dart';

class LearnedItemsDataSource({required final GQLClient _client}) {
  Future<List<QueryLearnedItemslearnedItems>> getItems() async {
    final response = await _client.query(
      OptionsQueryLearnedItems(fetchPolicy: FetchPolicy.networkOnly),
    );
    final rows = validateResponseData(response, getData: (data) => data.learnedItems);

    return rows;
  }

  Future<MutationAddLearnedIteminsertLearnedItemsOne> add({
    required EnumLearnedItemTarget_enum target,
    required String text,
    String? excerpt,
  }) async {
    final response = await _client.mutate(
      OptionsMutationAddLearnedItem(
        variables: VariablesMutationAddLearnedItem(target: target, text: text, excerpt: excerpt),
      ),
    );
    final row = validateResponseData(response, getData: (data) => data.insertLearnedItemsOne);

    return row;
  }

  Future<void> updateText({required String id, required String text}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateLearnedItem(
        variables: VariablesMutationUpdateLearnedItem(id: id, text: text),
      ),
    );
    validateResponseData(response, getData: (data) => data.updateLearnedItemsByPk);
  }

  Future<void> setStatus({required String id, required EnumLearnedItemStatus_enum status}) async {
    final response = await _client.mutate(
      OptionsMutationSetLearnedItemStatus(
        variables: VariablesMutationSetLearnedItemStatus(id: id, status: status),
      ),
    );
    validateResponseData(response, getData: (data) => data.updateLearnedItemsByPk);
  }

  Future<void> delete(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteLearnedItem(variables: VariablesMutationDeleteLearnedItem(id: id)),
    );
    validateResponseData(response, getData: (data) => data.deleteLearnedItemsByPk);
  }
}
