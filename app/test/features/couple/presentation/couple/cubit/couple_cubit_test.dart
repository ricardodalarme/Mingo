import 'package:app/features/couple/presentation/couple/cubit/couple_cubit.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockHistoryRepository() extends Mock implements HistoryRepository;

void main() {
  late HistoryRepository history;

  setUp(() => history = _MockHistoryRepository());

  CoupleCubit build() => CoupleCubit(historyRepository: history);

  test('a failed read leaves the chip plain', () async {
    when(history.getOverview).thenThrow(Exception('offline'));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.togetherSince, isNull);
  });
}
