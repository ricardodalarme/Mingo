import 'package:app/features/cards/data/data_sources/remote/cards_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

class const _StubGQLClient(final Map<String, dynamic> _data) implements GQLClient {
  @override
  Future<QueryResult<T>> query<T>(QueryOptions<T> options) async =>
      QueryResult.loading(options: options, data: _data);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('reads a card by its primary key', () async {
    final dataSource = CardsDataSource(
      client: const _StubGQLClient({
        'cardsByPk': {
          'id': 'c1',
          'status': 'sent',
          'weekStart': '2026-11-09',
          'authorId': 'u1',
          'author': {'displayName': 'Ana', '__typename': 'profiles'},
          'items': <Map<String, dynamic>>[],
          '__typename': 'cards',
        },
        '__typename': 'query_root',
      }),
    );

    final card = await dataSource.getCard('c1');

    expect(card?.id, 'c1');
    expect(card?.authorId, 'u1');
  });

  test('a card that is gone or not visible reads as not found', () async {
    final dataSource = CardsDataSource(
      client: const _StubGQLClient({'cardsByPk': null, '__typename': 'query_root'}),
    );

    expect(await dataSource.getCard('c1'), isNull);
  });
}
