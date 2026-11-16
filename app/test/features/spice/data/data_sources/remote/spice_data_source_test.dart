import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SetSpiceEnabled.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/MySpiceSetting.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceCards.graphql.dart';
import 'package:app/features/spice/data/data_sources/remote/spice_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockGQLClient() extends Mock implements GQLClient;

void main() {
  late GQLClient client;
  late SpiceDataSource dataSource;

  setUpAll(() {
    registerFallbackValue(
      OptionsQueryMySpiceSetting(variables: VariablesQueryMySpiceSetting(userId: 'u1')),
    );
    registerFallbackValue(
      OptionsQuerySpiceCards(variables: VariablesQuerySpiceCards(locale: 'pt-BR')),
    );
    registerFallbackValue(
      OptionsMutationSetSpiceEnabled(
        variables: VariablesMutationSetSpiceEnabled(userId: 'u1', enabled: true),
      ),
    );
  });

  setUp(() {
    client = _MockGQLClient();
    dataSource = SpiceDataSource(client: client);
  });

  QueryResult<QueryMySpiceSetting> settingsResponse(Map<String, dynamic>? row) {
    return QueryResult<QueryMySpiceSetting>(
      options: OptionsQueryMySpiceSetting(variables: VariablesQueryMySpiceSetting(userId: 'u1')),
      source: QueryResultSource.network,
      data: {'userSettingsByPk': row, '__typename': 'Query'},
    );
  }

  QueryResult<QuerySpiceCards> cardsResponse(List<Map<String, dynamic>> cards) {
    return QueryResult<QuerySpiceCards>(
      options: OptionsQuerySpiceCards(variables: VariablesQuerySpiceCards(locale: 'pt-BR')),
      source: QueryResultSource.network,
      data: {'contentItems': cards, '__typename': 'Query'},
    );
  }

  QueryResult<MutationSetSpiceEnabled> mutationResponse(int affectedRows) {
    return QueryResult<MutationSetSpiceEnabled>(
      options: OptionsMutationSetSpiceEnabled(
        variables: VariablesMutationSetSpiceEnabled(userId: 'u1', enabled: true),
      ),
      source: QueryResultSource.network,
      data: {
        'updateUserSettings': {
          '__typename': 'userSettings_mutation_response',
          'affected_rows': affectedRows,
        },
        '__typename': 'Mutation',
      },
    );
  }

  test('a missing settings row reads as off', () async {
    when(() => client.query<QueryMySpiceSetting>(any()))
        .thenAnswer((_) async => settingsResponse(null));

    expect(await dataSource.getEnabled('u1'), isFalse);
  });

  test('the settings row carries the saved switch', () async {
    when(() => client.query<QueryMySpiceSetting>(any())).thenAnswer(
      (_) async =>
          settingsResponse({'__typename': 'userSettings', 'userId': 'u1', 'spiceEnabled': true}),
    );

    expect(await dataSource.getEnabled('u1'), isTrue);
  });

  test('cards keep the server order', () async {
    when(() => client.query<QuerySpiceCards>(any())).thenAnswer(
      (_) async => cardsResponse([
        {'__typename': 'contentItems', 'slug': 'a', 'title': 'Primeira'},
        {'__typename': 'contentItems', 'slug': 'b', 'title': 'Segunda'},
      ]),
    );

    expect(await dataSource.getCards('pt-BR'), ['Primeira', 'Segunda']);
  });

  test('the mutation reports the row count it touched', () async {
    when(() => client.mutate<MutationSetSpiceEnabled>(any()))
        .thenAnswer((_) async => mutationResponse(1));

    expect(await dataSource.setEnabled(userId: 'u1', enabled: true), 1);
  });

  test('the mutation reports zero when no row matched', () async {
    when(() => client.mutate<MutationSetSpiceEnabled>(any()))
        .thenAnswer((_) async => mutationResponse(0));

    expect(await dataSource.setEnabled(userId: 'u1', enabled: true), 0);
  });
}
