import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/models/gift_idea_status.dart';

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
