import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/cards/data/models/held_reason.dart';

extension EnumCardStatusMapper on EnumCardStatus_enum {
  CardStatus? toModel() => switch (this) {
    EnumCardStatus_enum.draft => CardStatus.draft,
    EnumCardStatus_enum.held => CardStatus.held,
    EnumCardStatus_enum.sent => CardStatus.sent,
    EnumCardStatus_enum.$unknown => null,
  };
}

extension EnumHeldReasonMapper on EnumHeldReason_enum {
  /// Null for a reason this version does not know, so the card reads as held by no known rule.
  HeldReason? toModel() => switch (this) {
    EnumHeldReason_enum.absolute => HeldReason.absolute,
    EnumHeldReason_enum.insult => HeldReason.insult,
    EnumHeldReason_enum.blame => HeldReason.blame,
    EnumHeldReason_enum.contempt => HeldReason.contempt,
    EnumHeldReason_enum.$unknown => null,
  };
}
