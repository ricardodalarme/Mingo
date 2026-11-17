import 'package:app/features/memories/data/models/drawn_slip.dart';
import 'package:app/features/memories/data/repositories/memories_repository.dart';
import 'package:app/features/memories/presentation/jar/cubit/jar_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMemoriesRepository() extends Mock implements MemoriesRepository;

void main() {
  late MemoriesRepository repository;

  setUp(() => repository = _MockMemoriesRepository());

  test('the jar returns a slip, or null when it is empty', () async {
    when(() => repository.drawFromJar())
        .thenAnswer((_) async => const DrawnSlip(id: 's1', body: 'Fez café'));
    final cubit = JarCubit(memoriesRepository: repository);

    await cubit.draw();
    expect((cubit.state.slip as Success<DrawnSlip?>).value?.id, 's1');

    when(() => repository.drawFromJar()).thenAnswer((_) async => null);
    await cubit.draw();
    expect((cubit.state.slip as Success<DrawnSlip?>).value, isNull);
  });

  test('a failed draw shows the failure', () async {
    when(() => repository.drawFromJar()).thenThrow(Exception('offline'));
    final cubit = JarCubit(memoriesRepository: repository);

    await cubit.draw();

    expect(cubit.state.slip, isA<Failure>());
  });
}
