import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/fragments/generated/GiftWishFragment.graphql.dart';
import 'package:app/features/gifts/data/mappers/gift_mapper.dart';
import 'package:app/features/gifts/data/models/gift_budget.dart';
import 'package:app/features/gifts/data/models/gift_idea_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps a wish with the authorship and visibility the server stored', () {
    final gift = FragmentGiftWishFragment(
      id: 'g1',
      title: 'Livro',
      note: 'Capa dura',
      budget: EnumGiftBudget_enum.low,
      status: EnumGiftIdeaStatus_enum.planned,
      authorId: 'user-1',
      coupleId: 'couple-1',
    ).toModel(currentUserId: 'user-1');

    expect(gift.id, 'g1');
    expect(gift.note, 'Capa dura');
    expect(gift.budget, GiftBudget.low);
    expect(gift.status, GiftIdeaStatus.planned);
    expect(gift.isMine, isTrue);
    expect(gift.isShared, isTrue);
  });

  test('a wish without a couple is private and a partner wish is not mine', () {
    final gift = FragmentGiftWishFragment(
      id: 'g1',
      title: 'Livro',
      budget: EnumGiftBudget_enum.$unknown,
      status: EnumGiftIdeaStatus_enum.idea,
      authorId: 'user-2',
      coupleId: null,
    ).toModel(currentUserId: 'user-1');

    expect(gift.isMine, isFalse);
    expect(gift.isShared, isFalse);
    expect(gift.budget, isNull);
  });
}
