import 'dart:convert';

import 'package:app/features/mood/data/data_sources/local/mood_local_data_source.dart';
import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preferences_service/preferences_service.dart';

class _MockPreferencesService() extends Mock implements PreferencesService;

void main() {
  late PreferencesService preferences;
  late MoodLocalDataSource dataSource;

  final now = DateTime(2026, 11, 10, 12);
  final entry = MoodEntry(
    id: 'm1',
    day: DateTime(2026, 11, 10),
    mood: MoodKind.tired,
    need: NeedKind.hug,
    share: MoodShare.moodNeed,
  );
  const key = 'moodTodayCache';

  setUpAll(() => registerFallbackValue(''));

  setUp(() {
    preferences = _MockPreferencesService();
    dataSource = MoodLocalDataSource(preferencesService: preferences);
    when(() => preferences.delete(key: any(named: 'key'))).thenAnswer((_) async {});
    when(
      () => preferences.writeString(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  test("reads today's cached mood with its need and share", () {
    when(() => preferences.readString(key: key)).thenReturn(
      jsonEncode({
        'id': 'm1',
        'day': '2026-11-10T00:00:00.000',
        'mood': 'tired',
        'need': 'hug',
        'share': 'moodNeed',
      }),
    );

    final cached = withClock(Clock.fixed(now), dataSource.readToday);

    expect(cached, entry);
  });

  test('a cache from another day is not shown', () {
    when(() => preferences.readString(key: key))
        .thenReturn(jsonEncode({'id': 'm1', 'day': '2026-11-09T00:00:00.000', 'mood': 'tired'}));

    expect(withClock(Clock.fixed(now), dataSource.readToday), isNull);
  });

  test('a malformed cache is ignored', () {
    when(() => preferences.readString(key: key)).thenReturn('not json');

    expect(withClock(Clock.fixed(now), dataSource.readToday), isNull);
  });

  test('an empty cache reads as nothing', () {
    when(() => preferences.readString(key: key)).thenReturn(null);

    expect(withClock(Clock.fixed(now), dataSource.readToday), isNull);
  });

  test('writes the entry with enum names', () async {
    await dataSource.write(entry);

    final written =
        verify(
              () => preferences.writeString(
                key: key,
                value: captureAny(named: 'value'),
              ),
            ).captured.single
            as String;
    expect(jsonDecode(written), {
      'id': 'm1',
      'day': '2026-11-10T00:00:00.000',
      'mood': 'tired',
      'need': 'hug',
      'share': 'moodNeed',
    });
  });

  test('a null entry forgets the cache instead of a stale mood', () async {
    await dataSource.write(null);

    verify(() => preferences.delete(key: key)).called(1);
    verifyNever(
      () => preferences.writeString(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    );
  });
}
