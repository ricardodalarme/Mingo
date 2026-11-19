import 'package:app/features/gifts/data/data_sources/remote/gifts_data_source.dart';
import 'package:app/features/gifts/data/data_sources/remote/mutations/generated/AddGiftWish.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/mutations/generated/DeleteGiftWish.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/mutations/generated/UpdateGiftWish.graphql.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

class const _StubGQLClient(final QueryResult<Object?> _result) implements GQLClient {
  @override
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async =>
      QueryResult.loading(options: options, data: _result.data);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _CapturingGQLClient() implements GQLClient {
  final List<MutationOptions<dynamic>> mutations = [];
  final List<QueryOptions<dynamic>> queries = [];

  @override
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async {
    mutations.add(options);

    return QueryResult.loading(options: options, data: _mutationData);
  }

  @override
  Future<QueryResult<T>> query<T>(QueryOptions<T> options) async {
    queries.add(options);

    return QueryResult.loading(options: options, data: _queryData);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const Map<String, dynamic> _wish = {
  'id': 'g1',
  'title': 'Livro',
  'status': 'idea',
  'authorId': 'user-1',
  '__typename': 'giftIdeas',
};

const Map<String, dynamic> _mutationData = {
  'insertGiftIdeasOne': _wish,
  'updateGiftIdeasByPk': _wish,
  'deleteGiftIdeas': {'affected_rows': 1, '__typename': 'giftIdeas_mutation_response'},
  '__typename': 'Mutation',
};

const Map<String, dynamic> _queryData = {'giftIdeas': <Object?>[], '__typename': 'Query'};

QueryResult<T> _result<T>(MutationOptions<T> options, Map<String, dynamic> data) =>
    QueryResult.loading(options: options, data: data);

void main() {
  test('adding a wish that stores no row fails', () {
    final options = OptionsMutationAddGiftWish(
      variables: VariablesMutationAddGiftWish(id: 'g1', title: 'Livro'),
    );
    final dataSource = GiftsDataSource(
      client: _StubGQLClient(
        _result(options, {'insertGiftIdeasOne': null, '__typename': 'Mutation'}),
      ),
    );

    expect(dataSource.addGiftWish(id: 'g1', title: 'Livro'), throwsA(isA<NoDataException>()));
  });

  test('updating a wish that matches no row fails', () {
    final options = OptionsMutationUpdateGiftWish(
      variables: VariablesMutationUpdateGiftWish(id: 'g1', title: 'Livro'),
    );
    final dataSource = GiftsDataSource(
      client: _StubGQLClient(
        _result(options, {'updateGiftIdeasByPk': null, '__typename': 'Mutation'}),
      ),
    );

    expect(dataSource.updateGiftWish(id: 'g1', title: 'Livro'), throwsA(isA<NoDataException>()));
  });

  test('deleting a wish that is already gone fails', () {
    final options = OptionsMutationDeleteGiftWish(
      variables: VariablesMutationDeleteGiftWish(id: 'g1'),
    );
    final dataSource = GiftsDataSource(
      client: _StubGQLClient(
        _result(options, {
          'deleteGiftIdeas': {'affected_rows': 0, '__typename': 'giftIdeas_mutation_response'},
          '__typename': 'Mutation',
        }),
      ),
    );

    expect(dataSource.deleteGiftWish('g1'), throwsA(isA<NoDataException>()));
  });

  test('a mutation that touches one row returns the stored wish', () async {
    final client = _CapturingGQLClient();
    final dataSource = GiftsDataSource(client: client);

    final saved = await dataSource.updateGiftWish(id: 'g1', title: 'Livro');

    expect(saved.id, 'g1');
    expect(saved.authorId, 'user-1');
  });

  test('clearing a note and a link is one request with explicit nulls', () async {
    final client = _CapturingGQLClient();
    final dataSource = GiftsDataSource(client: client);

    await dataSource.updateGiftWish(id: 'g1', title: 'Livro');

    final operation = client.mutations.single;
    expect(printNode(operation.document), contains('mutation UpdateGiftWish'));
    expect(operation.variables, {'id': 'g1', 'title': 'Livro', 'note': null, 'link': null});
  });

  test('a wish stores where to buy it', () async {
    final client = _CapturingGQLClient();
    final dataSource = GiftsDataSource(client: client);

    await dataSource.addGiftWish(id: 'g1', title: 'Livro', link: 'https://example.com/livro');

    final operation = client.mutations.single;
    expect(operation.variables, {
      'id': 'g1',
      'title': 'Livro',
      'link': 'https://example.com/livro',
    });
  });

  test('a new wish is inserted as a wish, not a date idea', () async {
    final client = _CapturingGQLClient();
    final dataSource = GiftsDataSource(client: client);

    await dataSource.addGiftWish(id: 'g1', title: 'Livro');

    final operation = client.mutations.single;
    expect(printNode(operation.document), contains('kind: wish'));
  });

  test('the gift page reads only wishes', () async {
    final client = _CapturingGQLClient();
    final dataSource = GiftsDataSource(client: client);

    await dataSource.getGiftIdeas();

    final operation = client.queries.single;
    expect(printNode(operation.document), contains('_eq: wish'));
  });
}
