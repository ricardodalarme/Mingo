import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/mood/data/data_sources/remote/mood_data_source.dart';
import 'package:app/features/mood/data/mappers/mood_record_mapper.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final day = DateTime(2026, 11, 9);

  test('maps the mood, the need and what is shared', () {
    final MoodRecord record = (
      id: 'm1',
      day: day,
      mood: EnumMood.tired,
      need: EnumMoodNeed.hug,
      share: EnumMoodShare.mood_need,
    );

    final entry = record.toEntry();

    expect(entry.id, 'm1');
    expect(entry.day, day);
    expect(entry.mood, MoodKind.tired);
    expect(entry.need, NeedKind.hug);
    expect(entry.share, MoodShare.moodNeed);
  });

  test('an entry without a need has none', () {
    final MoodRecord record = (
      id: 'm1',
      day: day,
      mood: EnumMood.happy,
      need: null,
      share: EnumMoodShare.none,
    );

    expect(record.toEntry().need, isNull);
  });

  test('a mood this version does not know is left out', () {
    final MoodRecord record = (
      id: 'm1',
      day: day,
      mood: EnumMood.$unknown,
      need: null,
      share: EnumMoodShare.none,
    );

    expect(record.toEntry().mood, isNull);
  });
}
