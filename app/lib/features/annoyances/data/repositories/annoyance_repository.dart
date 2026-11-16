import 'package:app/features/annoyances/data/data_sources/remote/annoyance_data_source.dart';
import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

class AnnoyanceRepository({required final AnnoyanceDataSource _dataSource}) {
  final Logger _logger = Logger('AnnoyanceRepository');

  /// Keeps what bothered the person; it expires on the server after 14 days.
  Future<Annoyance> save(String body) async {
    try {
      final row = await _dataSource.save(body.trim());

      return Annoyance(
        id: row.id,
        body: row.body,
        createdAt: row.createdAt,
        expiresAt: row.expiresAt,
      );
    } catch (e, stack) {
      _logger.error('Failed to save an annoyance', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// One annoyance, or null when it expired, was let go or was turned into a request.
  Future<Annoyance?> get(String id) async {
    try {
      final row = await _dataSource.get(id);
      if (row == null) return null;

      return Annoyance(
        id: row.id,
        body: row.body,
        createdAt: row.createdAt,
        expiresAt: row.expiresAt,
      );
    } catch (e, stack) {
      _logger.error('Failed to load an annoyance', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Lets it go: deletes it for good, without telling anyone.
  Future<void> delete(String id) async {
    try {
      await _dataSource.delete(id);
    } catch (e, stack) {
      _logger.error('Failed to delete an annoyance', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Sends a gentle request; fails with `NOT_PAIRED` when there is no partner.
  Future<void> sendGentleRequest({
    required String whenText,
    required String feelText,
    required String wishText,
    String? annoyanceId,
  }) async {
    try {
      final sent = await _dataSource.sendGentleRequest(
        whenText: whenText.trim(),
        feelText: feelText.trim(),
        wishText: wishText.trim(),
        annoyanceId: annoyanceId,
      );
      if (!sent) throw const LocalizedException(l10nKey: 'NOT_PAIRED');
    } catch (e, stack) {
      _logger.error('Failed to send a gentle request', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
