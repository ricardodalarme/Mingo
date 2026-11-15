import 'package:app/features/cycle/data/data_sources/remote/cycle_data_source.dart';
import 'package:app/features/cycle/data/data_sources/remote/mutations/generated/MarkSensitiveDay.graphql.dart';
import 'package:app/features/cycle/data/data_sources/remote/mutations/generated/UnmarkSensitiveDay.graphql.dart';
import 'package:app/features/cycle/data/data_sources/remote/queries/generated/SensitiveDays.graphql.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockGQLClient() extends Mock implements GQLClient;

void main() {
  late GQLClient client;
  late CycleDataSource dataSource;

  final today = DateTime(2026, 11, 15);

  setUpAll(() {
    registerFallbackValue(OptionsQuerySensitiveDays());
    registerFallbackValue(
      OptionsMutationMarkSensitiveDay(variables: VariablesMutationMarkSensitiveDay(day: today)),
    );
    registerFallbackValue(
      OptionsMutationUnmarkSensitiveDay(variables: VariablesMutationUnmarkSensitiveDay(day: today)),
    );
  });

  setUp(() {
    client = _MockGQLClient();
    dataSource = CycleDataSource(client: client);
  });

  void answerQuery(Map<String, dynamic> data) {
    when(() => client.query<QuerySensitiveDays>(any())).thenAnswer(
      (invocation) async => QueryResult<QuerySensitiveDays>(
        options: invocation.positionalArguments.first as QueryOptions<QuerySensitiveDays>,
        source: QueryResultSource.network,
        data: {...data, '__typename': 'Query'},
      ),
    );
  }

  test("reads the server's local day and the marked days", () async {
    answerQuery({
      'today': {'localDate': '2026-11-15', '__typename': 'Today'},
      'cycleDaysCollection': {
        'edges': [
          {
            'node': {'id': 'c1', 'day': '2026-11-15', '__typename': 'CycleDays'},
            '__typename': 'CycleDaysEdge',
          },
          {
            'node': {'id': 'c2', 'day': '2026-11-02', '__typename': 'CycleDays'},
            '__typename': 'CycleDaysEdge',
          },
        ],
        '__typename': 'CycleDaysConnection',
      },
    });

    final record = await dataSource.getSensitiveDays();

    expect(record.today, today);
    expect(record.days, [today, DateTime(2026, 11, 2)]);
  });

  test('a response without the server day is no data', () async {
    answerQuery({
      'today': null,
      'cycleDaysCollection': {
        'edges': <Map<String, dynamic>>[],
        '__typename': 'CycleDaysConnection',
      },
    });

    await expectLater(dataSource.getSensitiveDays(), throwsA(isA<NoDataException>()));
  });

  test('marking a day sends that day to the collection', () async {
    when(() => client.mutate<MutationMarkSensitiveDay>(any())).thenAnswer(
      (invocation) async => QueryResult<MutationMarkSensitiveDay>(
        options: invocation.positionalArguments.first as MutationOptions<MutationMarkSensitiveDay>,
        source: QueryResultSource.network,
        data: {
          'insertIntoCycleDaysCollection': {
            'records': [
              {'id': 'c1', 'day': '2026-11-15', '__typename': 'CycleDays'},
            ],
            '__typename': 'CycleDaysInsertResponse',
          },
          '__typename': 'Mutation',
        },
      ),
    );

    await dataSource.markDay(today);

    final options =
        verify(() => client.mutate<MutationMarkSensitiveDay>(captureAny())).captured.single
            as MutationOptions<MutationMarkSensitiveDay>;
    expect(options.variables['day'], '2026-11-15');
  });

  test('unmarking a day deletes that day from the collection', () async {
    when(() => client.mutate<MutationUnmarkSensitiveDay>(any())).thenAnswer(
      (invocation) async => QueryResult<MutationUnmarkSensitiveDay>(
        options:
            invocation.positionalArguments.first as MutationOptions<MutationUnmarkSensitiveDay>,
        source: QueryResultSource.network,
        data: {
          'deleteFromCycleDaysCollection': {
            'affectedCount': 1,
            '__typename': 'CycleDaysDeleteResponse',
          },
          '__typename': 'Mutation',
        },
      ),
    );

    await dataSource.unmarkDay(today);

    final options =
        verify(() => client.mutate<MutationUnmarkSensitiveDay>(captureAny())).captured.single
            as MutationOptions<MutationUnmarkSensitiveDay>;
    expect(options.variables['day'], '2026-11-15');
  });
}
