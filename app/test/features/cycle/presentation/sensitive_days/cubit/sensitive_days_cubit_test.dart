import 'dart:async';

import 'package:app/features/cycle/data/models/sensitive_day.dart';
import 'package:app/features/cycle/data/repositories/cycle_repository.dart';
import 'package:app/features/cycle/presentation/sensitive_days/cubit/sensitive_days_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCycleRepository() extends Mock implements CycleRepository;

void main() {
  late CycleRepository repository;

  final today = DateTime(2026, 11, 15);
  SensitiveDays days({List<DateTime> marked = const []}) => SensitiveDays(
    today: today,
    days: [for (final day in marked) SensitiveDay(day: day)],
  );

  setUpAll(() {
    registerFallbackValue(today);
  });

  setUp(() {
    repository = _MockCycleRepository();
    when(() => repository.getSensitiveDays()).thenAnswer((_) async => days());
    when(() => repository.markDay(any())).thenAnswer((_) async {});
    when(() => repository.unmarkDay(any())).thenAnswer((_) async {});
  });

  SensitiveDaysCubit build() {
    final cubit = SensitiveDaysCubit(cycleRepository: repository);
    addTearDown(cubit.close);

    return cubit;
  }

  test('the read starts as loading and keeps an unmarked day off', () async {
    final cubit = build();
    expect(cubit.state.days, isA<Loading>());

    await cubit.load();

    expect(cubit.state.currentDays?.isTodayMarked, isFalse);
  });

  test('a failed read becomes a failure', () async {
    when(() => repository.getSensitiveDays())
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.days, isA<Failure>());
  });

  test('turning the switch on marks today', () async {
    final cubit = build();
    await cubit.load();

    await cubit.toggleToday();

    verify(() => repository.markDay(today)).called(1);
    expect(cubit.state.currentDays?.isTodayMarked, isTrue);
    expect(cubit.state.toggleAction, isA<Success<void>>());
  });

  test('turning the switch off unmarks today', () async {
    when(() => repository.getSensitiveDays()).thenAnswer((_) async => days(marked: [today]));
    final cubit = build();
    await cubit.load();

    await cubit.toggleToday();

    verify(() => repository.unmarkDay(today)).called(1);
    expect(cubit.state.currentDays?.isTodayMarked, isFalse);
  });

  test('a second tap while the write is in flight writes once', () async {
    final pending = Completer<void>();
    when(() => repository.markDay(any())).thenAnswer((_) => pending.future);
    final cubit = build();
    await cubit.load();

    final first = cubit.toggleToday();
    final second = cubit.toggleToday();
    pending.complete();
    await Future.wait([first, second]);

    verify(() => repository.markDay(today)).called(1);
  });

  test('a failed write keeps the calendar and returns to idle', () async {
    when(() => repository.markDay(any())).thenThrow(const LocalizedException(l10nKey: 'NETWORK'));
    final cubit = build();
    await cubit.load();

    await cubit.toggleToday();

    expect(cubit.state.currentDays?.isTodayMarked, isFalse);
    expect(cubit.state.toggleAction, isA<Initial>());
  });

  test('a refresh that fails keeps the days already on screen', () async {
    final cubit = build();
    await cubit.load();
    when(() => repository.getSensitiveDays())
        .thenThrow(const LocalizedException(l10nKey: 'NETWORK'));

    await cubit.load();

    expect(cubit.state.currentDays, isNotNull);
  });
}
