import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/love_style/data/data_sources/remote/love_style_data_source.dart';
import 'package:app/features/love_style/data/mappers/love_style_entry_mapper.dart';
import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';

class LoveStyleRepository({
  required final LoveStyleDataSource _dataSource,
  required final AuthenticationRepository _authenticationRepository,
}) {
  static const int _manualValueLimit = 1000;

  /// The person's own result and the partner's result when it was shown.
  Future<LoveStyleOverview> getOverview() async {
    final record = await _dataSource.getResults();
    LoveStyleEntry? own;
    LoveStyleEntry? partner;
    for (final row in record.rows) {
      final entry = row.toModel();
      if (row.authorId == record.selfId) {
        own = entry;
      } else {
        partner = entry;
      }
    }

    return LoveStyleOverview(own: own, partner: partner);
  }

  /// Stores the latest ranking, updating the saved row so a retake replaces it.
  ///
  /// Returns the row id, which the share action needs.
  Future<String> saveRanked(List<String> ranked) async {
    final overview = await getOverview();
    final saved = overview.own;
    if (saved != null) {
      await _dataSource.updateResult(id: saved.id, ranked: ranked);

      return saved.id;
    }

    try {
      return await _dataSource.insertResult(ranked);
    } on LocalizedException catch (exception) {
      if (!_isUniqueViolation(exception)) rethrow;
      final raced = await getOverview();
      final row = raced.own;
      if (row == null) rethrow;
      await _dataSource.updateResult(id: row.id, ranked: ranked);

      return row.id;
    }
  }

  /// Shows the person's own result to the partner, or hides it again.
  Future<void> setShared({required String id, required bool isShared}) =>
      _dataSource.setShared(id: id, sharedAt: isShared ? clock.now().toUtc() : null);

  /// The saved `loved` manual value, whether it is private or shared with the partner.
  Future<String?> getManualEntry() async {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) return null;

    return (await _dataSource.getManualEntry(userId))?.value;
  }

  /// Inserts the `loved` manual entry, or updates it when the person already has one.
  Future<void> saveManualEntry(String value) async {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return;
    final bounded = trimmed.length > _manualValueLimit
        ? trimmed.substring(0, _manualValueLimit)
        : trimmed;
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) throw const LocalizedException(l10nKey: 'UNAUTHENTICATED');

    final saved = await _dataSource.getManualEntry(userId);
    if (saved != null) {
      await _dataSource.updateManualEntry(id: saved.id, value: bounded);

      return;
    }

    try {
      await _dataSource.insertManualEntry(bounded);
    } on LocalizedException catch (exception) {
      if (!_isUniqueViolation(exception)) rethrow;
      final raced = await _dataSource.getManualEntry(userId);
      if (raced == null) rethrow;
      await _dataSource.updateManualEntry(id: raced.id, value: bounded);
    }
  }

  bool _isUniqueViolation(LocalizedException exception) =>
      exception.l10nKey == '23505' || exception.l10nKey.toLowerCase().contains('duplicate key');
}
