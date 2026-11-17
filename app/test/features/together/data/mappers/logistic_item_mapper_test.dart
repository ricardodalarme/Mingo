import 'package:app/features/together/data/data_sources/remote/fragments/generated/LogisticItemFragment.graphql.dart';
import 'package:app/features/together/data/mappers/logistic_item_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FragmentLogisticItemFragment node({
    String? assigneeId,
    String? coupleId,
    DateTime? doneAt,
    DateTime? confirmedAt,
  }) => FragmentLogisticItemFragment(
    id: 'i1',
    title: 'Comprar pão',
    assigneeId: assigneeId,
    authorId: 'me',
    coupleId: coupleId,
    doneAt: doneAt,
    confirmedAt: confirmedAt,
  );

  test('a private item is not shared, confirmed or done', () {
    final item = node().toModel();

    expect(item.id, 'i1');
    expect(item.title, 'Comprar pão');
    expect(item.authorId, 'me');
    expect(item.isShared, isFalse);
    expect(item.isConfirmed, isFalse);
    expect(item.isDone, isFalse);
  });

  test('an item with a couple is shared', () {
    expect(node(coupleId: 'c').toModel().isShared, isTrue);
  });

  test('a confirmation and a done time each set their flag', () {
    final item = node(doneAt: DateTime(2026), confirmedAt: DateTime(2026)).toModel();

    expect(item.isDone, isTrue);
    expect(item.isConfirmed, isTrue);
  });

  test('an unset assignee means both people', () {
    expect(node().toModel().assigneeId, isNull);
    expect(node(assigneeId: 'you').toModel().assigneeId, 'you');
  });
}
