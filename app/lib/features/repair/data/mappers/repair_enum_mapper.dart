import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/models/guided_session.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:app/features/repair/data/models/repair_path.dart';

extension TemperatureMapper on Temperature {
  EnumTemperatureLevel_enum toRemote() => switch (this) {
    Temperature.good => EnumTemperatureLevel_enum.good,
    Temperature.soSo => EnumTemperatureLevel_enum.so_so,
    Temperature.turbulent => EnumTemperatureLevel_enum.turbulent,
    Temperature.fight => EnumTemperatureLevel_enum.fight,
  };
}

extension EnumTemperatureLevelMapper on EnumTemperatureLevel_enum {
  Temperature toModel() => switch (this) {
    EnumTemperatureLevel_enum.good => Temperature.good,
    EnumTemperatureLevel_enum.so_so => Temperature.soSo,
    EnumTemperatureLevel_enum.turbulent => Temperature.turbulent,
    EnumTemperatureLevel_enum.fight => Temperature.fight,
    EnumTemperatureLevel_enum.$unknown => Temperature.soSo,
  };
}

extension RepairPathMapper on RepairPath {
  EnumRepairPath_enum toRemote() => switch (this) {
    RepairPath.pause => EnumRepairPath_enum.pause,
    RepairPath.quick => EnumRepairPath_enum.quick,
    RepairPath.guided => EnumRepairPath_enum.guided,
  };
}

extension RepairFeelingMapper on RepairFeeling {
  EnumRepairFeeling_enum toRemote() => switch (this) {
    RepairFeeling.calmer => EnumRepairFeeling_enum.calmer,
    RepairFeeling.stillTense => EnumRepairFeeling_enum.still_tense,
    RepairFeeling.needMoreTime => EnumRepairFeeling_enum.need_more_time,
  };
}

extension EnumRepairLearningKindMapper on EnumRepairLearningKind_enum {
  RepairLearningKind toModel() => switch (this) {
    EnumRepairLearningKind_enum.trigger => RepairLearningKind.trigger,
    EnumRepairLearningKind_enum.need => RepairLearningKind.need,
    EnumRepairLearningKind_enum.good_fix => RepairLearningKind.goodFix,
    EnumRepairLearningKind_enum.$unknown => RepairLearningKind.need,
  };
}

extension RepairLearningKindMapper on RepairLearningKind {
  EnumRepairLearningKind_enum toRemote() => switch (this) {
    RepairLearningKind.trigger => EnumRepairLearningKind_enum.trigger,
    RepairLearningKind.need => EnumRepairLearningKind_enum.need,
    RepairLearningKind.goodFix => EnumRepairLearningKind_enum.good_fix,
  };
}

extension EnumSignalKindMapper on EnumSignalKind_enum {
  /// A kind this version does not know is shown as a plain need.
  SignalKind toModel() => switch (this) {
    EnumSignalKind_enum.miss_us => SignalKind.missUs,
    EnumSignalKind_enum.hug => SignalKind.hug,
    EnumSignalKind_enum.distance => SignalKind.distance,
    EnumSignalKind_enum.repair => SignalKind.repair,
    EnumSignalKind_enum.good_news => SignalKind.goodNews,
    _ => SignalKind.need,
  };
}

extension RepairResponseMapper on RepairResponse {
  EnumSignalResponse_enum toRemote() => switch (this) {
    RepairResponse.here => EnumSignalResponse_enum.here,
    RepairResponse.talk => EnumSignalResponse_enum.talk,
    RepairResponse.moreTime => EnumSignalResponse_enum.more_time,
    RepairResponse.willDo => EnumSignalResponse_enum.will_do,
    RepairResponse.notNow => EnumSignalResponse_enum.not_now,
    RepairResponse.plan => EnumSignalResponse_enum.plan,
    RepairResponse.later => EnumSignalResponse_enum.later,
    RepairResponse.heart => EnumSignalResponse_enum.heart,
  };
}

extension EnumSignalResponseMapper on EnumSignalResponse_enum {
  /// A response this version does not know is left unnamed.
  RepairResponse? toModel() => switch (this) {
    EnumSignalResponse_enum.here => RepairResponse.here,
    EnumSignalResponse_enum.talk => RepairResponse.talk,
    EnumSignalResponse_enum.more_time => RepairResponse.moreTime,
    EnumSignalResponse_enum.will_do => RepairResponse.willDo,
    EnumSignalResponse_enum.not_now => RepairResponse.notNow,
    EnumSignalResponse_enum.plan => RepairResponse.plan,
    EnumSignalResponse_enum.later => RepairResponse.later,
    EnumSignalResponse_enum.heart => RepairResponse.heart,
    EnumSignalResponse_enum.$unknown => null,
  };
}
