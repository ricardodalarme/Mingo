import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/plus/data/models/plus_plan.dart';
import 'package:app/features/plus/data/models/plus_status.dart';

extension EnumEntitlementPlanMapper on EnumEntitlementPlan_enum {
  /// An unknown plan reads as null so the screen falls back to a plain "Plus is active".
  PlusPlan? toModel() => switch (this) {
    EnumEntitlementPlan_enum.plus_monthly => PlusPlan.monthly,
    EnumEntitlementPlan_enum.plus_annual => PlusPlan.annual,
    _ => null,
  };
}

extension EnumEntitlementStatusMapper on EnumEntitlementStatus_enum {
  /// An unknown status reads as null so the screen hides the status row.
  PlusStatus? toModel() => switch (this) {
    EnumEntitlementStatus_enum.trialing => PlusStatus.trialing,
    EnumEntitlementStatus_enum.active => PlusStatus.active,
    EnumEntitlementStatus_enum.grace => PlusStatus.grace,
    EnumEntitlementStatus_enum.billing_issue => PlusStatus.billingIssue,
    EnumEntitlementStatus_enum.expired => PlusStatus.expired,
    EnumEntitlementStatus_enum.refunded => PlusStatus.refunded,
    EnumEntitlementStatus_enum.$unknown => null,
  };
}
