import 'package:app/features/cards/data/data_sources/remote/queries/generated/MyCards.graphql.dart';
import 'package:app/features/cards/data/mappers/card_summary_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final weekStart = DateTime.utc(2026, 3, 2);
  final sentAt = DateTime.utc(2026, 3, 8);

  QueryMyCardscards row(
    String id, {
    String authorId = 'me',
    DateTime? sent,
    int items = 2,
    QueryMyCardscardsreaction? reaction,
    bool opened = false,
  }) => QueryMyCardscards(
    id: id,
    authorId: authorId,
    sentAt: sent,
    weekStart: weekStart,
    items: [for (var i = 0; i < items; i++) QueryMyCardscardsitems(id: '$id-$i')],
    reaction: reaction,
    open: opened ? QueryMyCardscardsopen(openedAt: sentAt) : null,
  );

  test('a card the person wrote is theirs and counts its items', () {
    final card = row('a', sent: sentAt).toModel(userId: 'me');

    expect(card.id, 'a');
    expect(card.isMine, isTrue);
    expect(card.itemCount, 2);
    expect(row('a', authorId: 'you').toModel(userId: 'me').isMine, isFalse);
  });

  test('a card with no send time falls back to its week', () {
    expect(row('a').toModel(userId: 'me').sentAt, weekStart);
    expect(row('a', sent: sentAt).toModel(userId: 'me').sentAt, sentAt);
  });

  test('a reaction and a reply are told apart, and an empty reply is no reply', () {
    final reacted = row(
      'a',
      reaction: QueryMyCardscardsreaction(reaction: 'heart', reply: 'Obrigada'),
    ).toModel(userId: 'me');
    final empty = row(
      'a',
      reaction: QueryMyCardscardsreaction(reaction: 'heart', reply: ''),
    ).toModel(userId: 'me');

    expect(reacted.reaction, 'heart');
    expect(reacted.hasReply, isTrue);
    expect(empty.hasReply, isFalse);
    expect(row('a').toModel(userId: 'me').reaction, isNull);
  });

  test('a card is opened once the recipient opened it', () {
    expect(row('a', opened: true).toModel(userId: 'me').isOpened, isTrue);
    expect(row('a').toModel(userId: 'me').isOpened, isFalse);
  });

  group('page', () {
    test('holds the first rows and says another page follows when the read had more', () {
      final page = [row('a'), row('b'), row('c')].toPage(offset: 0, pageSize: 2, userId: 'me');

      expect(page.items.map((card) => card.id), ['a', 'b']);
      expect(page.hasNext, isTrue);
      expect(page.offset, 2);
    });

    test('the last page has no next one', () {
      final page = [row('a')].toPage(offset: 20, pageSize: 2, userId: 'me');

      expect(page.hasNext, isFalse);
      expect(page.offset, 21);
    });
  });
}
