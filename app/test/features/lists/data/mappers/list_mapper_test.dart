import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListFragment.graphql.dart';
import 'package:app/features/lists/data/data_sources/remote/fragments/generated/ListItemFragment.graphql.dart';
import 'package:app/features/lists/data/mappers/list_mapper.dart';
import 'package:app/features/lists/data/models/list_item_status.dart';
import 'package:app/features/lists/data/models/list_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps a list with the authorship and visibility the server stored', () {
    final list = FragmentListFragment(
      id: 'l1',
      title: 'Viagens',
      kind: EnumListKind_enum.travel,
      authorId: 'user-1',
      coupleId: 'couple-1',
    ).toModel(currentUserId: 'user-1');

    expect(list.id, 'l1');
    expect(list.title, 'Viagens');
    expect(list.kind, ListKind.travel);
    expect(list.isMine, isTrue);
    expect(list.isShared, isTrue);
  });

  test('a list without a couple is private and a partner list is not mine', () {
    final list = FragmentListFragment(
      id: 'l1',
      title: 'Viagens',
      kind: EnumListKind_enum.travel,
      authorId: 'user-2',
      coupleId: null,
    ).toModel(currentUserId: 'user-1');

    expect(list.isMine, isFalse);
    expect(list.isShared, isFalse);
  });

  test('maps a list item', () {
    final item = FragmentListItemFragment(
      id: 'i1',
      listId: 'l1',
      title: 'Lisboa',
      status: EnumListItemStatus_enum.planned,
      position: 2,
    ).toModel();

    expect(item.id, 'i1');
    expect(item.listId, 'l1');
    expect(item.status, ListItemStatus.planned);
    expect(item.position, 2);
  });
}
