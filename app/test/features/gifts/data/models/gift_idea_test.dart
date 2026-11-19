import 'package:app/features/gifts/data/models/gift_idea.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a wish is mine only when the person added it', () {
    const gift = GiftIdea(id: 'g1', title: 'Livro');

    expect(gift.isMine, isFalse);
    expect(gift.link, isNull);
  });

  test('a partner wish', () {
    const gift = GiftIdea(id: 'g1', title: 'Livro', isMine: true);

    expect(gift.isMine, isTrue);
  });

  test('details keep identity and authorship', () {
    const gift = GiftIdea(id: 'g1', title: 'Livro', isMine: true);

    final edited = gift.withDetails(
      title: 'Livro de poemas',
      note: 'Capa dura',
      link: 'https://example.com/livro',
    );

    expect(edited.id, gift.id);
    expect(edited.title, 'Livro de poemas');
    expect(edited.note, 'Capa dura');
    expect(edited.link, 'https://example.com/livro');
    expect(edited.isMine, isTrue);
  });
}
