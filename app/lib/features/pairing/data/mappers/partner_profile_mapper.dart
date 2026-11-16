import 'package:app/features/pairing/data/data_sources/remote/queries/generated/MyPartner.graphql.dart';
import 'package:app/features/profile/data/mappers/avatar_kind_mapper.dart';
import 'package:app/features/profile/data/models/profile.dart';

/// The partner row as the profile model the rest of the app reads.
extension PartnerProfileMapper on QueryMyPartnercouplesmembersprofile {
  Profile toModel() => Profile(
    id: id,
    avatarKind: avatarKind.toModel(),
    displayName: displayName,
    city: city,
    pronouns: pronouns,
  );
}
