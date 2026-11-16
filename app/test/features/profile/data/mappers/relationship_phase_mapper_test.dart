import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/mappers/relationship_phase_mapper.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a phase survives a trip to the remote enum and back', () {
    for (final value in RelationshipPhase.values) {
      expect(value.toRemote().toModel(), value);
    }
  });

  test('multi-word phases keep their stored spelling', () {
    expect(RelationshipPhase.livingTogether.toRemote(), EnumRelationshipPhase_enum.living_together);
    expect(RelationshipPhase.longDistance.toRemote(), EnumRelationshipPhase_enum.long_distance);
  });

  test('a phase this version does not know is left out', () {
    expect(EnumRelationshipPhase_enum.$unknown.toModel(), isNull);
  });
}
