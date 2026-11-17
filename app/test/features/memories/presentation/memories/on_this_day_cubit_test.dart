import 'package:app/features/memories/data/models/memory.dart';
import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:app/features/memories/presentation/memories/cubit/on_this_day_cubit.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMemoriesRepository() extends Mock implements MemoriesRepository;

void main() {
  late MemoriesRepository repository;

  setUp(() => repository = _MockMemoriesRepository());

  test('shows what happened on this day in an earlier year', () async {
    final memory = Memory(id: 'm', title: 'Primeiro jantar', happenedOn: DateTime(2025, 11, 17));
    when(repository.getMemories).thenAnswer((_) async => [memory]);
    final cubit = OnThisDayCubit(memoriesRepository: repository);

    await withClock(Clock.fixed(DateTime(2026, 11, 17)), cubit.load);

    expect(cubit.state, [memory]);
  });

  test('a failed read shows nothing', () async {
    when(repository.getMemories).thenThrow(Exception('offline'));
    final cubit = OnThisDayCubit(memoriesRepository: repository);

    await cubit.load();

    expect(cubit.state, isEmpty);
  });
}
