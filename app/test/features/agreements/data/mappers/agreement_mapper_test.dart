import 'package:app/features/agreements/data/data_sources/remote/fragments/generated/AgreementFragment.graphql.dart';
import 'package:app/features/agreements/data/mappers/agreement_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FragmentAgreementFragment node({
    String authorId = 'me',
    String? coupleId,
    DateTime? confirmedAt,
  }) => FragmentAgreementFragment(
    id: 'a1',
    body: 'texto',
    authorId: authorId,
    coupleId: coupleId,
    confirmedAt: confirmedAt,
  );

  test('an agreement the person wrote is theirs', () {
    expect(node().toModel(currentUserId: 'me').isMine, isTrue);
    expect(node(authorId: 'you').toModel(currentUserId: 'me').isMine, isFalse);
  });

  test('an agreement is shared when it belongs to a couple', () {
    expect(node().toModel(currentUserId: 'me').isShared, isFalse);
    expect(node(coupleId: 'c').toModel(currentUserId: 'me').isShared, isTrue);
  });

  test('an agreement is confirmed once it has a confirmation time', () {
    expect(node().toModel(currentUserId: 'me').isConfirmed, isFalse);
    expect(node(confirmedAt: DateTime(2026)).toModel(currentUserId: 'me').isConfirmed, isTrue);
  });

  test('nobody owns an agreement when the person is unknown', () {
    final agreement = node(authorId: 'you').toModel(currentUserId: null);

    expect(agreement.isMine, isFalse);
    expect(agreement.body, 'texto');
    expect(agreement.id, 'a1');
  });
}
