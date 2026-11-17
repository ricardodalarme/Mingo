import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/plus/data/data_sources/remote/queries/generated/MyPlus.graphql.dart';
import 'package:app/features/plus/data/mappers/plus_state_mapper.dart';
import 'package:app/features/plus/data/models/plus_plan.dart';
import 'package:app/features/plus/data/models/plus_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('what the server counts becomes the plan state', () {
    final state = QueryMyPlusplusStates(
      hasPlus: true,
      paidByPartner: true,
      gamesLeftThisWeek: 2,
      ritualsLeft: 1,
      listsLeft: 3,
      entitlement: QueryMyPlusplusStatesentitlement(
        plan: EnumEntitlementPlan_enum.plus_annual,
        status: EnumEntitlementStatus_enum.billing_issue,
      ),
    ).toModel();

    expect(state.hasPlus, isTrue);
    expect(state.isPaidByPartner, isTrue);
    expect(state.gamesLeft, 2);
    expect(state.ritualsLeft, 1);
    expect(state.listsLeft, 3);
    expect(state.plan, PlusPlan.annual);
    expect(state.status, PlusStatus.billingIssue);
  });

  test('a person on the free plan has no plan or status, and a missing count reads as none', () {
    final state = QueryMyPlusplusStates().toModel();

    expect(state.hasPlus, isFalse);
    expect(state.isPaidByPartner, isFalse);
    expect(state.gamesLeft, 0);
    expect(state.ritualsLeft, 0);
    expect(state.listsLeft, 0);
    expect(state.plan, isNull);
    expect(state.status, isNull);
  });
}
