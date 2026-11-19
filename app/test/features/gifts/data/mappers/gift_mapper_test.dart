import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/data_sources/remote/fragments/generated/GiftWishFragment.graphql.dart';
import 'package:app/features/gifts/data/mappers/gift_mapper.dart';
import 'package:app/features/gifts/data/models/gift_idea_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps a wish with the authorship the server stored', () {
    final gift = FragmentGiftWishFragment(
      id: 'g1',
      title: 'Livro',
      note: 'Capa dura',
      link: 'https://example.com/livro',
      status: EnumGiftIdeaStatus_enum.planned,
      authorId: 'user-1',
    ).toModel(currentUserId: 'user-1');

    expect(gift.id, 'g1');
    expect(gift.note, 'Capa dura');
    expect(gift.link, 'https://example.com/livro');
    expect(gift.status, GiftIdeaStatus.planned);
    expect(gift.isMine, isTrue);
  });

  test('a partner wish is not mine and has no link when the server stores none', () {
    final gift = FragmentGiftWishFragment(
      id: 'g1',
      title: 'Livro',
      status: EnumGiftIdeaStatus_enum.idea,
      authorId: 'user-2',
    ).toModel(currentUserId: 'user-1');

    expect(gift.isMine, isFalse);
    expect(gift.link, isNull);
  });
}
