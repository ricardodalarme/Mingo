import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/queries/generated/MyTemperatureChecks.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/repair_data_source.dart';
import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepairDataSource() extends Mock implements RepairDataSource;

void main() {
  late RepairDataSource dataSource;
  late RepairRepository repository;
  final now = DateTime(2026, 11, 18, 12);

  QueryMyTemperatureCheckstemperatureChecks check(EnumTemperatureLevel_enum level, Duration ago) =>
      QueryMyTemperatureCheckstemperatureChecks(
        id: 'c',
        level: level,
        createdAt: now.subtract(ago),
      );

  void stubLatest(List<QueryMyTemperatureCheckstemperatureChecks> checks) =>
      when(() => dataSource.getTemperatureChecks(limit: any(named: 'limit')))
          .thenAnswer((_) async => checks);

  setUp(() {
    dataSource = _MockRepairDataSource();
    repository = RepairRepository(dataSource: dataSource);
  });

  test('a fight answer from the last day is a conflict', () async {
    stubLatest([check(EnumTemperatureLevel_enum.fight, const Duration(hours: 3))]);

    expect(await withClock(Clock.fixed(now), repository.isInConflict), isTrue);
  });

  test('a fight answer from two days ago is not a conflict', () async {
    stubLatest([check(EnumTemperatureLevel_enum.fight, const Duration(hours: 49))]);

    expect(await withClock(Clock.fixed(now), repository.isInConflict), isFalse);
  });

  test('a calmer latest answer or no answer is not a conflict', () async {
    stubLatest([check(EnumTemperatureLevel_enum.turbulent, const Duration(hours: 1))]);
    expect(await withClock(Clock.fixed(now), repository.isInConflict), isFalse);

    stubLatest([]);
    expect(await withClock(Clock.fixed(now), repository.isInConflict), isFalse);
  });

  test('the history is mapped from the stored levels', () async {
    stubLatest([check(EnumTemperatureLevel_enum.so_so, const Duration(days: 2))]);

    final checks = await repository.getTemperatureChecks();

    expect(checks.single.level, Temperature.soSo);
  });
}
