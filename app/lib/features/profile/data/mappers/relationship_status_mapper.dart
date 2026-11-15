import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/models/relationship_status.dart';

extension EnumRelationshipStatusMapper on EnumRelationshipStatus {
  /// A status this version does not know is treated as together.
  RelationshipStatus toModel() => switch (this) {
    EnumRelationshipStatus.ended => RelationshipStatus.ended,
    EnumRelationshipStatus.bereaved => RelationshipStatus.bereaved,
    _ => RelationshipStatus.together,
  };
}

extension RelationshipStatusMapper on RelationshipStatus {
  EnumRelationshipStatus toRemote() => switch (this) {
    RelationshipStatus.together => EnumRelationshipStatus.together,
    RelationshipStatus.ended => EnumRelationshipStatus.ended,
    RelationshipStatus.bereaved => EnumRelationshipStatus.bereaved,
  };
}
