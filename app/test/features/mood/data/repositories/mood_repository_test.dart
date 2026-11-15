import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/mood/data/data_sources/local/mood_local_data_source.dart';
import 'package:app/features/mood/data/data_sources/remote/mood_data_source.dart';
import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockMoodDataSource() extends Mock implements MoodDataSource;

class _MockMoodLocalDataSource() extends Mock implements MoodLocalDataSource;

void main() {
  late MoodDataSource dataSource;
  late MoodLocalDataSource localDataSource;
  late MoodRepository repository;

  final day = DateTime(2026, 11, 11);
  final cachedEntry = MoodEntry(
    id: 'm1',
    day: day,
    mood: MoodKind.tired,
    need: NeedKind.hug,
    share: MoodShare.moodNeed,
  );
  MoodRecord record({
    EnumMood mood = EnumMood.tired,
    EnumMoodNeed? need = EnumMoodNeed.hug,
    EnumMoodShare share = EnumMoodShare.mood_need,
  }) => (id: 'm1', day: day, mood: mood, need: need, share: share);
  MoodTodayRecord today({
    MoodRecord? mood,
    String? partnerName = 'Rui',
    PartnerMoodRecord? partnerMood,
  }) => (day: day, partnerName: partnerName, mood: mood, partnerMood: partnerMood);

  setUpAll(() {
    registerFallbackValue('');
    registerFallbackValue(EnumMood.happy);
    registerFallbackValue(EnumMoodNeed.hug);
    registerFallbackValue(EnumMoodShare.none);
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(cachedEntry);
  });

  setUp(() {
    dataSource = _MockMoodDataSource();
    localDataSource = _MockMoodLocalDataSource();
    repository = MoodRepository(dataSource: dataSource, localDataSource: localDataSource);
    when(() => dataSource.getTodayMood()).thenAnswer((_) async => today(mood: record()));
    when(() => localDataSource.write(any())).thenAnswer((_) async {});
    when(() => localDataSource.readToday()).thenReturn(cachedEntry);
    when(() => localDataSource.clear()).thenAnswer((_) async {});
  });

  test('maps the own mood, need, share and partner name', () async {
    final result = await repository.getTodayMood();

    expect(result.partnerName, 'Rui');
    expect(result.entry?.id, 'm1');
    expect(result.entry?.day, day);
    expect(result.entry?.mood, MoodKind.tired);
    expect(result.entry?.need, NeedKind.hug);
    expect(result.entry?.share, MoodShare.moodNeed);
  });

  test("maps the partner's shared mood and need", () async {
    when(() => dataSource.getTodayMood()).thenAnswer(
      (_) async =>
          today(partnerMood: (day: day, mood: EnumMood.stressed, need: EnumMoodNeed.space)),
    );

    final result = await repository.getTodayMood();

    expect(result.partnerMood?.mood, MoodKind.stressed);
    expect(result.partnerMood?.need, NeedKind.space);
  });

  test('a successful read refreshes the cached mood', () async {
    await repository.getTodayMood();

    verify(() => localDataSource.write(any())).called(1);
  });

  test('the cached mood is read without a network call', () {
    expect(repository.readCachedTodayMood(), cachedEntry);
    verifyNever(() => dataSource.getTodayMood());
  });

  test('clearing the cache forgets the stored mood', () async {
    await repository.clearCache();

    verify(() => localDataSource.clear()).called(1);
  });

  test('an unknown server value stays private and moodless', () async {
    when(() => dataSource.getTodayMood()).thenAnswer(
      (_) async => today(
        mood: record(
          mood: EnumMood.$unknown,
          need: EnumMoodNeed.$unknown,
          share: EnumMoodShare.$unknown,
        ),
      ),
    );

    final result = await repository.getTodayMood();

    expect(result.entry?.mood, isNull);
    expect(result.entry?.need, isNull);
    expect(result.entry?.share, MoodShare.none);
  });

  test('saving an existing row updates today and sends the server day', () async {
    when(
      () => dataSource.updateMood(
        id: any(named: 'id'),
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    ).thenAnswer((_) async => record(mood: EnumMood.happy, share: EnumMoodShare.mood));

    final entry = await repository.saveMood(
      mood: MoodKind.happy,
      need: NeedKind.hug,
      share: MoodShare.mood,
    );

    expect(entry.mood, MoodKind.happy);
    expect(entry.share, MoodShare.mood);
    verify(
      () => dataSource.updateMood(
        id: 'm1',
        mood: EnumMood.happy,
        need: EnumMoodNeed.hug,
        share: EnumMoodShare.mood,
        day: day,
      ),
    ).called(1);
    verifyNever(
      () => dataSource.insertMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    );
  });

  test('a save keeps the fresh mood on the device', () async {
    when(
      () => dataSource.updateMood(
        id: any(named: 'id'),
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    ).thenAnswer((_) async => record(mood: EnumMood.sad, share: EnumMoodShare.none));

    await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    verify(() => localDataSource.write(any())).called(1);
  });

  test('a midnight save re-reads the server day before updating', () async {
    when(() => dataSource.getTodayMood()).thenAnswer((_) async => today(mood: record()));
    when(
      () => dataSource.updateMood(
        id: any(named: 'id'),
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    ).thenAnswer((_) async => record(need: null, share: EnumMoodShare.none));

    await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    verify(
      () => dataSource.updateMood(
        id: 'm1',
        mood: EnumMood.sad,
        need: null,
        share: EnumMoodShare.none,
        day: day,
      ),
    ).called(1);
  });

  test('clearing the need sends a null need in the same update', () async {
    when(
      () => dataSource.updateMood(
        id: any(named: 'id'),
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    ).thenAnswer((_) async => record(need: null, share: EnumMoodShare.mood));

    final entry = await repository.saveMood(mood: MoodKind.happy, share: MoodShare.mood);

    expect(entry.need, isNull);
    verify(
      () => dataSource.updateMood(
        id: 'm1',
        mood: EnumMood.happy,
        need: null,
        share: EnumMoodShare.mood,
        day: day,
      ),
    ).called(1);
  });

  test('a missing row inserts with the server local day', () async {
    when(() => dataSource.getTodayMood()).thenAnswer((_) async => today());
    when(
      () => dataSource.insertMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    ).thenAnswer((_) async => record(mood: EnumMood.sad, need: null, share: EnumMoodShare.none));

    await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    verify(
      () => dataSource.insertMood(
        mood: EnumMood.sad,
        need: null,
        share: EnumMoodShare.none,
        day: day,
      ),
    ).called(1);
  });

  test('a unique race updates the row created by the other save', () async {
    var reads = 0;
    when(() => dataSource.getTodayMood()).thenAnswer((_) async {
      reads++;

      return reads == 1 ? today() : today(mood: record(share: EnumMoodShare.none));
    });
    when(
      () => dataSource.insertMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: '23505'));
    when(
      () => dataSource.updateMood(
        id: any(named: 'id'),
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
        day: any(named: 'day'),
      ),
    ).thenAnswer((_) async => record(mood: EnumMood.sad, need: null, share: EnumMoodShare.none));

    final entry = await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    expect(entry.mood, MoodKind.sad);
    verify(
      () => dataSource.insertMood(
        mood: EnumMood.sad,
        need: null,
        share: EnumMoodShare.none,
        day: day,
      ),
    ).called(1);
    verify(
      () => dataSource.updateMood(
        id: 'm1',
        mood: EnumMood.sad,
        need: null,
        share: EnumMoodShare.none,
        day: day,
      ),
    ).called(1);
  });

  test('a read failure is rethrown', () {
    when(() => dataSource.getTodayMood())
        .thenThrow(const LocalizedException(l10nKey: networkErrorCode));

    expect(repository.getTodayMood(), throwsA(isA<LocalizedException>()));
  });
}
