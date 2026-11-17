import 'package:app/features/slips/data/data_sources/remote/slip_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

class const _StubGQLClient(final Map<String, dynamic> _data) implements GQLClient {
  @override
  Future<QueryResult<T>> query<T>(QueryOptions<T> options) async =>
      QueryResult.loading(options: options, data: _data);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Map<String, dynamic> _slip({String? archivedAt, List<Map<String, dynamic>> cardItems = const []}) =>
    {
      'slipsByPk': {
        'id': 's1',
        'body': 'Obrigado pelo café',
        'kind': 'quick',
        'forCard': false,
        'createdAt': '2026-11-10T10:00:00Z',
        'archivedAt': archivedAt,
        'inJar': false,
        '__typename': 'slips',
      },
      'cardItems': cardItems,
      '__typename': 'query_root',
    };

void main() {
  test('reads a slip by its primary key', () async {
    final dataSource = SlipDataSource(client: _StubGQLClient(_slip()));

    final row = await dataSource.getSlip('s1');

    expect(row?.slip.id, 's1');
    expect(row?.slip.body, 'Obrigado pelo café');
    expect(row?.wasInCard, isFalse);
  });

  test('a slip that is already on a card says so', () async {
    final dataSource = SlipDataSource(
      client: _StubGQLClient(
        _slip(
          cardItems: [
            {'id': 'i1', '__typename': 'cardItems'},
          ],
        ),
      ),
    );

    expect((await dataSource.getSlip('s1'))?.wasInCard, isTrue);
  });

  test('a slip that is not visible reads as not found', () async {
    final dataSource = SlipDataSource(
      client: const _StubGQLClient({
        'slipsByPk': null,
        'cardItems': <Map<String, dynamic>>[],
        '__typename': 'query_root',
      }),
    );

    expect(await dataSource.getSlip('s1'), isNull);
  });

  test('reads whether new slips go on the card by default', () async {
    final dataSource = SlipDataSource(
      client: const _StubGQLClient({
        'userSettings': [
          {'slipsDefaultForCard': true, '__typename': 'user_settings'},
        ],
        '__typename': 'query_root',
      }),
    );

    expect(await dataSource.getForCardDefault(), isTrue);
  });

  test('a person with no saved choice keeps new slips private', () async {
    final dataSource = SlipDataSource(
      client: const _StubGQLClient({
        'userSettings': <Map<String, dynamic>>[],
        '__typename': 'query_root',
      }),
    );

    expect(await dataSource.getForCardDefault(), isFalse);
  });
}
