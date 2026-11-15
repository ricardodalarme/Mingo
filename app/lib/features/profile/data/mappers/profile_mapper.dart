import 'package:app/features/profile/data/data_sources/remote/fragments/generated/ProfileFragment.graphql.dart';
import 'package:app/features/profile/data/mappers/avatar_kind_mapper.dart';
import 'package:app/features/profile/data/models/profile.dart';

extension ProfileFragmentMapper on FragmentProfileFragment {
  Profile toModel() => Profile(
    id: id,
    avatarKind: avatarKind.toModel(),
    displayName: displayName,
    avatarPath: avatarPath,
    city: city,
    pronouns: pronouns,
  );
}
