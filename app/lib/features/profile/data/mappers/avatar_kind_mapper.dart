import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/models/avatar_kind.dart';

extension EnumAvatarKindMapper on EnumAvatarKind_enum {
  /// An unknown avatar is shown as initials.
  AvatarKind toModel() => switch (this) {
    EnumAvatarKind_enum.photo => AvatarKind.photo,
    EnumAvatarKind_enum.illustration => AvatarKind.illustration,
    EnumAvatarKind_enum.initials || EnumAvatarKind_enum.$unknown => AvatarKind.initials,
  };
}

extension AvatarKindMapper on AvatarKind {
  EnumAvatarKind_enum toRemote() => switch (this) {
    AvatarKind.photo => EnumAvatarKind_enum.photo,
    AvatarKind.illustration => EnumAvatarKind_enum.illustration,
    AvatarKind.initials => EnumAvatarKind_enum.initials,
  };
}
