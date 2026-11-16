import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/models/relationship_status.dart';

extension EnumRelationshipStatusMapper on EnumRelationshipStatus_enum {
  /// A status this version does not know is treated as together.
  RelationshipStatus toModel() => switch (this) {
    EnumRelationshipStatus_enum.ended => RelationshipStatus.ended,
    EnumRelationshipStatus_enum.bereaved => RelationshipStatus.bereaved,
    _ => RelationshipStatus.together,
  };
}

extension RelationshipStatusMapper on RelationshipStatus {
  EnumRelationshipStatus_enum toRemote() => switch (this) {
    RelationshipStatus.together => EnumRelationshipStatus_enum.together,
    RelationshipStatus.ended => EnumRelationshipStatus_enum.ended,
    RelationshipStatus.bereaved => EnumRelationshipStatus_enum.bereaved,
  };
}
