import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/chat/data/models/learned_item.dart';

extension EnumLearnedItemTargetMapper on EnumLearnedItemTarget_enum {
  LearnedTarget toModel() => switch (this) {
    EnumLearnedItemTarget_enum.partner_fact => LearnedTarget.partnerFact,
    EnumLearnedItemTarget_enum.date => LearnedTarget.date,
    EnumLearnedItemTarget_enum.memory => LearnedTarget.memory,
    EnumLearnedItemTarget_enum.commitment => LearnedTarget.commitment,
    EnumLearnedItemTarget_enum.$unknown => throw const FormatException('Unknown learning target'),
  };
}

extension LearnedTargetMapper on LearnedTarget {
  EnumLearnedItemTarget_enum toRemote() => switch (this) {
    LearnedTarget.partnerFact => EnumLearnedItemTarget_enum.partner_fact,
    LearnedTarget.date => EnumLearnedItemTarget_enum.date,
    LearnedTarget.memory => EnumLearnedItemTarget_enum.memory,
    LearnedTarget.commitment => EnumLearnedItemTarget_enum.commitment,
  };
}

extension EnumLearnedItemStatusMapper on EnumLearnedItemStatus_enum {
  LearnedStatus toModel() => switch (this) {
    EnumLearnedItemStatus_enum.pending => LearnedStatus.pending,
    EnumLearnedItemStatus_enum.confirmed => LearnedStatus.confirmed,
    EnumLearnedItemStatus_enum.rejected => LearnedStatus.rejected,
    EnumLearnedItemStatus_enum.$unknown => throw const FormatException('Unknown learning status'),
  };
}

extension LearnedStatusMapper on LearnedStatus {
  EnumLearnedItemStatus_enum toRemote() => switch (this) {
    LearnedStatus.pending => EnumLearnedItemStatus_enum.pending,
    LearnedStatus.confirmed => EnumLearnedItemStatus_enum.confirmed,
    LearnedStatus.rejected => EnumLearnedItemStatus_enum.rejected,
  };
}
