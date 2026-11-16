import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/plus/data/mappers/plus_enum_mapper.dart';
import 'package:app/features/plus/data/models/plus_plan.dart';
import 'package:app/features/plus/data/models/plus_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every plan maps to its own domain value', () {
    expect(EnumEntitlementPlan_enum.plus_monthly.toModel(), PlusPlan.monthly);
    expect(EnumEntitlementPlan_enum.plus_annual.toModel(), PlusPlan.annual);
  });

  test('every status maps to its own domain value', () {
    expect(EnumEntitlementStatus_enum.trialing.toModel(), PlusStatus.trialing);
    expect(EnumEntitlementStatus_enum.active.toModel(), PlusStatus.active);
    expect(EnumEntitlementStatus_enum.grace.toModel(), PlusStatus.grace);
    expect(EnumEntitlementStatus_enum.billing_issue.toModel(), PlusStatus.billingIssue);
    expect(EnumEntitlementStatus_enum.expired.toModel(), PlusStatus.expired);
    expect(EnumEntitlementStatus_enum.refunded.toModel(), PlusStatus.refunded);
  });

  test('an unknown plan or status reads as null', () {
    expect(EnumEntitlementPlan_enum.$unknown.toModel(), isNull);
    expect(EnumEntitlementStatus_enum.$unknown.toModel(), isNull);
  });
}
