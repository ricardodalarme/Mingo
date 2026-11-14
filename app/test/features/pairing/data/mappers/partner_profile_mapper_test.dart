import 'package:flutter_bloc_starter/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:flutter_bloc_starter/features/pairing/data/data_sources/remote/queries/generated/MyPartner.graphql.dart';
import 'package:flutter_bloc_starter/features/pairing/data/mappers/partner_profile_mapper.dart';
import 'package:flutter_bloc_starter/features/profile/data/models/avatar_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps the partner row to a profile', () {
    final profile = QueryMyPartnermyPartner(
      id: 'p1',
      displayName: 'Bia',
      avatarPath: 'p1/avatar.jpg',
      avatarKind: EnumAvatarKind.photo,
      city: 'Curitiba',
      pronouns: 'ela/dela',
    ).toModel();

    expect(profile.id, 'p1');
    expect(profile.displayName, 'Bia');
    expect(profile.avatarPath, 'p1/avatar.jpg');
    expect(profile.avatarKind, AvatarKind.photo);
    expect(profile.city, 'Curitiba');
    expect(profile.pronouns, 'ela/dela');
  });

  test('a partner with only an id keeps the other fields empty and shows initials', () {
    final profile = QueryMyPartnermyPartner(
      id: 'p1',
      avatarKind: EnumAvatarKind.$unknown,
    ).toModel();

    expect(profile.displayName, isNull);
    expect(profile.avatarPath, isNull);
    expect(profile.city, isNull);
    expect(profile.pronouns, isNull);
    expect(profile.avatarKind, AvatarKind.initials);
  });
}
