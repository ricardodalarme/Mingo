import 'package:app/features/profile/data/data_sources/remote/queries/generated/MySettings.graphql.dart';
import 'package:app/features/profile/data/mappers/account_settings_mapper.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/models/relationship_goal.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps settings to the account model', () {
    final settings = QueryMySettingsmySettings.fromJson({
      'profileId': 'p1',
      'theme': 'azul',
      'timeZone': 'America/Sao_Paulo',
      'partnerName': 'Rui',
      'togetherSince': '2024-05-01',
      'relationshipStatus': 'together',
      'onboardedAt': null,
      'shareReadReceipts': true,
      'phase': 'married',
      'goals': ['keep_romance'],
      'locale': 'pt-BR',
      '__typename': 'ProfileSettings',
    });

    expect(
      settings.toModel(),
      AccountSettings(
        theme: .blue,
        profileId: 'p1',
        timeZone: 'America/Sao_Paulo',
        partnerName: 'Rui',
        togetherSince: DateTime(2024, 5, 1),
        shareReadReceipts: true,
        phase: RelationshipPhase.married,
        goals: const [RelationshipGoal.keepRomance],
        locale: 'pt-BR',
      ),
    );
  });
}
