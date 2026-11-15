import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/models/guided_session.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:app/features/repair/data/models/repair_path.dart';

extension TemperatureMapper on Temperature {
  EnumTemperatureLevel toRemote() => switch (this) {
    Temperature.good => EnumTemperatureLevel.good,
    Temperature.soSo => EnumTemperatureLevel.so_so,
    Temperature.turbulent => EnumTemperatureLevel.turbulent,
    Temperature.fight => EnumTemperatureLevel.fight,
  };
}

extension RepairPathMapper on RepairPath {
  EnumRepairPath toRemote() => switch (this) {
    RepairPath.pause => EnumRepairPath.pause,
    RepairPath.quick => EnumRepairPath.quick,
    RepairPath.guided => EnumRepairPath.guided,
  };
}

extension RepairFeelingMapper on RepairFeeling {
  EnumRepairFeeling toRemote() => switch (this) {
    RepairFeeling.calmer => EnumRepairFeeling.calmer,
    RepairFeeling.stillTense => EnumRepairFeeling.still_tense,
    RepairFeeling.needMoreTime => EnumRepairFeeling.need_more_time,
  };
}

extension EnumRepairLearningKindMapper on EnumRepairLearningKind {
  RepairLearningKind toModel() => switch (this) {
    EnumRepairLearningKind.trigger => RepairLearningKind.trigger,
    EnumRepairLearningKind.need => RepairLearningKind.need,
    EnumRepairLearningKind.good_fix => RepairLearningKind.goodFix,
    EnumRepairLearningKind.$unknown => RepairLearningKind.need,
  };
}

extension RepairLearningKindMapper on RepairLearningKind {
  EnumRepairLearningKind toRemote() => switch (this) {
    RepairLearningKind.trigger => EnumRepairLearningKind.trigger,
    RepairLearningKind.need => EnumRepairLearningKind.need,
    RepairLearningKind.goodFix => EnumRepairLearningKind.good_fix,
  };
}

extension EnumSignalKindMapper on EnumSignalKind {
  /// An unknown kind is shown as a plain need.
  SignalKind toModel() => switch (this) {
    EnumSignalKind.need => SignalKind.need,
    EnumSignalKind.miss_us => SignalKind.missUs,
    EnumSignalKind.hug => SignalKind.hug,
    EnumSignalKind.distance => SignalKind.distance,
    EnumSignalKind.repair => SignalKind.repair,
    EnumSignalKind.heavy_day => SignalKind.heavyDay,
    EnumSignalKind.good_news => SignalKind.goodNews,
    EnumSignalKind.$unknown => SignalKind.need,
  };
}

extension RepairResponseMapper on RepairResponse {
  /// The text the respond function takes.
  String toRpc() => switch (this) {
    RepairResponse.here => EnumSignalResponse.here.toJson(),
    RepairResponse.talk => EnumSignalResponse.talk.toJson(),
    RepairResponse.moreTime => EnumSignalResponse.more_time.toJson(),
    RepairResponse.willDo => EnumSignalResponse.will_do.toJson(),
    RepairResponse.notNow => EnumSignalResponse.not_now.toJson(),
    RepairResponse.plan => EnumSignalResponse.plan.toJson(),
    RepairResponse.later => EnumSignalResponse.later.toJson(),
    RepairResponse.heart => EnumSignalResponse.heart.toJson(),
  };
}

extension EnumSignalResponseMapper on EnumSignalResponse {
  /// A response this version does not know is left unnamed.
  RepairResponse? toModel() => switch (this) {
    EnumSignalResponse.here => RepairResponse.here,
    EnumSignalResponse.talk => RepairResponse.talk,
    EnumSignalResponse.more_time => RepairResponse.moreTime,
    EnumSignalResponse.will_do => RepairResponse.willDo,
    EnumSignalResponse.not_now => RepairResponse.notNow,
    EnumSignalResponse.plan => RepairResponse.plan,
    EnumSignalResponse.later => RepairResponse.later,
    EnumSignalResponse.heart => RepairResponse.heart,
    EnumSignalResponse.$unknown => null,
  };
}
