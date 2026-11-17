import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:app/features/repair/data/models/temperature_history.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:app/features/repair/presentation/history/cubit/temperature_history_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockRepairRepository() extends Mock implements RepairRepository;

void main() {
  late RepairRepository repository;
  final checks = [TemperatureCheck(level: Temperature.soSo, at: DateTime(2026, 11, 16))];

  setUp(() => repository = _MockRepairRepository());

  blocTest<TemperatureHistoryCubit, TemperatureHistoryState>(
    'loading shows the answers',
    setUp: () => when(repository.getTemperatureChecks).thenAnswer((_) async => checks),
    build: () => TemperatureHistoryCubit(repairRepository: repository),
    act: (cubit) => cubit.load(),
    expect: () => [
      const TemperatureHistoryState(),
      TemperatureHistoryState(checks: Success(checks)),
    ],
  );

  blocTest<TemperatureHistoryCubit, TemperatureHistoryState>(
    'a failed read shows the failure',
    setUp: () => when(repository.getTemperatureChecks).thenThrow(Exception('offline')),
    build: () => TemperatureHistoryCubit(repairRepository: repository),
    act: (cubit) => cubit.load(),
    verify: (cubit) => expect(cubit.state.checks, isA<Failure>()),
  );
}
