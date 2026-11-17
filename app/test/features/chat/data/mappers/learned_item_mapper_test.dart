import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/chat/data/data_sources/remote/queries/generated/LearnedItems.graphql.dart';
import 'package:app/features/chat/data/mappers/learned_item_mapper.dart';
import 'package:app/features/chat/data/models/learned_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a learning keeps its text, excerpt, target and status', () {
    final created = DateTime.utc(2026, 3, 1);

    final item = QueryLearnedItemslearnedItems(
      id: 'l1',
      target: EnumLearnedItemTarget_enum.date,
      text: 'Ela gosta de flores',
      excerpt: 'dica da conversa',
      status: EnumLearnedItemStatus_enum.confirmed,
      createdAt: created,
    ).toModel();

    expect(item.id, 'l1');
    expect(item.target, LearnedTarget.date);
    expect(item.text, 'Ela gosta de flores');
    expect(item.excerpt, 'dica da conversa');
    expect(item.status, LearnedStatus.confirmed);
    expect(item.createdAt, created);
  });

  test('a learning with no excerpt has none', () {
    final item = QueryLearnedItemslearnedItems(
      id: 'l1',
      target: EnumLearnedItemTarget_enum.memory,
      text: 'texto',
      status: EnumLearnedItemStatus_enum.pending,
      createdAt: DateTime.utc(2026),
    ).toModel();

    expect(item.excerpt, isNull);
  });
}
