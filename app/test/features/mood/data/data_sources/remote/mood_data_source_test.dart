import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/mood/data/data_sources/remote/mood_data_source.dart';
import 'package:app/features/mood/data/data_sources/remote/mutations/generated/UpdateMood.graphql.dart';
import 'package:app/features/mood/data/data_sources/remote/queries/generated/MoodMonth.graphql.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockGQLClient() extends Mock implements GQLClient;

void main() {
  late GQLClient client;
  late MoodDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(
      OptionsMutationUpdateMood(
        variables: VariablesMutationUpdateMood.fromJson({
          'id': 'x',
          'changes': {'mood': 'happy', 'share': 'none'},
        }),
      ),
    );
    registerFallbackValue(
      OptionsQueryMoodMonth(
        variables: VariablesQueryMoodMonth(from: DateTime(2026, 11, 1), to: DateTime(2026, 11, 30)),
      ),
    );
  });

  setUp(() {
    client = _MockGQLClient();
    dataSource = MoodDataSource(client: client);
    when(() => client.mutate<MutationUpdateMood>(any())).thenAnswer(
      (invocation) async => QueryResult<MutationUpdateMood>(
        options: invocation.positionalArguments.first as MutationOptions<MutationUpdateMood>,
        source: QueryResultSource.network,
        data: {
          'updateMoodsByPk': {
            'id': 'm1',
            'day': '2026-11-11',
            'mood': 'happy',
            'need': null,
            'share': 'none',
            '__typename': 'Moods',
          },
          '__typename': 'Mutation',
        },
      ),
    );
  });

  MutationOptions<MutationUpdateMood> sent() =>
      verify(() => client.mutate<MutationUpdateMood>(captureAny())).captured.single
          as MutationOptions<MutationUpdateMood>;

  test('clearing the need sends it as null in the update', () async {
    await dataSource.updateMood(
      id: 'm1',
      mood: EnumMood_enum.happy,
      need: null,
      share: EnumMoodShare_enum.none,
    );

    final variables = sent().variables;
    final changes = variables['changes'] as Map<String, dynamic>;
    expect(changes.containsKey('need'), isTrue);
    expect(changes['need'], isNull);
  });

  test('the update sends the need and the mood', () async {
    await dataSource.updateMood(
      id: 'm1',
      mood: EnumMood_enum.happy,
      need: EnumMoodNeed_enum.hug,
      share: EnumMoodShare_enum.mood_need,
    );

    final variables = sent().variables;
    final changes = variables['changes'] as Map<String, dynamic>;
    expect(changes['need'], 'hug');
    expect(changes['share'], 'mood_need');
    expect(variables['id'], 'm1');
  });

  test('the month read sends both days as dates and maps every row', () async {
    when(() => client.query<QueryMoodMonth>(any())).thenAnswer(
      (invocation) async => QueryResult<QueryMoodMonth>(
        options: invocation.positionalArguments.first as QueryOptions<QueryMoodMonth>,
        source: QueryResultSource.network,
        data: {
          'moods': [
            {
              'id': 'm1',
              'day': '2026-11-03',
              'mood': 'tired',
              'need': 'hug',
              'share': 'mood',
              '__typename': 'moods',
            },
            {
              'id': 'm2',
              'day': '2026-11-04',
              'mood': 'happy',
              'need': null,
              'share': 'none',
              '__typename': 'moods',
            },
          ],
          '__typename': 'Query',
        },
      ),
    );

    final rows = await dataSource.getMonthMoods(
      from: DateTime(2026, 11, 1),
      to: DateTime(2026, 11, 30),
    );

    final options =
        verify(() => client.query<QueryMoodMonth>(captureAny())).captured.single
            as QueryOptions<QueryMoodMonth>;
    expect(options.variables['from'], '2026-11-01');
    expect(options.variables['to'], '2026-11-30');
    expect(rows, hasLength(2));
    expect(rows.first.id, 'm1');
    expect(rows.first.mood, EnumMood_enum.tired);
    expect(rows.last.need, isNull);
  });
}
