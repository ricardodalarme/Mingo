import 'package:app/features/spice/data/data_sources/remote/mutations/generated/SpiceNextCard.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_card_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final node = MutationSpiceNextCardspiceNextCard(id: 'p1', contentSlug: 'c', proposedBy: 'me');

  test('a card the person proposed is theirs', () {
    final card = node.toModel(text: 'Uma noite', userId: 'me');

    expect(card.id, 'p1');
    expect(card.text, 'Uma noite');
    expect(card.isMine, isTrue);
  });

  test('a card the partner proposed is not theirs', () {
    expect(node.toModel(text: 'Uma noite', userId: 'you').isMine, isFalse);
  });
}
