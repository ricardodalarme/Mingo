import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListFragment.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListItemFragment.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/AddListItem.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/CreateList.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/DeleteList.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/DeleteListItem.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/RenameList.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/ReorderListItems.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/SetListItemStatus.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/SetListVisibility.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/queries/generated/ListDetail.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/queries/generated/Lists.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/subscriptions/generated/WatchListDetail.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/subscriptions/generated/WatchLists.graphql.dart';
import 'package:network/network.dart';

typedef ListDetailRecord = ({FragmentListFragment list, List<FragmentListItemFragment> items});

class ListsDataSource({required final GQLClient _client}) {
  Future<List<FragmentListFragment>> getLists() async {
    final response = await _client.query(OptionsQueryLists(fetchPolicy: FetchPolicy.networkOnly));

    return List<FragmentListFragment>.of(
      validateResponseData(response, getData: (data) => data.lists),
    );
  }

  /// The list and its items, or null when the list is no longer visible.
  Future<QueryListDetaillistsByPk?> getList(String id) async {
    final response = await _client.query(
      OptionsQueryListDetail(
        variables: VariablesQueryListDetail(id: id),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    validateResponse(response);

    return response.parsedData?.listsByPk;
  }

  /// Emits the lists now and each time one is created, renamed, shared or deleted.
  Stream<List<FragmentListFragment>> watchLists() {
    return _client
        .subscribe(OptionsSubscriptionWatchLists())
        .mapResponseData((data) => List<FragmentListFragment>.of(data.lists));
  }

  /// Emits the list and its items now and each time either changes; null once the list is gone.
  Stream<ListDetailRecord?> watchList(String id) {
    return _client
        .subscribe(
          OptionsSubscriptionWatchListDetail(
            variables: VariablesSubscriptionWatchListDetail(id: id),
          ),
        )
        .map((response) {
          validateResponse(response);
          final node = response.parsedData?.listsByPk;

          return node == null
              ? null
              : (list: node, items: List<FragmentListItemFragment>.of(node.items));
        });
  }

  Future<FragmentListFragment> createList({
    required String id,
    required String title,
    required EnumListKind_enum kind,
    String? coupleId,
  }) async {
    final response = await _client.mutate(
      OptionsMutationCreateList(
        variables: VariablesMutationCreateList(
          id: id,
          title: title,
          kind: kind,
          coupleId: coupleId,
        ),
      ),
    );

    return validateResponseData(response, getData: (data) => data.insertListsOne);
  }

  Future<FragmentListFragment> renameList({required String id, required String title}) async {
    final response = await _client.mutate(
      OptionsMutationRenameList(
        variables: VariablesMutationRenameList(id: id, title: title),
      ),
    );

    return validateResponseData(response, getData: (data) => data.updateListsByPk);
  }

  Future<void> deleteList(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteList(variables: VariablesMutationDeleteList(id: id)),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.deleteLists?.affected_rows,
    );
    if (affected == 0) throw const NoDataException();
  }

  Future<FragmentListFragment> setListVisibility({required String id, String? coupleId}) async {
    final response = await _client.mutate(
      OptionsMutationSetListVisibility(
        // fromJson keeps `coupleId` in the payload even when null; the generated
        // constructor drops a null variable, which turns the update into a no-op.
        variables: VariablesMutationSetListVisibility.fromJson({'id': id, 'coupleId': coupleId}),
      ),
    );

    return validateResponseData(response, getData: (data) => data.updateListsByPk);
  }

  Future<FragmentListItemFragment> addItem({
    required String id,
    required String listId,
    required String title,
    required int position,
  }) async {
    final response = await _client.mutate(
      OptionsMutationAddListItem(
        variables: VariablesMutationAddListItem(
          id: id,
          listId: listId,
          title: title,
          position: position,
        ),
      ),
    );

    return validateResponseData(response, getData: (data) => data.insertListItemsOne);
  }

  Future<FragmentListItemFragment> setItemStatus({
    required String id,
    required EnumListItemStatus_enum status,
  }) async {
    final response = await _client.mutate(
      OptionsMutationSetListItemStatus(
        variables: VariablesMutationSetListItemStatus(id: id, status: status),
      ),
    );

    return validateResponseData(response, getData: (data) => data.updateListItemsByPk);
  }

  /// Sets each item's position to its index in [itemIds] and returns the whole list in order.
  Future<List<FragmentListItemFragment>> reorderItems({
    required String listId,
    required List<String> itemIds,
  }) async {
    final response = await _client.mutate(
      OptionsMutationReorderListItems(
        variables: VariablesMutationReorderListItems(
          updates: [
            for (final (index, id) in itemIds.indexed)
              InputlistItems_updates(
                where: InputlistItems_bool_exp(
                  id: Inputuuid_comparison_exp($_eq: id),
                  listId: Inputuuid_comparison_exp($_eq: listId),
                ),
                $_set: InputlistItems_set_input(position: index),
              ),
          ],
        ),
      ),
    );
    final items = validateResponseData(
      response,
      getData: (data) => data.updateListItemsMany
          ?.expand((result) => result?.returning ?? const <FragmentListItemFragment>[])
          .toList(),
    );

    return [...items]..sort((a, b) => a.position.compareTo(b.position));
  }

  Future<void> deleteItem(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteListItem(variables: VariablesMutationDeleteListItem(id: id)),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.deleteListItems?.affected_rows,
    );
    if (affected == 0) throw const NoDataException();
  }
}
