import 'package:app/features/account/data/data_sources/remote/account_data_source.dart';
import 'package:app/features/account/data/models/deletion_request.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

/// Requests and cancels the 14-day account deletion.
class AccountRepository({
  required final AccountDataSource _dataSource,
  required final AuthenticationRepository _authenticationRepository,
}) {
  final Logger _logger = Logger('AccountRepository');

  String get _userId {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) throw const LocalizedException(l10nKey: 'UNAUTHENTICATED');

    return userId;
  }

  Future<DeletionRequest?> getDeletion() async {
    try {
      final row = await _dataSource.getDeletion(_userId);
      if (row == null) return null;

      return DeletionRequest(requestedAt: row.requestedAt, purgeAfter: row.purgeAfter);
    } catch (e, stack) {
      _logger.error('Failed to read the deletion request', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<DeletionRequest> requestDeletion() async {
    try {
      final row = await _dataSource.requestDeletion();

      return DeletionRequest(requestedAt: row.requestedAt, purgeAfter: row.purgeAfter);
    } catch (e, stack) {
      _logger.error('Failed to request account deletion', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> cancelDeletion() async {
    try {
      await _dataSource.cancelDeletion(_userId);
    } catch (e, stack) {
      _logger.error('Failed to cancel account deletion', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
