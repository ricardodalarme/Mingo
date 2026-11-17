import 'package:app/features/memories/data/data_sources/remote/queries/generated/Memories.graphql.dart';
import 'package:app/features/memories/data/mappers/memory_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a memory keeps its title, day, text and place', () {
    final day = DateTime.utc(2024, 7, 14);

    final memory = QueryMemoriesmemories(
      id: 'm1',
      title: 'Primeira viagem',
      body: 'Chovia o dia todo',
      happenedOn: day,
      place: 'Paraty',
    ).toModel();

    expect(memory.id, 'm1');
    expect(memory.title, 'Primeira viagem');
    expect(memory.body, 'Chovia o dia todo');
    expect(memory.happenedOn, day);
    expect(memory.place, 'Paraty');
  });

  test('a memory with no text or place has none', () {
    final memory = QueryMemoriesmemories(
      id: 'm1',
      title: 'Título',
      happenedOn: DateTime.utc(2024),
    ).toModel();

    expect(memory.body, isNull);
    expect(memory.place, isNull);
  });
}
