import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_polarity.dart';
import 'package:app/features/slips/data/models/slip_work_area.dart';

extension EnumSlipCategoryMapper on EnumSlipCategory_enum {
  SlipCategory? toModel() => switch (this) {
    EnumSlipCategory_enum.said => SlipCategory.said,
    EnumSlipCategory_enum.did => SlipCategory.did,
    EnumSlipCategory_enum.noticed => SlipCategory.noticed,
    EnumSlipCategory_enum.helped => SlipCategory.helped,
    EnumSlipCategory_enum.$unknown => null,
  };
}

extension SlipCategoryMapper on SlipCategory {
  EnumSlipCategory_enum toRemote() => switch (this) {
    SlipCategory.said => EnumSlipCategory_enum.said,
    SlipCategory.did => EnumSlipCategory_enum.did,
    SlipCategory.noticed => EnumSlipCategory_enum.noticed,
    SlipCategory.helped => EnumSlipCategory_enum.helped,
  };
}

extension EnumWorkAreaMapper on EnumWorkArea_enum {
  SlipWorkArea? toModel() => switch (this) {
    EnumWorkArea_enum.planning => SlipWorkArea.planning,
    EnumWorkArea_enum.dates => SlipWorkArea.dates,
    EnumWorkArea_enum.kitchen => SlipWorkArea.kitchen,
    EnumWorkArea_enum.cleaning => SlipWorkArea.cleaning,
    EnumWorkArea_enum.kids => SlipWorkArea.kids,
    EnumWorkArea_enum.emotional => SlipWorkArea.emotional,
    EnumWorkArea_enum.finances => SlipWorkArea.finances,
    EnumWorkArea_enum.other => SlipWorkArea.other,
    EnumWorkArea_enum.$unknown => null,
  };
}

extension SlipWorkAreaMapper on SlipWorkArea {
  EnumWorkArea_enum toRemote() => switch (this) {
    SlipWorkArea.planning => EnumWorkArea_enum.planning,
    SlipWorkArea.dates => EnumWorkArea_enum.dates,
    SlipWorkArea.kitchen => EnumWorkArea_enum.kitchen,
    SlipWorkArea.cleaning => EnumWorkArea_enum.cleaning,
    SlipWorkArea.kids => EnumWorkArea_enum.kids,
    SlipWorkArea.emotional => EnumWorkArea_enum.emotional,
    SlipWorkArea.finances => EnumWorkArea_enum.finances,
    SlipWorkArea.other => EnumWorkArea_enum.other,
  };
}

extension EnumSlipPolarityMapper on EnumSlipPolarity_enum {
  SlipPolarity? toModel() => switch (this) {
    EnumSlipPolarity_enum.liked => SlipPolarity.liked,
    EnumSlipPolarity_enum.bothered => SlipPolarity.bothered,
    EnumSlipPolarity_enum.$unknown => null,
  };
}

extension SlipPolarityMapper on SlipPolarity {
  EnumSlipPolarity_enum toRemote() => switch (this) {
    SlipPolarity.liked => EnumSlipPolarity_enum.liked,
    SlipPolarity.bothered => EnumSlipPolarity_enum.bothered,
  };
}

extension EnumSlipKindMapper on EnumSlipKind_enum {
  SlipKind? toModel() => switch (this) {
    EnumSlipKind_enum.quick => SlipKind.quick,
    EnumSlipKind_enum.specific => SlipKind.specific,
    EnumSlipKind_enum.if_then => SlipKind.ifThen,
    EnumSlipKind_enum.invisible => SlipKind.invisible,
    EnumSlipKind_enum.$unknown => null,
  };
}

extension SlipKindMapper on SlipKind {
  EnumSlipKind_enum toRemote() => switch (this) {
    SlipKind.quick => EnumSlipKind_enum.quick,
    SlipKind.specific => EnumSlipKind_enum.specific,
    SlipKind.ifThen => EnumSlipKind_enum.if_then,
    SlipKind.invisible => EnumSlipKind_enum.invisible,
  };
}
