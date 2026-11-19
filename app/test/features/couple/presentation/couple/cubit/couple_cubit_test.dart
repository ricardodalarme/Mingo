import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHistoryRepository() extends Mock implements HistoryRepository;

void main() {
  late HistoryRepository history;

  setUp(() => history = _MockHistoryRepository());

  CoupleCubit build() => CoupleCubit(historyRepository: history);

  test('opens on Juntos', () {
    expect(build().state.section, CoupleSection.together);
  });

  test('select opens the other part and keeps the rest', () {
    final cubit = build()..select(CoupleSection.memories);

    expect(cubit.state.section, CoupleSection.memories);
  });

  test('a failed read leaves the chip plain', () async {
    when(history.getOverview).thenThrow(Exception('offline'));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.togetherSince, isNull);
  });
}
