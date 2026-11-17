import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/queries/generated/CardDetail.graphql.dart';
import 'package:app/features/cards/data/mappers/card_detail_mapper.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  QueryCardDetailcardsByPk node({
    String authorId = 'me',
    QueryCardDetailcardsByPkrecipient? recipient,
    QueryCardDetailcardsByPkreaction? reaction,
  }) => QueryCardDetailcardsByPk(
    id: 'c1',
    status: EnumCardStatus_enum.sent,
    weekStart: DateTime.utc(2026, 3, 2),
    items: const [],
    authorId: authorId,
    author: QueryCardDetailcardsByPkauthor(displayName: 'Ana'),
    recipient: recipient,
    reaction: reaction,
  );

  test('the card keeps its own model and the names of both people', () {
    final detail = node(recipient: QueryCardDetailcardsByPkrecipient(displayName: 'Rui'))
        .toDetail(userId: 'me');

    expect(detail.card.id, 'c1');
    expect(detail.card.status, CardStatus.sent);
    expect(detail.authorName, 'Ana');
    expect(detail.recipientName, 'Rui');
  });

  test('the card is theirs when the person wrote it', () {
    expect(node().toDetail(userId: 'me').isMine, isTrue);
    expect(node(authorId: 'you').toDetail(userId: 'me').isMine, isFalse);
  });

  test('a card with no recipient or answer has none', () {
    final detail = node().toDetail(userId: 'me');

    expect(detail.recipientName, isNull);
    expect(detail.reaction, isNull);
    expect(detail.reply, isNull);
  });

  test('the answer keeps its reaction and its reply', () {
    final detail = node(
      reaction: QueryCardDetailcardsByPkreaction(reaction: 'heart', reply: 'Obrigada'),
    ).toDetail(userId: 'me');

    expect(detail.reaction, 'heart');
    expect(detail.reply, 'Obrigada');
  });
}
