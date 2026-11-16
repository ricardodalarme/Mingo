import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';

extension GuideSlugMapper on String {
  /// The stored kind of conversation prep for a guide slug; guides without their own kind are free preps.
  EnumConversationGuide_enum toConversationGuide() => switch (this) {
    'transition' => EnumConversationGuide_enum.transition,
    'money' => EnumConversationGuide_enum.money,
    'apology' => EnumConversationGuide_enum.apology,
    'difficult' => EnumConversationGuide_enum.difficult,
    _ => EnumConversationGuide_enum.free,
  };
}
