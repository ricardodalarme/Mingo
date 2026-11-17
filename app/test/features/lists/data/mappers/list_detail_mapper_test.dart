import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListFragment.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListItemFragment.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/lists_data_source.dart';
import 'package:app/features/lists/data/mappers/list_detail_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FragmentListItemFragment item(String id) => FragmentListItemFragment(
    id: id,
    listId: 'l1',
    title: 'Item $id',
    status: EnumListItemStatus_enum.dream,
    position: 0,
  );

  ListDetailRecord record({String authorId = 'me', List<String> items = const []}) => (
    list: FragmentListFragment(
      id: 'l1',
      title: 'Viagens',
      kind: EnumListKind_enum.travel,
      authorId: authorId,
      coupleId: 'couple-1',
    ),
    items: [for (final id in items) item(id)],
  );

  test('the list and its items are mapped, in order', () {
    final detail = record(items: ['a', 'b']).toModel(currentUserId: 'me', currentCoupleId: 'c');

    expect(detail.list.id, 'l1');
    expect(detail.list.title, 'Viagens');
    expect(detail.items.map((item) => item.id), ['a', 'b']);
  });

  test("the list is the person's when they wrote it", () {
    expect(record().toModel(currentUserId: 'me', currentCoupleId: null).list.isMine, isTrue);
    expect(
      record(authorId: 'you').toModel(currentUserId: 'me', currentCoupleId: null).list.isMine,
      isFalse,
    );
  });

  test('the couple the person is in travels with the detail', () {
    expect(record().toModel(currentUserId: 'me', currentCoupleId: 'c').currentCoupleId, 'c');
    expect(record().toModel(currentUserId: 'me', currentCoupleId: null).currentCoupleId, isNull);
  });

  test('a list with no items has none', () {
    expect(record().toModel(currentUserId: 'me', currentCoupleId: null).items, isEmpty);
  });
}
