import 'package:app/features/cards/presentation/list/cubit/cards_list_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the next offset replaces the previous one', () {
    const state = CardsListState(offset: 20);

    expect(state.copyWith(offset: 40).offset, 40);
  });

  test('changing the loading flag keeps the offset', () {
    const state = CardsListState(offset: 20, hasNext: true);

    final updated = state.copyWith(isLoadingMore: true);

    expect(updated.offset, 20);
    expect(updated.isLoadingMore, isTrue);
  });
}
