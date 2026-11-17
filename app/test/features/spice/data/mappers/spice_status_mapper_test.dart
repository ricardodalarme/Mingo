import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_status_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the state and the levels become a status', () {
    final status = (state: EnumSpiceStage_enum.$on, myLevel: 3, coupleLevel: 1).toModel();

    expect(status.stage, SpiceStage.on);
    expect(status.myLevel, SpiceLevel.hot);
    expect(status.coupleLevel, SpiceLevel.soft);
  });

  test('a couple with no shared level has none', () {
    final status = (
      state: EnumSpiceStage_enum.waiting_partner,
      myLevel: 2,
      coupleLevel: null,
    ).toModel();

    expect(status.stage, SpiceStage.waitingPartner);
    expect(status.myLevel, SpiceLevel.warm);
    expect(status.coupleLevel, isNull);
  });
}
