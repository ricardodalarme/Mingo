import 'package:app/features/cycle/data/data_sources/remote/cycle_data_source.dart';
import 'package:app/features/cycle/data/repositories/cycle_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCycleDataSource() extends Mock implements CycleDataSource;

void main() {
  late CycleDataSource dataSource;
  late CycleRepository repository;

  final today = DateTime(2026, 11, 15);

  setUp(() {
    dataSource = _MockCycleDataSource();
    repository = CycleRepository(dataSource: dataSource);
  });

  test('the read returns the model, not the data source record', () async {
    when(() => dataSource.getSensitiveDays())
        .thenAnswer((_) async => (today: today, days: [today]));

    final days = await repository.getSensitiveDays();

    expect(days.today, today);
    expect(days.isTodayMarked, isTrue);
  });

  test('a failed read is logged and rethrown', () async {
    when(() => dataSource.getSensitiveDays())
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));

    await expectLater(repository.getSensitiveDays(), throwsA(isA<LocalizedException>()));
  });

  test('marking and unmarking reach the data source', () async {
    when(() => dataSource.markDay(any())).thenAnswer((_) async {});
    when(() => dataSource.unmarkDay(any())).thenAnswer((_) async {});

    await repository.markDay(today);
    await repository.unmarkDay(today);

    verify(() => dataSource.markDay(today)).called(1);
    verify(() => dataSource.unmarkDay(today)).called(1);
  });
}
