import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/today/data/data_sources/local/today_local_data_source.dart';
import 'package:app/features/today/data/data_sources/remote/today_data_source.dart';
import 'package:app/features/today/data/mappers/today_home_mapper.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:network/network.dart';

/// The Hoje state, whether it came from the device cache, and a pending unpair notice.
typedef TodayResult = ({
  TodayHome home,
  bool isFromCache,
  bool wasUnpaired,
  String? previousPartnerName,
});

class TodayRepository({
  required final TodayDataSource _dataSource,
  required final TodayLocalDataSource _localDataSource,
  required final AuthenticationRepository _authenticationRepository,
}) {
  final Logger _logger = Logger('TodayRepository');

  /// Reads Hoje from the server, falling back to the last cached state when offline.
  Future<TodayResult> getToday() async {
    try {
      final read = await _dataSource.getHome();
      final home = read.home.toModel();
      if (home == null) throw const NoDataException();

      final userId = _authenticationRepository.currentUserId;
      final pairing = read.isFromCache ? null : _localDataSource.readPairing();
      final wasUnpaired = _wasUnpaired(home: home, pairing: pairing, userId: userId);
      if (!read.isFromCache) {
        await _localDataSource.write(home);
        if (home.partnerId != null && userId != null) {
          await _localDataSource.writePairing(
            userId: userId,
            partnerId: home.partnerId,
            partnerName: home.partnerName,
          );
        }
      }
      return (
        home: home,
        isFromCache: read.isFromCache,
        wasUnpaired: wasUnpaired,
        previousPartnerName: wasUnpaired ? pairing?.partnerName : null,
      );
    } catch (e) {
      final cached = _localDataSource.read();
      if (cached != null && e is LocalizedException && e.l10nKey == networkErrorCode) {
        return (home: cached, isFromCache: true, wasUnpaired: false, previousPartnerName: null);
      }
      rethrow;
    }
  }

  /// Emits what Hoje shows that the server can change, now and on each change.
  ///
  /// A failed event is logged and skipped, so Hoje keeps what it shows.
  Stream<TodaySignals> watchSignals() {
    return _dataSource.watchSignals().handleError((Object e, StackTrace stack) {
      _logger.error('The Hoje subscription failed', error: e, stackTrace: stack);
    });
  }

  /// Marks the unpair notice as seen so it does not come back.
  Future<void> acknowledgeUnpair() async {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) return;
    await _localDataSource.writePairing(userId: userId);
  }

  /// Forgets the cached state and the last pairing state, for sign-out and unpair.
  Future<void> clearCache() => _localDataSource.clear();

  /// Whether the stored pairing is this person's and the new read dropped their partner.
  bool _wasUnpaired({
    required TodayHome home,
    required PairingMemory? pairing,
    required String? userId,
  }) {
    if (home.partnerId != null || pairing == null || userId == null) {
      return false;
    }

    return pairing.userId == userId && pairing.partnerId != null;
  }
}
