import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/models/slip_send_outcome.dart';

extension SlipSendOutcomeMapper on EnumCardStatus_enum? {
  /// What the status of the card a slip made says happened: sent, held, or nothing sent.
  SlipSendOutcome toSlipSendOutcome() => switch (this) {
    EnumCardStatus_enum.sent => SlipSendOutcome.sent,
    EnumCardStatus_enum.held => SlipSendOutcome.held,
    _ => SlipSendOutcome.notSent,
  };
}
