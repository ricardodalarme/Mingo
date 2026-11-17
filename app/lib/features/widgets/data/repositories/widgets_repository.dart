import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/distance/data/models/distance_info.dart';
import 'package:app/features/distance/data/repositories/distance_repository.dart';
import 'package:app/features/widgets/data/data_sources/local/widgets_local_data_source.dart';
import 'package:app/features/widgets/data/data_sources/remote/widgets_data_source.dart';
import 'package:app/features/widgets/data/mappers/widgets_mapper.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/data/repositories/couple_photo_repository.dart';
import 'package:app/features/widgets/data/services/widget_data_service.dart';
import 'package:core/core.dart';

/// Coordinates server widget reads, local privacy/rotation settings, and the shared native store.
///
/// Never logs widget payloads or personal names.
class WidgetsRepository({
  required final WidgetsDataSource _dataSource,
  required final WidgetsLocalDataSource _localDataSource,
  required final WidgetDataService _widgetDataService,
  required final CouplePhotoRepository _couplePhotoRepository,
  required final AuthenticationRepository _authenticationRepository,
  required final DistanceRepository _distanceRepository,
}) {
  Future<void> _writeQueue = Future<void>.value();
  int _generation = 0;

  /// Fetches the latest widget state from the backend, persists it to the native store,
  /// and falls back to the last cached payload with `isOffline: true` when offline.
  Future<WidgetOverview> loadAndSync({DateTime? now}) async {
    final generation = _generation + 1;
    _generation = generation;
    final contentSource = _localDataSource.contentSource;
    final rotationCadence = _localDataSource.rotationCadence;

    try {
      final userId = _authenticationRepository.currentUserId;
      if (userId == null) throw StateError('The widget overview needs a signed-in person');
      final response = await _dataSource.getOverview(userId);
      final today = response.overview.today.firstOrNull;
      final isPaired = today?.coupleId != null;
      final hasPlus = response.overview.plusStates.firstOrNull?.hasPlus ?? false;

      DistanceInfo? distance;
      if (isPaired) {
        try {
          distance = await _distanceRepository.getDistance(now: now);
        } on Object {
          distance = null;
        }
      }

      var hasPhoto = false;
      if (generation == _generation && isPaired) {
        try {
          hasPhoto = await _couplePhotoRepository.syncWidgetCache(cacheAllowed: hasPlus);
        } on Object {
          hasPhoto = false;
        }
      } else if (generation == _generation) {
        await _widgetDataService.clearCouplePhoto();
      }

      final cachedPhotoPath = await _widgetDataService.readCachedPhotoPath(hasPlus: hasPlus);

      final overview = response.overview.toModel(
        contentSource: contentSource,
        rotationCadence: rotationCadence,
        cardStatus: response.cardStatus,
        cachedPhotoPath: cachedPhotoPath,
        hasPhoto: hasPhoto,
        distance: distance,
        now: now,
      );

      final syncedPayload = await _enqueueWrite(() async {
        if (generation != _generation) return null;
        final written = await _widgetDataService.writePayload(overview.payload, referenceNow: now);
        await _localDataSource.writeCachedPayload(written);
        return written;
      });
      return syncedPayload == null ? overview : overview.copyWith(payload: syncedPayload);
    } catch (e) {
      final cached = _localDataSource.readCachedPayload();
      if (cached != null) {
        final offlinePayload = cached.copyWith(isOffline: true).sanitized(referenceNow: now);
        await _enqueueWrite(() async {
          if (generation != _generation) return;
          await _widgetDataService.writePayload(offlinePayload, referenceNow: now);
        });
        return WidgetOverview(
          payload: offlinePayload,
          preferences: WidgetPreferences(
            profileId: '',
            showNames: offlinePayload.showNames,
            allowPartnerNotes: offlinePayload.allowPartnerNotes,
            onLockScreen: offlinePayload.onLockScreen,
            contentSource: contentSource,
            rotationCadence: rotationCadence,
          ),
          hasPhoto: offlinePayload.cachedPhotoPath != null,
        );
      }
      rethrow;
    }
  }

  /// Refreshes the native shared store in the background without throwing to callers.
  Future<void> syncQuietly({DateTime? now}) async {
    try {
      await loadAndSync(now: now);
    } on Object {
      // Background sync failures keep the existing cached native state.
    }
  }

  /// Saves which families may show names and partner notes, then resyncs the payload.
  Future<WidgetOverview> savePrivacy({
    required bool showNames,
    required bool allowPartnerNotes,
    DateTime? now,
  }) async {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) {
      throw const LocalizedException(l10nKey: 'WIDGET_PREFERENCES_SAVE_FAILED');
    }
    try {
      await _dataSource.updateSettings(
        userId: userId,
        showNames: showNames,
        allowPartnerNotes: allowPartnerNotes,
      );
    } on LocalizedException {
      rethrow;
    } on Object {
      throw const LocalizedException(l10nKey: 'WIDGET_PREFERENCES_SAVE_FAILED');
    }

    return loadAndSync(now: now);
  }

  /// Writes a neutral signed-out payload and removes any cached personal state or photo.
  Future<WidgetPayload> clearOnSignOut({DateTime? now}) async {
    _generation++;
    await _localDataSource.clear();
    return _enqueueWrite(() => _widgetDataService.clearForSignOut(referenceNow: now));
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
