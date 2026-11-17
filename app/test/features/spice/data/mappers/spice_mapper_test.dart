import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the stored state becomes a stage, and an unknown one is off', () {
    expect('on'.toSpiceStage(), SpiceStage.on);
    expect('waiting_partner'.toSpiceStage(), SpiceStage.waitingPartner);
    expect('partner_wants'.toSpiceStage(), SpiceStage.partnerWants);
    expect('off'.toSpiceStage(), SpiceStage.off);
    expect('other'.toSpiceStage(), SpiceStage.off);
  });

  test('a level survives a trip to the stored number and back', () {
    for (final level in SpiceLevel.values) {
      expect(level.toRemote().toSpiceLevel(), level);
    }
    expect(99.toSpiceLevel(), SpiceLevel.soft);
  });

  test('an answer survives a trip to the remote enum and back', () {
    for (final answer in SpiceAnswer.values) {
      expect(answer.toRemote().toModel(), answer);
    }
    expect(EnumSpiceAnswer_enum.$unknown.toModel(), SpiceAnswer.maybe);
  });
}
