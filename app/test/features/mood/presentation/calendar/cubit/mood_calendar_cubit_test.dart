import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/calendar/cubit/mood_calendar_cubit.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

void main() {
  late MoodRepository repository;

  final day = DateTime(2026, 11, 10);
  final entry = MoodEntry(id: 'm1', day: day, mood: MoodKind.tired, share: MoodShare.none);
  final now = DateTime(2026, 11, 16, 21, 30);

  setUp(() {
    repository = _MockMoodRepository();
  });

  MoodCalendarCubit build() {
    final cubit = MoodCalendarCubit(moodRepository: repository);
    addTearDown(cubit.close);

    return cubit;
  }

  test('reads the current month and marks the days that have a mood', () async {
    when(() => repository.getMonthMoods(month: any(named: 'month')))
        .thenAnswer((_) async => [entry]);
    final cubit = build();

    await withClock(Clock.fixed(now), cubit.load);

    expect(cubit.state.month, DateTime(2026, 11));
    expect(cubit.state.entries, isA<Success<List<MoodEntry>>>());
    expect((cubit.state.entries as Success<List<MoodEntry>>).value, [entry]);
    expect(cubit.state.markedDays, {day});
    expect(cubit.state.isEmpty, isFalse);
    verify(() => repository.getMonthMoods(month: now)).called(1);
  });

  test('the marks drop the time of day', () async {
    when(() => repository.getMonthMoods(month: any(named: 'month'))).thenAnswer(
      (_) async => [
        MoodEntry(
          id: 'm1',
          day: DateTime(2026, 11, 10, 22, 15),
          mood: MoodKind.sad,
          share: MoodShare.none,
        ),
      ],
    );
    final cubit = build();

    await withClock(Clock.fixed(now), cubit.load);

    expect(cubit.state.markedDays, {day});
  });

  test('a month without moods reports empty with no marks', () async {
    when(() => repository.getMonthMoods(month: any(named: 'month'))).thenAnswer((_) async => []);
    final cubit = build();

    await withClock(Clock.fixed(now), cubit.load);

    expect(cubit.state.isEmpty, isTrue);
    expect(cubit.state.markedDays, isEmpty);
  });

  test('a failed read becomes a failure resource', () async {
    when(() => repository.getMonthMoods(month: any(named: 'month')))
        .thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();

    await withClock(Clock.fixed(now), cubit.load);

    expect(cubit.state.entries, isA<Failure>());
    expect(cubit.state.markedDays, isEmpty);
  });

  test('a closed cubit ignores a month that finishes later', () async {
    when(() => repository.getMonthMoods(month: any(named: 'month')))
        .thenAnswer((_) async => [entry]);
    final cubit = build();

    await cubit.close();

    await expectLater(withClock(Clock.fixed(now), cubit.load), completes);
  });
}
