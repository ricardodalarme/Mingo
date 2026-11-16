import 'dart:typed_data';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/widgets/data/data_sources/remote/couple_photo_data_source.dart';
import 'package:app/features/widgets/data/models/couple_photo.dart';
import 'package:app/features/widgets/data/services/couple_photo_image.dart';
import 'package:app/features/widgets/data/services/widget_data_service.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:storage_service/storage_service.dart';

typedef PhotoResizer = Future<Uint8List?> Function(Uint8List bytes);
typedef PhotoDownloader = Future<Uint8List> Function(String url);

/// Reads and writes the couple photo row and its private storage file.
///
/// Never logs photo bytes or storage paths.
class CouplePhotoRepository({
  required final CouplePhotoDataSource _dataSource,
  required final StorageService _storageService,
  required final AuthenticationRepository _authenticationRepository,
  required final WidgetDataService _widgetDataService,
  final PhotoResizer _resizePhoto = CouplePhotoImage.downscalePng,
  final PhotoDownloader? _downloadPhoto,
}) {
  static const String bucket = 'couple-photos';
  static const int maxBytes = 8 * 1024 * 1024;

  final Logger _logger = Logger('CouplePhotoRepository');

  PhotoDownloader get _photoDownloader => _downloadPhoto ?? _storageService.download;

  /// The couple's current photo with a short-lived read URL, or null when none was chosen.
  Future<CouplePhoto?> getPhoto() async {
    try {
      final snapshot = await _dataSource.getPhoto(_requireUserId());
      final photo = snapshot.photo;
      if (photo == null) return null;

      String? url;
      try {
        url = await _storageService.signedUrl(fileId: photo.fileId);
      } on Object {
        url = null;
      }
      return photo.copyWith(url: url);
    } catch (e, stack) {
      _logger.error('Failed to read the couple photo', error: e.runtimeType, stackTrace: stack);
      throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_LOAD_FAILED');
    }
  }

  /// Synchronizes the widget cache with the couple photo row.
  ///
  /// Returns whether the couple has a photo row. When [cacheAllowed] is false the file is
  /// deleted and nothing is downloaded.
  Future<bool> syncWidgetCache({required bool cacheAllowed}) async {
    try {
      final snapshot = await _dataSource.getPhoto(_requireUserId());
      final photo = snapshot.photo;

      if (!cacheAllowed) {
        await _widgetDataService.clearCouplePhoto();
        return photo != null;
      }
      if (photo == null) {
        await _widgetDataService.clearCouplePhoto();
        return false;
      }

      final cachedPath = await _widgetDataService.readCachedPhotoPath(hasPlus: true);
      final marker = await _widgetDataService.readCachedPhotoUpdatedAt();
      final updatedAt = photo.updatedAt.toUtc().toIso8601String();
      if (cachedPath != null && marker == updatedAt) return true;

      String? url;
      try {
        url = await _storageService.signedUrl(fileId: photo.fileId);
      } on Object {
        url = null;
      }
      if (url == null) return cachedPath != null;

      final downloaded = await _photoDownloader(url);
      final resized = await _resizePhoto(downloaded);
      if (resized == null) return cachedPath != null;

      await _widgetDataService.cacheCouplePhoto(resized, 'png', updatedAt: photo.updatedAt);
      return true;
    } catch (e, stack) {
      _logger.error(
        'Failed to sync the couple photo cache',
        error: e.runtimeType,
        stackTrace: stack,
      );
      if (!cacheAllowed) {
        await _widgetDataService.clearCouplePhoto();
        return false;
      }
      final cachedPath = await _widgetDataService.readCachedPhotoPath(hasPlus: true);
      return cachedPath != null;
    }
  }

  /// Uploads [bytes], replaces the row, and caches a widget-sized copy.
  Future<void> upload({required Uint8List bytes, required String contentType}) async {
    final extension = _extensionFor(contentType);
    if (extension == null || bytes.isEmpty || bytes.length > maxBytes) {
      throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_INVALID');
    }
    final resized = await _resizePhoto(bytes);
    if (resized == null) throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_INVALID');

    try {
      final snapshot = await _dataSource.getPhoto(_requireUserId());
      final coupleId = snapshot.coupleId;
      if (coupleId == null) throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_NOT_PAIRED');

      final fileId = await _storageService.upload(
        bucket: bucket,
        bytes: bytes,
        contentType: contentType,
        name: 'couple.$extension',
      );
      try {
        final updated = await _dataSource.update(coupleId: coupleId, fileId: fileId);
        if (updated == 0) {
          final inserted = await _dataSource.insert(coupleId: coupleId, fileId: fileId);
          if (inserted == 0) {
            throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_UPLOAD_FAILED');
          }
        }
      } on Object {
        await _removeQuietly(fileId);
        rethrow;
      }

      DateTime? updatedAt;
      try {
        updatedAt = (await _dataSource.getPhoto(_requireUserId())).photo?.updatedAt;
      } on Object {
        updatedAt = null;
      }
      await _widgetDataService.cacheCouplePhoto(resized, 'png', updatedAt: updatedAt);
    } catch (e, stack) {
      if (e is LocalizedException) rethrow;
      _logger.error('Failed to upload the couple photo', error: e.runtimeType, stackTrace: stack);
      throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_UPLOAD_FAILED');
    }
  }

  /// Deletes the row and the storage file, then clears the widget cache.
  Future<void> remove() async {
    try {
      final snapshot = await _dataSource.getPhoto(_requireUserId());
      final coupleId = snapshot.coupleId;
      if (coupleId == null) throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_NOT_PAIRED');

      final deleted = await _dataSource.delete(coupleId);
      if (deleted == 0) throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_REMOVE_FAILED');

      final fileId = snapshot.photo?.fileId;
      if (fileId != null) await _removeQuietly(fileId);

      await _widgetDataService.clearCouplePhoto();
    } catch (e, stack) {
      if (e is LocalizedException) rethrow;
      _logger.error('Failed to remove the couple photo', error: e.runtimeType, stackTrace: stack);
      throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_REMOVE_FAILED');
    }
  }

  String _requireUserId() {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) throw const LocalizedException(l10nKey: 'COUPLE_PHOTO_SIGNED_OUT');

    return userId;
  }

  Future<void> _removeQuietly(String fileId) async {
    try {
      await _storageService.remove(fileId: fileId);
    } on Object {
      // A file that is already gone does not block the row change.
    }
  }

  static String? _extensionFor(String contentType) => switch (contentType) {
    'image/jpeg' => 'jpg',
    'image/png' => 'png',
    'image/webp' => 'webp',
    'image/heic' => 'heic',
    _ => null,
  };
}
