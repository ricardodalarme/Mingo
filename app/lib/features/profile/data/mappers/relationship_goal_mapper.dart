import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/models/relationship_goal.dart';

extension RelationshipGoalMapper on RelationshipGoal {
  EnumRelationshipGoal_enum toRemote() => switch (this) {
    RelationshipGoal.reconnect => EnumRelationshipGoal_enum.reconnect,
    RelationshipGoal.fightLess => EnumRelationshipGoal_enum.fight_less,
    RelationshipGoal.keepRomance => EnumRelationshipGoal_enum.keep_romance,
    RelationshipGoal.rememberDates => EnumRelationshipGoal_enum.remember_dates,
    RelationshipGoal.organizeRoutine => EnumRelationshipGoal_enum.organize_routine,
    RelationshipGoal.justRecord => EnumRelationshipGoal_enum.just_record,
  };
}

extension EnumRelationshipGoalMapper on EnumRelationshipGoal_enum {
  /// Null for a goal this version does not know, so it is left out of the list.
  RelationshipGoal? toModel() => switch (this) {
    EnumRelationshipGoal_enum.reconnect => RelationshipGoal.reconnect,
    EnumRelationshipGoal_enum.fight_less => RelationshipGoal.fightLess,
    EnumRelationshipGoal_enum.keep_romance => RelationshipGoal.keepRomance,
    EnumRelationshipGoal_enum.remember_dates => RelationshipGoal.rememberDates,
    EnumRelationshipGoal_enum.organize_routine => RelationshipGoal.organizeRoutine,
    EnumRelationshipGoal_enum.just_record => RelationshipGoal.justRecord,
    EnumRelationshipGoal_enum.$unknown => null,
  };
}
