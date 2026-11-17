import 'package:app/features/account/data/data_sources/remote/account_data_source.dart';
import 'package:app/features/account/data/mappers/deletion_request_mapper.dart';
import 'package:app/features/account/data/models/deletion_request.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:core/core.dart';

/// Requests and cancels the 30-day account deletion, and exports the person's data.
class AccountRepository({
  required final AccountDataSource _dataSource,
  required final AuthenticationRepository _authenticationRepository,
}) {
  String get _userId {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) throw const LocalizedException(l10nKey: 'UNAUTHENTICATED');

    return userId;
  }

  Future<DeletionRequest?> getDeletion() async {
    final row = await _dataSource.getDeletion(_userId);
    if (row == null) return null;

    return row.toModel();
  }

  Future<DeletionRequest> requestDeletion() async {
    final row = await _dataSource.requestDeletion();

    return row.toModel();
  }

  /// A short-lived link to a file with the person's own data.
  Future<Uri> exportData() async {
    return await _dataSource.exportData(accessToken: _authenticationRepository.getAccessToken());
  }

  Future<void> cancelDeletion() async {
    await _dataSource.cancelDeletion(_userId);
  }
}
