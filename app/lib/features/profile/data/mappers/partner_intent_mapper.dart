import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/models/partner_intent.dart';

extension EnumPartnerIntentMapper on EnumPartnerIntent_enum {
  /// Null for an intent this version does not know.
  PartnerIntent? toModel() => switch (this) {
    EnumPartnerIntent_enum.invite => PartnerIntent.invite,
    EnumPartnerIntent_enum.later => PartnerIntent.later,
    EnumPartnerIntent_enum.solo_only => PartnerIntent.soloOnly,
    EnumPartnerIntent_enum.$unknown => null,
  };
}

extension PartnerIntentMapper on PartnerIntent {
  EnumPartnerIntent_enum toRemote() => switch (this) {
    PartnerIntent.invite => EnumPartnerIntent_enum.invite,
    PartnerIntent.later => EnumPartnerIntent_enum.later,
    PartnerIntent.soloOnly => EnumPartnerIntent_enum.solo_only,
  };
}
