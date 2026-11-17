import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/fragments/generated/ProfileFragment.graphql.dart';
import 'package:app/features/profile/data/data_sources/remote/queries/generated/MySettings.graphql.dart';
import 'package:app/features/profile/data/mappers/profile_details_mapper.dart';
import 'package:app/features/profile/data/models/pronoun.dart';
import 'package:design_system/design_system.dart';
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

  FragmentProfileFragment profile({String? displayName, EnumPronoun_enum? pronouns}) =>
      FragmentProfileFragment(
        id: 'p1',
        displayName: displayName,
        avatarKind: EnumAvatarKind_enum.initials,
        pronouns: pronouns,
      );

  test('the name comes from the profile, the zone and theme from the settings', () {
    final details = profile(displayName: 'Marina').toDetails(settings: settings);

    expect(details.profileId, 'p1');
    expect(details.displayName, 'Marina');
    expect(details.timeZone, 'America/Sao_Paulo');
    expect(details.theme, AppThemeVariant.blue);
  });

  test('a profile with no name has an empty one', () {
    expect(profile().toDetails(settings: settings).displayName, '');
  });

  test('pronouns are mapped when set and absent otherwise', () {
    expect(profile().toDetails(settings: settings).pronouns, isNull);
    expect(
      profile(pronouns: EnumPronoun_enum.she).toDetails(settings: settings).pronouns,
      Pronoun.she,
    );
  });
}
