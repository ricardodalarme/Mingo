import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';

extension EnumRelationshipPhaseMapper on EnumRelationshipPhase_enum {
  /// Null for a phase this version does not know.
  RelationshipPhase? toModel() => switch (this) {
    EnumRelationshipPhase_enum.beginning => RelationshipPhase.beginning,
    EnumRelationshipPhase_enum.dating => RelationshipPhase.dating,
    EnumRelationshipPhase_enum.living_together => RelationshipPhase.livingTogether,
    EnumRelationshipPhase_enum.engaged => RelationshipPhase.engaged,
    EnumRelationshipPhase_enum.married => RelationshipPhase.married,
    EnumRelationshipPhase_enum.long_distance => RelationshipPhase.longDistance,
    EnumRelationshipPhase_enum.restarting => RelationshipPhase.restarting,
    EnumRelationshipPhase_enum.$unknown => null,
  };
}

extension RelationshipPhaseMapper on RelationshipPhase {
  EnumRelationshipPhase_enum toRemote() => switch (this) {
    RelationshipPhase.beginning => EnumRelationshipPhase_enum.beginning,
    RelationshipPhase.dating => EnumRelationshipPhase_enum.dating,
    RelationshipPhase.livingTogether => EnumRelationshipPhase_enum.living_together,
    RelationshipPhase.engaged => EnumRelationshipPhase_enum.engaged,
    RelationshipPhase.married => EnumRelationshipPhase_enum.married,
    RelationshipPhase.longDistance => EnumRelationshipPhase_enum.long_distance,
    RelationshipPhase.restarting => EnumRelationshipPhase_enum.restarting,
  };
}
