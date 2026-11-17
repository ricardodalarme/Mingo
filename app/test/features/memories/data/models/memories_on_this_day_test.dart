import 'package:app/features/memories/data/models/memory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Memory at(String id, DateTime day) => Memory(id: id, title: id, happenedOn: day);

  test('only earlier years on the same calendar day come back, oldest first', () {
    final memories = [
      at('last-year', DateTime(2025, 11, 17)),
      at('three-years', DateTime(2023, 11, 17)),
      at('today', DateTime(2026, 11, 17)),
      at('other-day', DateTime(2025, 11, 18)),
    ];

    final found = memoriesOnThisDay(memories, today: DateTime(2026, 11, 17));

    expect(found.map((memory) => memory.id), ['three-years', 'last-year']);
  });
}
