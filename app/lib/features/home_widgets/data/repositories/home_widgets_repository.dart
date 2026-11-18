import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/distance/data/models/distance_info.dart';
import 'package:app/features/distance/data/repositories/distance_repository.dart';
import 'package:app/features/home_widgets/data/data_sources/local/home_widgets_local_data_source.dart';
import 'package:app/features/home_widgets/data/data_sources/remote/home_widgets_data_source.dart';
import 'package:app/features/home_widgets/data/mappers/home_widgets_mapper.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/data/services/home_widget_data_service.dart';
import 'package:clock/clock.dart';

/// Reads what the home widgets show from the backend and writes it for the iOS and Android extensions.
///
/// Never logs the payload or the names in it.
class HomeWidgetsRepository({
  required final HomeWidgetsDataSource _dataSource,
  required final HomeWidgetsLocalDataSource _localDataSource,
  required final HomeWidgetDataService _homeWidgetDataService,
  required final AuthenticationRepository _authenticationRepository,
  required final DistanceRepository _distanceRepository,
}) {
  Future<void> _writeQueue = Future<void>.value();
  int _generation = 0;

  /// Fetches the latest state, writes it to the native store and returns it.
  ///
  /// Falls back to the last written payload when the server is unreachable and rethrows when
  /// there is none.
  Future<HomeWidgetPayload> loadAndSync({DateTime? now}) async {
    final generation = ++_generation;
    final referenceNow = now ?? clock.now();

    try {
      final userId = _authenticationRepository.currentUserId;
      if (userId == null) throw StateError('The widgets need a signed-in person');
      final response = await _dataSource.getOverview(userId: userId, today: referenceNow);
      final isPaired = response.overview.today.firstOrNull?.coupleId != null;
      final distance = isPaired ? await _readDistance(referenceNow) : null;
      final payload = response.overview.toPayload(
        cardStatus: response.cardStatus,
        distance: distance,
        now: referenceNow,
      );

      return await _enqueueWrite<HomeWidgetPayload?>(() async {
            if (generation != _generation) return null;
            final written = await _homeWidgetDataService.writePayload(payload, referenceNow: now);
            await _localDataSource.writeCachedPayload(written);

            return written;
          }) ??
          payload;
    } on Object {
      final cached = _localDataSource.readCachedPayload();
      if (cached == null) rethrow;

      return cached.sanitized(referenceNow: referenceNow);
    }
  }

  /// Refreshes the shared store in the background; a failure keeps what the home widgets already show.
  Future<void> syncQuietly({DateTime? now}) async {
    try {
      await loadAndSync(now: now);
    } on Object {
      // The home widgets keep their last payload.
    }
  }

  /// Writes the neutral signed-out payload and forgets the cached one.
  Future<HomeWidgetPayload> clearOnSignOut({DateTime? now}) async {
    _generation++;
    await _localDataSource.clear();

    return _enqueueWrite(() => _homeWidgetDataService.clearForSignOut(referenceNow: now));
  }

  Future<DistanceInfo?> _readDistance(DateTime now) async {
    try {
      return await _distanceRepository.getDistance(now: now);
    } on Object {
      return null;
    }
  }

  Future<T> _enqueueWrite<T>(Future<T> Function() task) {
    final result = Completer<T>();
    _writeQueue = _writeQueue.then((_) async {
      try {
        result.complete(await task());
      } catch (error, stackTrace) {
        result.completeError(error, stackTrace);
      }
    });

    return result.future;
  }
}
