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
    expect(Temperature.good.toRemote(), EnumTemperatureLevel_enum.good);
    expect(Temperature.soSo.toRemote(), EnumTemperatureLevel_enum.so_so);
    expect(Temperature.turbulent.toRemote(), EnumTemperatureLevel_enum.turbulent);
    expect(Temperature.fight.toRemote(), EnumTemperatureLevel_enum.fight);
  });

  test('a temperature survives a trip to the remote enum and back', () {
    for (final value in Temperature.values) {
      expect(value.toRemote().toModel(), value);
    }
    expect(EnumTemperatureLevel_enum.$unknown.toModel(), Temperature.soSo);
  });

  test('maps every repair path and feeling', () {
    expect(RepairPath.pause.toRemote(), EnumRepairPath_enum.pause);
    expect(RepairPath.quick.toRemote(), EnumRepairPath_enum.quick);
    expect(RepairPath.guided.toRemote(), EnumRepairPath_enum.guided);
    expect(RepairFeeling.calmer.toRemote(), EnumRepairFeeling_enum.calmer);
    expect(RepairFeeling.stillTense.toRemote(), EnumRepairFeeling_enum.still_tense);
    expect(RepairFeeling.needMoreTime.toRemote(), EnumRepairFeeling_enum.need_more_time);
  });

  test('maps every signal kind and shows an unknown one as a need', () {
    expect(EnumSignalKind_enum.need.toModel(), SignalKind.need);
    expect(EnumSignalKind_enum.miss_us.toModel(), SignalKind.missUs);
    expect(EnumSignalKind_enum.hug.toModel(), SignalKind.hug);
    expect(EnumSignalKind_enum.distance.toModel(), SignalKind.distance);
    expect(EnumSignalKind_enum.repair.toModel(), SignalKind.repair);
    expect(EnumSignalKind_enum.good_news.toModel(), SignalKind.goodNews);
    expect(EnumSignalKind_enum.$unknown.toModel(), SignalKind.need);
  });

  test('an unknown learning kind is shown as a need', () {
    expect(EnumRepairLearningKind_enum.$unknown.toModel(), RepairLearningKind.need);
  });

  test('a response sent to the server is its stored value', () {
    expect(RepairResponse.here.toRemote(), EnumSignalResponse_enum.here);
    expect(RepairResponse.talk.toRemote(), EnumSignalResponse_enum.talk);
    expect(RepairResponse.moreTime.toRemote(), EnumSignalResponse_enum.more_time);
    expect(RepairResponse.willDo.toRemote(), EnumSignalResponse_enum.will_do);
    expect(RepairResponse.notNow.toRemote(), EnumSignalResponse_enum.not_now);
    expect(RepairResponse.plan.toRemote(), EnumSignalResponse_enum.plan);
    expect(RepairResponse.later.toRemote(), EnumSignalResponse_enum.later);
    expect(RepairResponse.heart.toRemote(), EnumSignalResponse_enum.heart);
  });

  test('every answer the app offers is a response the server stores', () {
    for (final response in RepairResponse.values) {
      final stored = EnumSignalResponse_enum.fromJson(response.toRemote().toJson());

      expect(stored, isNot(EnumSignalResponse_enum.$unknown), reason: response.name);
      expect(stored.toModel(), response);
    }
  });

  test('a response this version does not know is left unnamed', () {
    expect(EnumSignalResponse_enum.$unknown.toModel(), isNull);
  });
}
