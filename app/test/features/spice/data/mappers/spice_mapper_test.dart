import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the stored state becomes a stage, and an unknown one is off', () {
    expect(spiceStageFromRemote('on'), SpiceStage.on);
    expect(spiceStageFromRemote('waiting_partner'), SpiceStage.waitingPartner);
    expect(spiceStageFromRemote('partner_wants'), SpiceStage.partnerWants);
    expect(spiceStageFromRemote('off'), SpiceStage.off);
    expect(spiceStageFromRemote('other'), SpiceStage.off);
  });

  test('a level survives a trip to the stored number and back', () {
    for (final level in SpiceLevel.values) {
      expect(spiceLevelFromRemote(level.toRemote()), level);
    }
    expect(spiceLevelFromRemote(null), SpiceLevel.soft);
  });

  test('an answer survives a trip to the remote enum and back', () {
    for (final answer in SpiceAnswer.values) {
      expect(answer.toRemote().toModel(), answer);
    }
    expect(EnumSpiceAnswer_enum.$unknown.toModel(), SpiceAnswer.maybe);
  });
}
