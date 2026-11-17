import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/spice/data/models/spice_models.dart';

SpiceStage spiceStageFromRemote(String value) => switch (value) {
  'on' => SpiceStage.on,
  'waiting_partner' => SpiceStage.waitingPartner,
  'partner_wants' => SpiceStage.partnerWants,
  _ => SpiceStage.off,
};

SpiceLevel spiceLevelFromRemote(int? value) => switch (value) {
  2 => SpiceLevel.warm,
  3 => SpiceLevel.hot,
  _ => SpiceLevel.soft,
};

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
