import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/profile_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network/network.dart';

class const _StubGQLClient(final Map<String, dynamic>? _data) implements GQLClient {
  @override
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async =>
      QueryResult.loading(options: options, data: _data);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('a name saved for the person counts one updated row', () async {
    final dataSource = ProfileDataSource(
      client: const _StubGQLClient({
        'updateProfilesByPk': {
          'id': 'p1',
          'displayName': 'Marina',
          'avatarKind': 'initials',
          '__typename': 'profiles',
        },
        '__typename': 'mutation_root',
      }),
    );

    expect(await dataSource.updateDisplayName(profileId: 'p1', displayName: 'Marina'), 1);
  });

  test('a row the person may not change counts none', () async {
    final dataSource = ProfileDataSource(
      client: const _StubGQLClient({'updateProfilesByPk': null, '__typename': 'mutation_root'}),
    );

    expect(await dataSource.updateDisplayName(profileId: 'other', displayName: 'Marina'), 0);
  });

  test('a saved theme counts one updated settings row', () async {
    final dataSource = ProfileDataSource(
      client: const _StubGQLClient({
        'updateUserSettingsByPk': {
          'userId': 'p1',
          'theme': 'azul',
          'relationshipStatus': 'together',
          'shareReadReceipts': true,
          'goals': <String>[],
          'locale': 'pt-BR',
          '__typename': 'userSettings',
        },
        '__typename': 'mutation_root',
      }),
    );

    expect(await dataSource.updateTheme(profileId: 'p1', theme: EnumAppTheme_enum.azul), 1);
  });
}
