import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_polarity.dart';
import 'package:app/features/slips/data/models/slip_work_area.dart';

extension EnumSlipCategoryMapper on EnumSlipCategory {
  SlipCategory? toModel() => switch (this) {
    EnumSlipCategory.said => SlipCategory.said,
    EnumSlipCategory.did => SlipCategory.did,
    EnumSlipCategory.noticed => SlipCategory.noticed,
    EnumSlipCategory.helped => SlipCategory.helped,
    EnumSlipCategory.$unknown => null,
  };
}

extension SlipCategoryMapper on SlipCategory {
  String toRpc() => toRemote().toJson();

  EnumSlipCategory toRemote() => switch (this) {
    SlipCategory.said => EnumSlipCategory.said,
    SlipCategory.did => EnumSlipCategory.did,
    SlipCategory.noticed => EnumSlipCategory.noticed,
    SlipCategory.helped => EnumSlipCategory.helped,
  };
}

extension EnumWorkAreaMapper on EnumWorkArea {
  SlipWorkArea? toModel() => switch (this) {
    EnumWorkArea.planning => SlipWorkArea.planning,
    EnumWorkArea.dates => SlipWorkArea.dates,
    EnumWorkArea.kitchen => SlipWorkArea.kitchen,
    EnumWorkArea.cleaning => SlipWorkArea.cleaning,
    EnumWorkArea.kids => SlipWorkArea.kids,
    EnumWorkArea.emotional => SlipWorkArea.emotional,
    EnumWorkArea.finances => SlipWorkArea.finances,
    EnumWorkArea.other => SlipWorkArea.other,
    EnumWorkArea.$unknown => null,
  };
}

extension SlipWorkAreaMapper on SlipWorkArea {
  String toRpc() => toRemote().toJson();

  EnumWorkArea toRemote() => switch (this) {
    SlipWorkArea.planning => EnumWorkArea.planning,
    SlipWorkArea.dates => EnumWorkArea.dates,
    SlipWorkArea.kitchen => EnumWorkArea.kitchen,
    SlipWorkArea.cleaning => EnumWorkArea.cleaning,
    SlipWorkArea.kids => EnumWorkArea.kids,
    SlipWorkArea.emotional => EnumWorkArea.emotional,
    SlipWorkArea.finances => EnumWorkArea.finances,
    SlipWorkArea.other => EnumWorkArea.other,
  };
}

extension EnumSlipPolarityMapper on EnumSlipPolarity {
  SlipPolarity? toModel() => switch (this) {
    EnumSlipPolarity.liked => SlipPolarity.liked,
    EnumSlipPolarity.bothered => SlipPolarity.bothered,
    EnumSlipPolarity.$unknown => null,
  };
}

extension SlipPolarityMapper on SlipPolarity {
  String toRpc() => toRemote().toJson();

  EnumSlipPolarity toRemote() => switch (this) {
    SlipPolarity.liked => EnumSlipPolarity.liked,
    SlipPolarity.bothered => EnumSlipPolarity.bothered,
  };
}

extension EnumSlipKindMapper on EnumSlipKind {
  SlipKind? toModel() => switch (this) {
    EnumSlipKind.quick => SlipKind.quick,
    EnumSlipKind.specific => SlipKind.specific,
    EnumSlipKind.if_then => SlipKind.ifThen,
    EnumSlipKind.invisible => SlipKind.invisible,
    EnumSlipKind.$unknown => null,
  };
}

extension SlipKindMapper on SlipKind {
  String toRpc() => toRemote().toJson();

  EnumSlipKind toRemote() => switch (this) {
    SlipKind.quick => EnumSlipKind.quick,
    SlipKind.specific => EnumSlipKind.specific,
    SlipKind.ifThen => EnumSlipKind.if_then,
    SlipKind.invisible => EnumSlipKind.invisible,
  };
}
