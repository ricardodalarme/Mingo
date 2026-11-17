import 'package:app/features/mood/data/data_sources/local/mood_local_data_source.dart';
import 'package:app/features/mood/data/data_sources/remote/mood_data_source.dart';
import 'package:app/features/mood/data/mappers/mood_enum_mapper.dart';
import 'package:app/features/mood/data/mappers/mood_record_mapper.dart';
import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

/// Today's own mood, the partner's shared mood and the partner's name for the share title.
typedef MoodToday = ({
  MoodEntry? entry,
  PartnerMood? partnerMood,
  String? partnerName,
  bool hasPartner,
});

class MoodRepository({
  required final MoodDataSource _dataSource,
  required final MoodLocalDataSource _localDataSource,
}) {
  final Logger _logger = Logger('MoodRepository');

  Future<MoodToday> getTodayMood() => _run("read today's mood", () async {
    final today = await _dataSource.getTodayMood();
    final entry = today.mood?.toEntry();
    await _localDataSource.write(entry);

    return (
      entry: entry,
      partnerMood: today.partnerMood?.toPartnerMood(),
      partnerName: today.partnerName,
      hasPartner: today.hasPartner,
    );
  });

  /// Today's own mood kept on the device, so a cold start paints before the read returns.
  MoodEntry? readCachedTodayMood() => _localDataSource.readToday();

  /// The person's own moods for [month], oldest first.
  ///
  /// The partner's shared mood is only ever today's row, so no other person's days arrive here.
  Future<List<MoodEntry>> getMonthMoods({required DateTime month}) =>
      _run('read the month of moods', () async {
        final first = DateTime(month.year, month.month);
        final last = DateTime(month.year, month.month + 1, 0);
        final rows = await _dataSource.getMonthMoods(from: first, to: last);

        return [for (final row in rows) row.toEntry()];
      });

  /// Updates today's row when it exists and inserts it otherwise, so the latest save wins.
  Future<MoodEntry> saveMood({required MoodKind mood, required MoodShare share, NeedKind? need}) =>
      _run("save today's mood", () async {
        final saved = await _save(mood: mood, share: share, need: need);
        await _localDataSource.write(saved);

        return saved;
      });

  /// Forgets the cached mood, for sign-out and unpair.
  Future<void> clearCache() => _localDataSource.clear();

  Future<MoodEntry> _save({
    required MoodKind mood,
    required MoodShare share,
    required NeedKind? need,
  }) async {
    final today = await _dataSource.getTodayMood();
    final existing = today.mood;
    if (existing != null) {
      return _update(id: existing.id, mood: mood, need: need, share: share);
    }

    try {
      final record = await _dataSource.insertMood(
        mood: mood.toRemote(),
        need: need?.toRemote(),
        share: share.toRemote(),
        day: today.day,
      );

      return record.toEntry();
    } on LocalizedException catch (exception) {
      if (!_isUniqueViolation(exception)) rethrow;
      final raced = await _dataSource.getTodayMood();
      final row = raced.mood;
      if (row == null) rethrow;

      return _update(id: row.id, mood: mood, need: need, share: share);
    }
  }

  Future<MoodEntry> _update({
    required String id,
    required MoodKind mood,
    required NeedKind? need,
    required MoodShare share,
  }) async {
    final record = await _dataSource.updateMood(
      id: id,
      mood: mood.toRemote(),
      need: need?.toRemote(),
      share: share.toRemote(),
    );

    return record.toEntry();
  }

  bool _isUniqueViolation(LocalizedException exception) =>
      exception.l10nKey == '23505' || exception.l10nKey.toLowerCase().contains('duplicate key');

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
