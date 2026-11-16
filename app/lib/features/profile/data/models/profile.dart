import 'package:app/features/profile/data/models/avatar_kind.dart';
import 'package:equatable/equatable.dart';

final class const Profile({
  required final String id,
  required final AvatarKind avatarKind,
  final String? displayName,
  final String? avatarFileId,
  final String? city,
  final String? pronouns,
}) with Equatable {
  const new fake()
    : this(id: 'fake', avatarKind: AvatarKind.initials, displayName: 'Nome Sobrenome');

  @override
  List<Object?> get props => [id, avatarKind, displayName, avatarFileId, city, pronouns];
}
