import 'package:app/features/checkin/data/data_sources/local/checkin_local_data_source.dart';
import 'package:app/features/checkin/data/data_sources/remote/checkin_data_source.dart';
import 'package:app/features/checkin/data/mappers/checkin_answer_mapper.dart';
import 'package:app/features/checkin/data/models/checkin_answer.dart';
import 'package:app/features/checkin/data/models/checkin_week.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

class CheckinRepository({
  required final CheckinDataSource _dataSource,
  required final CheckinLocalDataSource _localDataSource,
}) {
  final Logger _logger = Logger('CheckinRepository');

  /// Reads the current week from the server's local day, scoped to the person's couple.
  Future<CheckinWeek> getWeek() => _run('read the weekly check-in', () async {
    final today = await _dataSource.getToday();
    final weekStart = checkinWeekStart(today.localDate);
    final coupleId = today.coupleId;
    if (coupleId == null || !today.isPaired) {
      return CheckinWeek(
        weekStart: weekStart,
        coupleId: coupleId,
        isPaired: today.isPaired,
        partnerName: today.partnerName,
      );
    }

    final result = await _dataSource.getAnswers(
      weekStart: weekStart,
      coupleId: coupleId,
      selfId: today.selfId,
    );
    final ownAnswers = <int, CheckinAnswer>{};
    final partnerAnswers = <int, CheckinAnswer>{};

    for (final row in result.answers) {
      final answer = row.toModel();
      if (row.isMine) {
        ownAnswers[answer.question] = answer;
      } else {
        partnerAnswers[answer.question] = answer;
      }
    }

    return CheckinWeek(
      weekStart: weekStart,
      coupleId: coupleId,
      isPaired: today.isPaired,
      partnerName: today.partnerName,
      ownRowId: result.ownRowId,
      ownAnswers: ownAnswers,
      partnerAnswers: partnerAnswers,
    );
  });

  /// Emits how many check-in rows of [week] are readable, now and on each change; empty when the
  /// person has no couple. A failed event is logged and skipped.
  Stream<int> watchRowCount(CheckinWeek week) {
    final coupleId = week.coupleId;
    if (coupleId == null) return const Stream.empty();

    return _dataSource.watchRowCount(weekStart: week.weekStart).handleError((
      Object e,
      StackTrace stack,
    ) {
      _logger.error('The check-in subscription failed', error: e, stackTrace: stack);
    });
  }

  /// Inserts the row for this week or updates the answer before the reveal.
  Future<CheckinAnswer> saveAnswer({
    required CheckinWeek week,
    required int question,
    required String body,
  }) => _run('save a check-in answer', () async {
    final coupleId = week.coupleId;
    if (coupleId == null) throw const LocalizedException(l10nKey: 'NO_COUPLE');

    final text = body.trim();
    try {
      return await _write(week: week, question: question, body: text);
    } on LocalizedException catch (exception) {
      if (week.ownRowId != null || !_isUniqueViolation(exception)) rethrow;
      final fresh = await getWeek();
      final rowId = fresh.ownRowId;
      if (rowId == null) rethrow;

      return _write(week: fresh, question: question, body: text);
    }
  });

  Future<CheckinAnswer> _write({
    required CheckinWeek week,
    required int question,
    required String body,
  }) async {
    final record = await _dataSource.saveAnswer(id: week.ownRowId, question: question, body: body);

    return record.toModel();
  }

  /// Clears one answer so a skipped question returns to being blank.
  Future<void> deleteAnswer({required String id, required int question}) =>
      _run('delete a check-in answer', () => _dataSource.deleteAnswer(id: id, question: question));

  /// Records that this week's check-in was dismissed locally.
  Future<void> dismissWeek(DateTime weekStart) => _localDataSource.writeDismissedWeek(weekStart);

  /// Whether the person dismissed the check-in for the server's current week.
  Future<bool> isCurrentWeekDismissed() => _run('read the check-in dismissal', () async {
    final today = await _dataSource.getToday();

    return _localDataSource.isDismissedFor(checkinWeekStart(today.localDate));
  });

  bool _isUniqueViolation(LocalizedException exception) =>
      exception.l10nKey == '23505' || exception.l10nKey.toLowerCase().contains('duplicate key');

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (exception) {
      final key = exception is LocalizedException
          ? exception.l10nKey
          : exception.runtimeType.toString();
      _logger.error('Failed to $what ($key)');
      rethrow;
    }
  }
}
