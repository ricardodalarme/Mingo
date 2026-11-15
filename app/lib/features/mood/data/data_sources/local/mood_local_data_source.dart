import 'dart:convert';

import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:clock/clock.dart';
import 'package:preferences_service/preferences_service.dart';

/// Keeps today's own mood on the device so Hoje paints it before the read returns.
///
/// The partner's shared mood is never cached.
class MoodLocalDataSource({required final PreferencesService _preferencesService}) {
  static const _key = 'moodTodayCache';

  /// Today's cached mood, or null when there is none or the cache belongs to another day.
  MoodEntry? readToday() {
    final raw = _preferencesService.readString(key: _key);
    if (raw == null) return null;

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final entry = MoodEntry(
        id: map['id'] as String,
        day: DateTime.parse(map['day'] as String),
        mood: MoodKind.values.asNameMap()[map['mood'] as String?],
        need: NeedKind.values.asNameMap()[map['need'] as String?],
        share: MoodShare.values.asNameMap()[map['share'] as String?] ?? MoodShare.none,
      );

      return _isToday(entry.day) ? entry : null;
    } on Object {
      return null;
    }
  }

  /// Stores today's mood; a null entry forgets the cache instead of showing a stale one.
  Future<void> write(MoodEntry? entry) async {
    if (entry == null) return clear();

    await _preferencesService.writeString(
      key: _key,
      value: jsonEncode(<String, dynamic>{
        'id': entry.id,
        'day': entry.day.toIso8601String(),
        'mood': entry.mood?.name,
        'need': entry.need?.name,
        'share': entry.share.name,
      }),
    );
  }

  Future<void> clear() => _preferencesService.delete(key: _key);

  bool _isToday(DateTime day) {
    final now = clock.now();

    return day.year == now.year && day.month == now.month && day.day == now.day;
  }
}
