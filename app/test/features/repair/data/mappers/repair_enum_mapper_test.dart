import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/mappers/repair_enum_mapper.dart';
import 'package:app/features/repair/data/models/guided_session.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a learning kind survives a trip to the remote enum and back', () {
    for (final value in RepairLearningKind.values) {
      expect(value.toRemote().toModel(), value);
    }
  });
  test('maps every temperature to its stored level', () {
    expect(Temperature.good.toRemote(), EnumTemperatureLevel.good);
    expect(Temperature.soSo.toRemote(), EnumTemperatureLevel.so_so);
    expect(Temperature.turbulent.toRemote(), EnumTemperatureLevel.turbulent);
    expect(Temperature.fight.toRemote(), EnumTemperatureLevel.fight);
  });

  test('maps every repair path and feeling', () {
    expect(RepairPath.pause.toRemote(), EnumRepairPath.pause);
    expect(RepairPath.quick.toRemote(), EnumRepairPath.quick);
    expect(RepairPath.guided.toRemote(), EnumRepairPath.guided);
    expect(RepairFeeling.calmer.toRemote(), EnumRepairFeeling.calmer);
    expect(RepairFeeling.stillTense.toRemote(), EnumRepairFeeling.still_tense);
    expect(RepairFeeling.needMoreTime.toRemote(), EnumRepairFeeling.need_more_time);
  });

  test('maps every signal kind and shows an unknown one as a need', () {
    expect(EnumSignalKind.need.toModel(), SignalKind.need);
    expect(EnumSignalKind.miss_us.toModel(), SignalKind.missUs);
    expect(EnumSignalKind.hug.toModel(), SignalKind.hug);
    expect(EnumSignalKind.distance.toModel(), SignalKind.distance);
    expect(EnumSignalKind.repair.toModel(), SignalKind.repair);
    expect(EnumSignalKind.heavy_day.toModel(), SignalKind.heavyDay);
    expect(EnumSignalKind.good_news.toModel(), SignalKind.goodNews);
    expect(EnumSignalKind.$unknown.toModel(), SignalKind.need);
  });

  test('an unknown learning kind is shown as a need', () {
    expect(EnumRepairLearningKind.$unknown.toModel(), RepairLearningKind.need);
  });

  test('a response sent to the function is its stored text', () {
    expect(RepairResponse.here.toRpc(), 'here');
    expect(RepairResponse.talk.toRpc(), 'talk');
    expect(RepairResponse.moreTime.toRpc(), 'more_time');
    expect(RepairResponse.willDo.toRpc(), 'will_do');
    expect(RepairResponse.notNow.toRpc(), 'not_now');
    expect(RepairResponse.plan.toRpc(), 'plan');
    expect(RepairResponse.later.toRpc(), 'later');
    expect(RepairResponse.heart.toRpc(), 'heart');
  });

  test('every answer the app offers is a response the server stores', () {
    for (final response in RepairResponse.values) {
      final stored = EnumSignalResponse.fromJson(response.toRpc());

      expect(stored, isNot(EnumSignalResponse.$unknown), reason: response.name);
      expect(stored.toModel(), response);
    }
  });

  test('a response this version does not know is left unnamed', () {
    expect(EnumSignalResponse.$unknown.toModel(), isNull);
  });
}
