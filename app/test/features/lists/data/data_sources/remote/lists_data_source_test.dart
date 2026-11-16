import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/lists_data_source.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/DeleteListItem.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/ReorderListItems.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/mutations/generated/SetListItemStatus.graphql.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

class const _StubGQLClient(final QueryResult<Object?> _result) implements GQLClient {
  @override
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async => _result as QueryResult<T>;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _CapturingGQLClient(
  final Map<String, dynamic> _data, {
  required final void Function(MutationOptions<Object?>) onMutate,
}) implements GQLClient {
  @override
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async {
    onMutate(options);

    return QueryResult.loading(options: options, data: _data);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const Map<String, dynamic> _list = {
  'id': 'l1',
  'title': 'Viagens',
  'kind': 'travel',
  'authorId': 'user-1',
  'coupleId': null,
  '__typename': 'lists',
};

Map<String, dynamic> _item(String id, int position, {String status = 'done'}) => {
  'id': id,
  'listId': 'l1',
  'title': 'Lisboa',
  'status': status,
  'position': position,
  '__typename': 'listItems',
};

QueryResult<T> _result<T>(MutationOptions<T> options, Map<String, dynamic> data) =>
    QueryResult.loading(options: options, data: data);

void main() {
  final statusOptions = OptionsMutationSetListItemStatus(
    variables: VariablesMutationSetListItemStatus(id: 'i1', status: EnumListItemStatus_enum.done),
  );

  test('a status change that matches no row fails', () {
    final dataSource = ListsDataSource(
      client: _StubGQLClient(
        _result(statusOptions, {'updateListItemsByPk': null, '__typename': 'Mutation'}),
      ),
    );

    expect(
      dataSource.setItemStatus(id: 'i1', status: EnumListItemStatus_enum.done),
      throwsA(isA<NoDataException>()),
    );
  });

  test('a status change returns the row as the server stored it', () async {
    final dataSource = ListsDataSource(
      client: _StubGQLClient(
        _result(statusOptions, {'updateListItemsByPk': _item('i1', 3), '__typename': 'Mutation'}),
      ),
    );

    final saved = await dataSource.setItemStatus(id: 'i1', status: EnumListItemStatus_enum.done);

    expect(saved.id, 'i1');
    expect(saved.position, 3);
    expect(saved.status, EnumListItemStatus_enum.done);
  });

  test('reordering sends one update per item and returns the list in order', () async {
    MutationOptions<Object?>? captured;
    final dataSource = ListsDataSource(
      client: _CapturingGQLClient({
        'updateListItemsMany': [
          {
            'returning': [_item('i2', 0, status: 'dream')],
            '__typename': 'listItems_mutation_response',
          },
          {
            'returning': [_item('i1', 1)],
            '__typename': 'listItems_mutation_response',
          },
        ],
        '__typename': 'Mutation',
      }, onMutate: (options) => captured = options),
    );

    final items = await dataSource.reorderItems(listId: 'l1', itemIds: ['i2', 'i1']);

    expect(captured, isA<MutationOptions<MutationReorderListItems>>());
    expect(captured!.variables, {
      'updates': [
        {
          'where': {
            'id': {'_eq': 'i2'},
            'listId': {'_eq': 'l1'},
          },
          '_set': {'position': 0},
        },
        {
          'where': {
            'id': {'_eq': 'i1'},
            'listId': {'_eq': 'l1'},
          },
          '_set': {'position': 1},
        },
      ],
    });
    expect([for (final item in items) item.id], ['i2', 'i1']);
    expect([for (final item in items) item.position], [0, 1]);
  });

  test('deleting an item that is already gone fails', () {
    final options = OptionsMutationDeleteListItem(
      variables: VariablesMutationDeleteListItem(id: 'i1'),
    );
    final dataSource = ListsDataSource(
      client: _StubGQLClient(
        _result(options, {
          'deleteListItems': {'affected_rows': 0, '__typename': 'listItems_mutation_response'},
          '__typename': 'Mutation',
        }),
      ),
    );

    expect(dataSource.deleteItem('i1'), throwsA(isA<NoDataException>()));
  });

  test('making a list private sends coupleId as null instead of dropping it', () async {
    MutationOptions<Object?>? captured;
    final dataSource = ListsDataSource(
      client: _CapturingGQLClient({
        'updateListsByPk': _list,
        '__typename': 'Mutation',
      }, onMutate: (options) => captured = options),
    );

    final saved = await dataSource.setListVisibility(id: 'l1');

    final variables = captured!.variables;
    expect(variables.containsKey('coupleId'), isTrue);
    expect(variables['coupleId'], isNull);
    expect(saved.coupleId, isNull);
  });
}
