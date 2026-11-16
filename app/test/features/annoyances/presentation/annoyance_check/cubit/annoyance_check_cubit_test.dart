import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/annoyances/presentation/annoyance_check/cubit/annoyance_check_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAnnoyanceRepository() extends Mock implements AnnoyanceRepository;

void main() {
  late AnnoyanceRepository repository;
  final annoyance = Annoyance(
    id: 'a1',
    body: 'Fiquei com a louça sozinha',
    createdAt: DateTime(2026, 11, 1),
    expiresAt: DateTime(2026, 11, 15),
  );

  setUp(() {
    repository = _MockAnnoyanceRepository();
    when(() => repository.get('a1')).thenAnswer((_) async => annoyance);
    when(() => repository.delete('a1')).thenAnswer((_) async {});
  });

  AnnoyanceCheckCubit build() => AnnoyanceCheckCubit(annoyanceRepository: repository);

  test('load shows the annoyance', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load('a1');

    expect(cubit.state.annoyance, Success<Annoyance?>(annoyance));
  });

  test('an annoyance that is gone loads as nothing, not an error', () async {
    when(() => repository.get('a1')).thenAnswer((_) async => null);
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.load('a1');

    expect(cubit.state.annoyance, const Success<Annoyance?>(null));
  });

  test('letting go deletes it', () async {
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.letGo('a1');

    verify(() => repository.delete('a1')).called(1);
    expect(cubit.state.letGoAction, isA<Success<void>>());
  });

  test('a failed let go shows the error and can be tried again', () async {
    when(() => repository.delete('a1')).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    addTearDown(cubit.close);

    await cubit.letGo('a1');

    expect(cubit.state.letGoAction, isA<Initial>());
  });

  test('the annoyance counts its age and the days it has left', () {
    expect(annoyance.ageInDays(DateTime(2026, 11, 11)), 10);
    expect(annoyance.daysLeft(DateTime(2026, 11, 11)), 4);
    expect(annoyance.daysLeft(DateTime(2026, 12, 1)), 0);
  });
}
