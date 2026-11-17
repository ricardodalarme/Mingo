import 'package:app/features/spice/data/data_sources/remote/fragments/generated/SpiceChallengeFragment.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_challenge_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FragmentSpiceChallengeFragment node({
    List<String> acceptedBy = const [],
    List<String> doneBy = const [],
    int swaps = 0,
  }) => FragmentSpiceChallengeFragment(
    id: 'c1',
    contentSlug: 's',
    acceptedBy: acceptedBy,
    doneBy: doneBy,
    swaps: swaps,
  );

  test('a fresh challenge is accepted by nobody and has every swap left', () {
    final challenge = node().toModel(text: 'Sem telas', userId: 'me');

    expect(challenge.text, 'Sem telas');
    expect(challenge.acceptedByMe, isFalse);
    expect(challenge.acceptedByPartner, isFalse);
    expect(challenge.doneByMe, isFalse);
    expect(challenge.swapsLeft, spiceMaxSwaps);
  });

  test('who accepted decides which side accepted', () {
    final mine = node(acceptedBy: ['me']).toModel(text: 't', userId: 'me');
    final partners = node(acceptedBy: ['you']).toModel(text: 't', userId: 'me');

    expect(mine.acceptedByMe, isTrue);
    expect(mine.acceptedByPartner, isFalse);
    expect(partners.acceptedByMe, isFalse);
    expect(partners.acceptedByPartner, isTrue);
  });

  test('done by the person and the swaps used are read', () {
    final challenge = node(doneBy: ['me'], swaps: 2).toModel(text: 't', userId: 'me');

    expect(challenge.doneByMe, isTrue);
    expect(challenge.swapsLeft, spiceMaxSwaps - 2);
  });
}
