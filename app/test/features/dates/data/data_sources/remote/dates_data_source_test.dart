import 'package:app/features/dates/data/data_sources/remote/dates_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

class _CapturingGQLClient() implements GQLClient {
  final List<MutationOptions<dynamic>> mutations = [];
  final List<QueryOptions<dynamic>> queries = [];

  @override
  Future<QueryResult<T>> query<T>(QueryOptions<T> options) async {
    queries.add(options);

    return QueryResult.loading(
      options: options,
      data: const {'giftIdeas': <Object?>[], '__typename': 'Query'},
    );
  }

  @override
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async {
    mutations.add(options);

    return QueryResult.loading(
      options: options,
      data: const {
        'insertGiftIdeasOne': {'id': 'g1', '__typename': 'giftIdeas'},
        '__typename': 'Mutation',
      },
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('the dates list reads only my ideas', () async {
    final client = _CapturingGQLClient();
    final dataSource = DatesDataSource(client: client);

    await dataSource.getGiftIdeas();

    final operation = client.queries.single;
    expect(printNode(operation.document), contains('kind: {_eq: idea}'));
    expect(printNode(operation.document), contains('authorId'));
    expect(operation.variables, <String, dynamic>{});
  });

  test('a new date idea is inserted as an idea, not a wish', () async {
    final client = _CapturingGQLClient();
    final dataSource = DatesDataSource(client: client);

    await dataSource.addGiftIdea(id: 'g1', title: 'Livro');

    final operation = client.mutations.single;
    expect(printNode(operation.document), contains('kind: idea'));
  });
}
