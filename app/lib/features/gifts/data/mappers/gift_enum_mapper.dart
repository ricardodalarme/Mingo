import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/models/gift_budget.dart';
import 'package:app/features/gifts/data/models/gift_idea_status.dart';

extension EnumGiftBudgetMapper on EnumGiftBudget_enum {
  GiftBudget? toModel() => switch (this) {
    EnumGiftBudget_enum.free => GiftBudget.free,
    EnumGiftBudget_enum.low => GiftBudget.low,
    EnumGiftBudget_enum.medium => GiftBudget.medium,
    EnumGiftBudget_enum.high => GiftBudget.high,
    EnumGiftBudget_enum.$unknown => null,
  };
}

extension GiftBudgetMapper on GiftBudget {
  EnumGiftBudget_enum toRemote() => switch (this) {
    GiftBudget.free => EnumGiftBudget_enum.free,
    GiftBudget.low => EnumGiftBudget_enum.low,
    GiftBudget.medium => EnumGiftBudget_enum.medium,
    GiftBudget.high => EnumGiftBudget_enum.high,
  };
}

extension EnumGiftIdeaStatusMapper on EnumGiftIdeaStatus_enum {
  GiftIdeaStatus toModel() => switch (this) {
    EnumGiftIdeaStatus_enum.idea => GiftIdeaStatus.idea,
    EnumGiftIdeaStatus_enum.planned => GiftIdeaStatus.planned,
    EnumGiftIdeaStatus_enum.given => GiftIdeaStatus.given,
    EnumGiftIdeaStatus_enum.$unknown => GiftIdeaStatus.idea,
  };
}

extension GiftIdeaStatusMapper on GiftIdeaStatus {
  EnumGiftIdeaStatus_enum toRemote() => switch (this) {
    GiftIdeaStatus.idea => EnumGiftIdeaStatus_enum.idea,
    GiftIdeaStatus.planned => EnumGiftIdeaStatus_enum.planned,
    GiftIdeaStatus.given => EnumGiftIdeaStatus_enum.given,
  };
}
