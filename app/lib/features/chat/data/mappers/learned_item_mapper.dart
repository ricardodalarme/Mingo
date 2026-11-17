import 'package:app/features/chat/data/data_sources/remote/queries/generated/LearnedItems.graphql.dart';
import 'package:app/features/chat/data/mappers/learned_item_enum_mapper.dart';
import 'package:app/features/chat/data/models/learned_item.dart';

extension LearnedItemMapper on QueryLearnedItemslearnedItems {
  LearnedItem toModel() => LearnedItem(
    id: id,
    target: target.toModel(),
    text: text,
    excerpt: excerpt,
    status: status.toModel(),
    createdAt: createdAt,
  );
}
