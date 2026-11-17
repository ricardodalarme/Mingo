import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/mappers/relationship_goal_mapper.dart';
import 'package:app/features/profile/data/models/relationship_goal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a goal survives a trip to the remote enum and back', () {
    for (final goal in RelationshipGoal.values) {
      expect(goal.toRemote().toModel(), goal);
    }
  });

  test('each goal has its own remote value', () {
    final remote = {for (final goal in RelationshipGoal.values) goal.toRemote()};

    expect(remote, hasLength(RelationshipGoal.values.length));
  });

  test('multi-word goals map to their snake case values', () {
    expect(RelationshipGoal.fightLess.toRemote(), EnumRelationshipGoal_enum.fight_less);
    expect(RelationshipGoal.organizeRoutine.toRemote(), EnumRelationshipGoal_enum.organize_routine);
  });

  test('a goal this version does not know is left out', () {
    expect(EnumRelationshipGoal_enum.$unknown.toModel(), isNull);
  });
}
