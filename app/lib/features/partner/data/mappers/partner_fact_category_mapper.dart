import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/partner/data/models/partner_fact_category.dart';

extension EnumPartnerFactCategoryMapper on EnumPartnerFactCategory_enum {
  PartnerFactCategory? toModel() => switch (this) {
    EnumPartnerFactCategory_enum.likes => PartnerFactCategory.likes,
    EnumPartnerFactCategory_enum.dislikes => PartnerFactCategory.dislikes,
    EnumPartnerFactCategory_enum.sizes => PartnerFactCategory.sizes,
    EnumPartnerFactCategory_enum.health => PartnerFactCategory.health,
    EnumPartnerFactCategory_enum.comfort => PartnerFactCategory.comfort,
    EnumPartnerFactCategory_enum.people => PartnerFactCategory.people,
    EnumPartnerFactCategory_enum.other => PartnerFactCategory.other,
    EnumPartnerFactCategory_enum.$unknown => null,
  };
}

extension PartnerFactCategoryMapper on PartnerFactCategory {
  EnumPartnerFactCategory_enum toRemote() => switch (this) {
    PartnerFactCategory.likes => EnumPartnerFactCategory_enum.likes,
    PartnerFactCategory.dislikes => EnumPartnerFactCategory_enum.dislikes,
    PartnerFactCategory.sizes => EnumPartnerFactCategory_enum.sizes,
    PartnerFactCategory.health => EnumPartnerFactCategory_enum.health,
    PartnerFactCategory.comfort => EnumPartnerFactCategory_enum.comfort,
    PartnerFactCategory.people => EnumPartnerFactCategory_enum.people,
    PartnerFactCategory.other => EnumPartnerFactCategory_enum.other,
  };
}
