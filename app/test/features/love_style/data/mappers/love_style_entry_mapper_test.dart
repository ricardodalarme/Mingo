import 'package:app/features/love_style/data/mappers/love_style_entry_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a result keeps its id, its ranking and when it was shared', () {
    final shared = DateTime.utc(2026, 3, 8);

    final entry = (
      id: 'r1',
      authorId: 'me',
      ranked: ['words', 'time', 'touch'],
      sharedAt: shared,
    ).toModel();

    expect(entry.id, 'r1');
    expect(entry.ranked, ['words', 'time', 'touch']);
    expect(entry.sharedAt, shared);
  });

  test('a result not shared yet has no share time', () {
    final entry = (id: 'r1', authorId: 'me', ranked: <String>[], sharedAt: null).toModel();

    expect(entry.sharedAt, isNull);
  });
}
