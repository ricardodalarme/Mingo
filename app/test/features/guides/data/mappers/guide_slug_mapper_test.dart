import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/guides/data/mappers/guide_slug_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('guides with their own kind keep it', () {
    expect('transition'.toConversationGuide(), EnumConversationGuide_enum.transition);
    expect('money'.toConversationGuide(), EnumConversationGuide_enum.money);
    expect('apology'.toConversationGuide(), EnumConversationGuide_enum.apology);
    expect('difficult'.toConversationGuide(), EnumConversationGuide_enum.difficult);
  });

  test('any other guide is a free prep', () {
    expect('family'.toConversationGuide(), EnumConversationGuide_enum.free);
    expect('chores'.toConversationGuide(), EnumConversationGuide_enum.free);
  });
}
