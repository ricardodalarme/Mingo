import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
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

Map<String, dynamic> _slip({String? deletedAt, String polarity = 'liked'}) => {
  'slipsByPk': {
    'id': 's1',
    'body': 'Obrigado pelo café',
    'kind': 'quick',
    'forCard': false,
    'polarity': polarity,
    'createdAt': '2026-11-10T10:00:00Z',
    'deletedAt': deletedAt,
    'inJar': false,
    '__typename': 'Slips',
  },
  '__typename': 'Query',
};

void main() {
  test('reads a slip by its primary key', () async {
    final dataSource = SlipDataSource(client: _StubGQLClient(_slip()));

    final slip = await dataSource.getSlip('s1');

    expect(slip?.id, 's1');
    expect(slip?.body, 'Obrigado pelo café');
    expect(slip?.polarity, EnumSlipPolarity.liked);
  });

  test('reads a bothered slip with its polarity', () async {
    final dataSource = SlipDataSource(client: _StubGQLClient(_slip(polarity: 'bothered')));

    expect((await dataSource.getSlip('s1'))?.polarity, EnumSlipPolarity.bothered);
  });

  test('a deleted slip reads as not found', () async {
    final dataSource = SlipDataSource(
      client: _StubGQLClient(_slip(deletedAt: '2026-11-11T10:00:00Z')),
    );

    expect(await dataSource.getSlip('s1'), isNull);
  });

  test('a slip that is not visible reads as not found', () async {
    final dataSource = SlipDataSource(
      client: const _StubGQLClient({'slipsByPk': null, '__typename': 'Query'}),
    );

    expect(await dataSource.getSlip('s1'), isNull);
  });
}
