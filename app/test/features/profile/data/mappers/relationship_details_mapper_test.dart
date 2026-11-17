import 'package:app/features/profile/data/data_sources/remote/queries/generated/MySettings.graphql.dart';
import 'package:app/features/profile/data/mappers/relationship_details_mapper.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/profile/data/models/relationship_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final settings = QueryMySettingsuserSettingsByPk.fromJson({
    'userId': 'p1',
    'theme': 'azul',
    'partnerName': 'Rui',
    'togetherSince': '2024-05-01',
    'relationshipStatus': 'ended',
    'onboardedAt': null,
    'shareReadReceipts': true,
    'phase': 'married',
    'goals': <Map<String, dynamic>>[],
    'locale': 'pt-BR',
    'profile': {'timeZone': 'America/Sao_Paulo', '__typename': 'profiles'},
    '__typename': 'userSettings',
  });

  test('the phase, the date and the status come from the settings', () {
    final details = settings.toRelationshipDetails();

    expect(details.profileId, 'p1');
    expect(details.phase, RelationshipPhase.married);
    expect(details.togetherSince, DateTime(2024, 5, 1));
    expect(details.relationshipStatus, RelationshipStatus.ended);
  });
}
