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
    EnumMood_enum mood = EnumMood_enum.tired,
    EnumMoodNeed_enum? need = EnumMoodNeed_enum.hug,
    EnumMoodShare_enum share = EnumMoodShare_enum.mood_need,
  }) => (id: 'm1', day: day, mood: mood, need: need, share: share);
  MoodTodayRecord today({
    MoodRecord? mood,
    String? partnerName = 'Rui',
    PartnerMoodRecord? partnerMood,
    bool hasPartner = true,
  }) => (
    day: day,
    hasPartner: hasPartner,
    partnerName: partnerName,
    mood: mood,
    partnerMood: partnerMood,
  );

  setUpAll(() {
    registerFallbackValue('');
    registerFallbackValue(EnumMood_enum.happy);
    registerFallbackValue(EnumMoodNeed_enum.hug);
    registerFallbackValue(EnumMoodShare_enum.none);
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

    expect(result.hasPartner, isTrue);
    expect(result.partnerName, 'Rui');
    expect(result.entry?.id, 'm1');
    expect(result.entry?.day, day);
    expect(result.entry?.mood, MoodKind.tired);
    expect(result.entry?.need, NeedKind.hug);
    expect(result.entry?.share, MoodShare.moodNeed);
  });

  test('a person with nobody linked reads as having no partner', () async {
    when(() => dataSource.getTodayMood())
        .thenAnswer((_) async => today(hasPartner: false, partnerName: null));

    final result = await repository.getTodayMood();

    expect(result.hasPartner, isFalse);
    expect(result.partnerName, isNull);
    expect(result.partnerMood, isNull);
  });

  test("maps the partner's shared mood and need", () async {
    when(() => dataSource.getTodayMood()).thenAnswer(
      (_) async => today(
        partnerMood: (day: day, mood: EnumMood_enum.stressed, need: EnumMoodNeed_enum.space),
      ),
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
          mood: EnumMood_enum.$unknown,
          need: EnumMoodNeed_enum.$unknown,
          share: EnumMoodShare_enum.$unknown,
        ),
      ),
    );

    final result = await repository.getTodayMood();

    expect(result.entry?.mood, isNull);
    expect(result.entry?.need, isNull);
    expect(result.entry?.share, MoodShare.none);
  });

  test('saving an existing row updates today', () async {
    when(
      () => dataSource.updateMood(
        id: any(named: 'id'),
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((_) async => record(mood: EnumMood_enum.happy, share: EnumMoodShare_enum.mood));

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
        mood: EnumMood_enum.happy,
        need: EnumMoodNeed_enum.hug,
        share: EnumMoodShare_enum.mood,
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
      ),
    ).thenAnswer((_) async => record(mood: EnumMood_enum.sad, share: EnumMoodShare_enum.none));

    await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    verify(() => localDataSource.write(any())).called(1);
  });

  test('a midnight save re-reads the current row before updating', () async {
    when(() => dataSource.getTodayMood()).thenAnswer((_) async => today(mood: record()));
    when(
      () => dataSource.updateMood(
        id: any(named: 'id'),
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((_) async => record(need: null, share: EnumMoodShare_enum.none));

    await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    verify(
      () => dataSource.updateMood(
        id: 'm1',
        mood: EnumMood_enum.sad,
        need: null,
        share: EnumMoodShare_enum.none,
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
      ),
    ).thenAnswer((_) async => record(need: null, share: EnumMoodShare_enum.mood));

    final entry = await repository.saveMood(mood: MoodKind.happy, share: MoodShare.mood);

    expect(entry.need, isNull);
    verify(
      () => dataSource.updateMood(
        id: 'm1',
        mood: EnumMood_enum.happy,
        need: null,
        share: EnumMoodShare_enum.mood,
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
    ).thenAnswer(
      (_) async => record(mood: EnumMood_enum.sad, need: null, share: EnumMoodShare_enum.none),
    );

    await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    verify(
      () => dataSource.insertMood(
        mood: EnumMood_enum.sad,
        need: null,
        share: EnumMoodShare_enum.none,
        day: day,
      ),
    ).called(1);
  });

  test('a unique race updates the row created by the other save', () async {
    var reads = 0;
    when(() => dataSource.getTodayMood()).thenAnswer((_) async {
      reads++;

      return reads == 1 ? today() : today(mood: record(share: EnumMoodShare_enum.none));
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
      ),
    ).thenAnswer(
      (_) async => record(mood: EnumMood_enum.sad, need: null, share: EnumMoodShare_enum.none),
    );

    final entry = await repository.saveMood(mood: MoodKind.sad, share: MoodShare.none);

    expect(entry.mood, MoodKind.sad);
    verify(
      () => dataSource.insertMood(
        mood: EnumMood_enum.sad,
        need: null,
        share: EnumMoodShare_enum.none,
        day: day,
      ),
    ).called(1);
    verify(
      () => dataSource.updateMood(
        id: 'm1',
        mood: EnumMood_enum.sad,
        need: null,
        share: EnumMoodShare_enum.none,
      ),
    ).called(1);
  });

  test('a read failure is rethrown', () {
    when(() => dataSource.getTodayMood())
        .thenThrow(const LocalizedException(l10nKey: networkErrorCode));

    expect(repository.getTodayMood(), throwsA(isA<LocalizedException>()));
  });

  test('the month read asks for the first and the last day and maps the rows', () async {
    when(
      () => dataSource.getMonthMoods(
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenAnswer(
      (_) async => [
        record(),
        (
          id: 'm2',
          day: DateTime(2026, 11, 12),
          mood: EnumMood_enum.happy,
          need: null,
          share: EnumMoodShare_enum.none,
        ),
      ],
    );

    final entries = await repository.getMonthMoods(month: DateTime(2026, 11, 16));

    verify(() => dataSource.getMonthMoods(from: DateTime(2026, 11, 1), to: DateTime(2026, 11, 30)))
        .called(1);
    expect(entries, hasLength(2));
    expect(entries.first.mood, MoodKind.tired);
    expect(entries.last.mood, MoodKind.happy);
  });

  test('a month read failure is rethrown', () {
    when(
      () => dataSource.getMonthMoods(
        from: any(named: 'from'),
        to: any(named: 'to'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: networkErrorCode));

    expect(repository.getMonthMoods(month: DateTime(2026, 2)), throwsA(isA<LocalizedException>()));
  });
}
