import 'package:app/features/diary/data/mappers/diary_entry_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a journal row keeps its id, day, text and mood', () {
    final day = DateTime.utc(2026, 3, 8);

    final entry = (id: 'e1', entryDate: day, body: 'Um dia calmo', mood: 'happy').toModel();

    expect(entry.id, 'e1');
    expect(entry.entryDate, day);
    expect(entry.body, 'Um dia calmo');
    expect(entry.mood, 'happy');
  });

  test('an entry with no mood has none', () {
    final entry = (id: 'e1', entryDate: DateTime.utc(2026), body: 'texto', mood: null).toModel();

    expect(entry.mood, isNull);
  });
}
