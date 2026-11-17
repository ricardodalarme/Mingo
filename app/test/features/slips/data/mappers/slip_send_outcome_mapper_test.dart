import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/mappers/slip_send_outcome_mapper.dart';
import 'package:app/features/slips/data/models/slip_send_outcome.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a sent card means the partner has the slip', () {
    expect(EnumCardStatus_enum.sent.toSlipSendOutcome(), SlipSendOutcome.sent);
  });

  test('a held card means the wording matched a rule', () {
    expect(EnumCardStatus_enum.held.toSlipSendOutcome(), SlipSendOutcome.held);
  });

  test('anything else, or no card at all, means nothing was sent', () {
    expect(EnumCardStatus_enum.draft.toSlipSendOutcome(), SlipSendOutcome.notSent);
    expect(EnumCardStatus_enum.$unknown.toSlipSendOutcome(), SlipSendOutcome.notSent);
    expect(null.toSlipSendOutcome(), SlipSendOutcome.notSent);
  });
}
