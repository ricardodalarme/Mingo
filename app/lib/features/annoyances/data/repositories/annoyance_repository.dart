import 'package:app/features/annoyances/data/data_sources/remote/annoyance_data_source.dart';
import 'package:app/features/annoyances/data/data_sources/remote/fragments/generated/GentleRequestFragment.graphql.dart';
import 'package:app/features/annoyances/data/mappers/gentle_response_mapper.dart';
import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:app/features/annoyances/data/models/gentle_request.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';
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

  Future<GentleRequest?> getGentleRequest(String id) async {
    try {
      final row = await _dataSource.getGentleRequest(id);

      return row == null ? null : _gentleRequest(row);
    } catch (e, stack) {
      _logger.error('Failed to load a gentle request', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Emits the request now and each time the other person answers, sees or thanks for it. A
  /// failed event is logged and skipped, so a screen keeps what it shows.
  Stream<GentleRequest> watchGentleRequest(String id) {
    return _dataSource.watchGentleRequest(id).map(_gentleRequest).handleError((
      Object e,
      StackTrace stack,
    ) {
      _logger.error('The gentle request subscription failed', error: e, stackTrace: stack);
    });
  }

  GentleRequest _gentleRequest(FragmentGentleRequestFragment row) => GentleRequest(
    id: row.id,
    whenText: row.whenText,
    feelText: row.feelText,
    wishText: row.wishText,
    senderId: row.senderId,
    recipientId: row.recipientId,
    createdAt: row.createdAt,
    response: row.response?.toGentleResponse(),
    seenAt: row.seenAt,
    thankedAt: row.thankedAt,
    senderName: row.sender.displayName,
    recipientName: row.recipient.displayName,
  );

  /// Answers a request that was sent to the person.
  Future<void> respond({required String id, required GentleResponse response}) async {
    try {
      await _dataSource.respond(id: id, response: response.toRemote());
    } catch (e, stack) {
      _logger.error('Failed to answer a gentle request', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Notes that the recipient opened the request.
  Future<void> markSeen(String id) async {
    try {
      await _dataSource.markSeen(id);
    } catch (e, stack) {
      _logger.error('Failed to mark a gentle request seen', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> thank({required String requestId, required String body}) async {
    try {
      await _dataSource.thank(requestId: requestId, body: body.trim());
    } catch (e, stack) {
      _logger.error('Failed to thank for a gentle request', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
