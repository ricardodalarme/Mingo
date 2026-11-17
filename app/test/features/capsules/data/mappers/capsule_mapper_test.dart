import 'package:app/features/capsules/data/data_sources/remote/queries/generated/Capsules.graphql.dart';
import 'package:app/features/capsules/data/mappers/capsule_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final today = DateTime(2026, 3, 10);

  QueryCapsulescapsules node({DateTime? opensOn, String? coupleId, String authorId = 'me'}) =>
      QueryCapsulescapsules(
        id: 'c1',
        authorId: authorId,
        coupleId: coupleId,
        body: 'Para o futuro',
        opensOn: opensOn ?? DateTime(2026, 3, 10),
      );

  test('a capsule whose day has come shows its text', () {
    expect(node().toModel(userId: 'me', today: today).body, 'Para o futuro');
  });

  test('a capsule whose day has passed shows its text', () {
    final capsule = node(opensOn: DateTime(2026, 1, 1)).toModel(userId: 'me', today: today);

    expect(capsule.body, 'Para o futuro');
  });

  test('a capsule that has not opened yet hides its text', () {
    final capsule = node(opensOn: DateTime(2026, 3, 11)).toModel(userId: 'me', today: today);

    expect(capsule.body, isNull);
    expect(capsule.opensOn, DateTime(2026, 3, 11));
  });

  test('a capsule the person wrote is theirs, and one with a couple is shared', () {
    expect(node().toModel(userId: 'me', today: today).isMine, isTrue);
    expect(node(authorId: 'you').toModel(userId: 'me', today: today).isMine, isFalse);
    expect(node().toModel(userId: 'me', today: today).isShared, isFalse);
    expect(node(coupleId: 'c').toModel(userId: 'me', today: today).isShared, isTrue);
  });
}
