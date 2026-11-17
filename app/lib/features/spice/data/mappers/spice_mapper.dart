import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

extension EnumSpiceStageMapper on EnumSpiceStage_enum {
  /// The stage for a stored state; an unknown state reads as off.
  SpiceStage toModel() => switch (this) {
    EnumSpiceStage_enum.$on => SpiceStage.on,
    EnumSpiceStage_enum.waiting_partner => SpiceStage.waitingPartner,
    EnumSpiceStage_enum.partner_wants => SpiceStage.partnerWants,
    EnumSpiceStage_enum.off || EnumSpiceStage_enum.$unknown => SpiceStage.off,
  };
}

extension SpiceLevelValueMapper on int {
  /// The level for a stored number; an unknown number reads as soft.
  SpiceLevel toSpiceLevel() => switch (this) {
    2 => SpiceLevel.warm,
    3 => SpiceLevel.hot,
    _ => SpiceLevel.soft,
  };
}

extension SpiceLevelMapper on SpiceLevel {
  int toRemote() => index + 1;
}

extension SpiceAnswerMapper on SpiceAnswer {
  EnumSpiceAnswer_enum toRemote() => switch (this) {
    SpiceAnswer.want => EnumSpiceAnswer_enum.want,
    SpiceAnswer.maybe => EnumSpiceAnswer_enum.maybe,
    SpiceAnswer.notToday => EnumSpiceAnswer_enum.not_today,
  };
}

extension EnumSpiceAnswerMapper on EnumSpiceAnswer_enum {
  SpiceAnswer toModel() => switch (this) {
    EnumSpiceAnswer_enum.want => SpiceAnswer.want,
    EnumSpiceAnswer_enum.maybe => SpiceAnswer.maybe,
    EnumSpiceAnswer_enum.not_today => SpiceAnswer.notToday,
    EnumSpiceAnswer_enum.$unknown => SpiceAnswer.maybe,
  };
}
