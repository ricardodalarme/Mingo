import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/pairing/data/data_sources/remote/queries/generated/MyPartner.graphql.dart';
import 'package:app/features/pairing/data/mappers/partner_profile_mapper.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:app/features/profile/data/models/pronoun.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps the partner row to a profile', () {
    final profile = QueryMyPartnercouplesmembersprofile(
      id: 'p1',
      displayName: 'Bia',
      avatarKind: EnumAvatarKind_enum.photo,
      city: 'Curitiba',
      pronouns: EnumPronoun_enum.she,
    ).toModel();

    expect(profile.id, 'p1');
    expect(profile.displayName, 'Bia');
    expect(profile.avatarKind, AvatarKind.photo);
    expect(profile.city, 'Curitiba');
    expect(profile.pronouns, Pronoun.she);
  });

  test('a partner with only an id keeps the other fields empty and shows initials', () {
    final profile = QueryMyPartnercouplesmembersprofile(
      id: 'p1',
      avatarKind: EnumAvatarKind_enum.$unknown,
    ).toModel();

    expect(profile.displayName, isNull);
    expect(profile.avatarFileId, isNull);
    expect(profile.city, isNull);
    expect(profile.pronouns, isNull);
    expect(profile.avatarKind, AvatarKind.initials);
  });
}
