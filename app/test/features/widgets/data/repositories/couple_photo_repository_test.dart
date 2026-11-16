import 'dart:typed_data';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/widgets/data/data_sources/remote/couple_photo_data_source.dart';
import 'package:app/features/widgets/data/models/couple_photo.dart';
import 'package:app/features/widgets/data/repositories/couple_photo_repository.dart';
import 'package:app/features/widgets/data/services/widget_data_service.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage_service/storage_service.dart';

class _MockCouplePhotoDataSource() extends Mock implements CouplePhotoDataSource;

class _MockStorageService() extends Mock implements StorageService;

class _MockAuthenticationRepository() extends Mock implements AuthenticationRepository;

class _MockWidgetDataService() extends Mock implements WidgetDataService;

void main() {
  late CouplePhotoDataSource dataSource;
  late StorageService storageService;
  late AuthenticationRepository authenticationRepository;
  late WidgetDataService widgetDataService;
  late CouplePhotoRepository repository;

  final bytes = Uint8List.fromList([1, 2, 3]);
  final existing = CouplePhoto(
    coupleId: 'couple-1',
    fileId: 'file-old',
    uploadedBy: 'profile-1',
    updatedAt: DateTime.utc(2026, 11, 11),
  );

  setUpAll(() {
    registerFallbackValue(Uint8List(0));
    registerFallbackValue(existing);
    registerFallbackValue(DateTime.utc(2026, 11, 11));
  });

  setUp(() {
    dataSource = _MockCouplePhotoDataSource();
    storageService = _MockStorageService();
    authenticationRepository = _MockAuthenticationRepository();
    widgetDataService = _MockWidgetDataService();

    repository = CouplePhotoRepository(
      dataSource: dataSource,
      storageService: storageService,
      authenticationRepository: authenticationRepository,
      widgetDataService: widgetDataService,
      resizePhoto: (bytes) async => bytes,
      downloadPhoto: (_) async => bytes,
    );

    when(() => authenticationRepository.currentUserId).thenReturn('profile-1');
    when(
      () => storageService.upload(
        bucket: any(named: 'bucket'),
        bytes: any(named: 'bytes'),
        contentType: any(named: 'contentType'),
        name: any(named: 'name'),
      ),
    ).thenAnswer((_) async => 'file-new');
    when(() => storageService.remove(fileId: any(named: 'fileId'))).thenAnswer((_) async {
      return;
    });
    when(() => widgetDataService.cacheCouplePhoto(any(), any(), updatedAt: any(named: 'updatedAt')))
        .thenAnswer((_) async => '/tmp/mingo_widget_photo.png');
    when(() => widgetDataService.readCachedPhotoPath(hasPlus: any(named: 'hasPlus')))
        .thenAnswer((_) async => null);
    when(() => widgetDataService.readCachedPhotoUpdatedAt()).thenAnswer((_) async => null);
    when(() => widgetDataService.clearCouplePhoto()).thenAnswer((_) async {
      return;
    });
    when(() => dataSource.getPhoto(any()))
        .thenAnswer((_) async => (coupleId: 'couple-1', photo: existing));
    when(
      () => dataSource.update(
        coupleId: any(named: 'coupleId'),
        fileId: any(named: 'fileId'),
      ),
    ).thenAnswer((_) async => 1);
    when(
      () => dataSource.insert(
        coupleId: any(named: 'coupleId'),
        fileId: any(named: 'fileId'),
      ),
    ).thenAnswer((_) async => 1);
    when(() => dataSource.delete(any())).thenAnswer((_) async => 1);
  });

  group('upload', () {
    test('stores the file, upserts the row, and caches', () async {
      await repository.upload(bytes: bytes, contentType: 'image/jpeg');

      verify(
        () => storageService.upload(
          bucket: 'couple_photos',
          bytes: bytes,
          contentType: 'image/jpeg',
          name: 'couple.jpg',
        ),
      ).called(1);
      verify(() => dataSource.update(coupleId: 'couple-1', fileId: 'file-new')).called(1);
      verify(() => widgetDataService.cacheCouplePhoto(bytes, 'png', updatedAt: existing.updatedAt))
          .called(1);
    });

    test('leaves the replaced file to the row change', () async {
      await repository.upload(bytes: bytes, contentType: 'image/png');

      verifyNever(() => storageService.remove(fileId: any(named: 'fileId')));
    });

    test('inserts the row when the couple has none yet', () async {
      when(() => dataSource.getPhoto(any()))
          .thenAnswer((_) async => (coupleId: 'couple-1', photo: null));
      when(
        () => dataSource.update(
          coupleId: any(named: 'coupleId'),
          fileId: any(named: 'fileId'),
        ),
      ).thenAnswer((_) async => 0);

      await repository.upload(bytes: bytes, contentType: 'image/jpeg');

      verify(() => dataSource.insert(coupleId: 'couple-1', fileId: 'file-new')).called(1);
      verifyNever(() => storageService.remove(fileId: any(named: 'fileId')));
    });

    test('fails before writing when the person is not paired', () async {
      when(() => dataSource.getPhoto(any())).thenAnswer((_) async => (coupleId: null, photo: null));

      await expectLater(
        repository.upload(bytes: bytes, contentType: 'image/jpeg'),
        throwsA(isA<LocalizedException>()),
      );

      verifyNever(
        () => storageService.upload(
          bucket: any(named: 'bucket'),
          bytes: any(named: 'bytes'),
          contentType: any(named: 'contentType'),
          name: any(named: 'name'),
        ),
      );
    });

    test('rejects a content type the bucket does not accept', () async {
      await expectLater(
        repository.upload(bytes: bytes, contentType: 'application/pdf'),
        throwsA(isA<LocalizedException>()),
      );

      verifyNever(
        () => storageService.upload(
          bucket: any(named: 'bucket'),
          bytes: any(named: 'bytes'),
          contentType: any(named: 'contentType'),
          name: any(named: 'name'),
        ),
      );
    });

    test('rejects bytes that cannot be decoded as an image', () async {
      repository = CouplePhotoRepository(
        dataSource: dataSource,
        storageService: storageService,
        authenticationRepository: authenticationRepository,
        widgetDataService: widgetDataService,
        resizePhoto: (_) async => null,
        downloadPhoto: (_) async => bytes,
      );

      await expectLater(
        repository.upload(bytes: bytes, contentType: 'image/jpeg'),
        throwsA(isA<LocalizedException>()),
      );
      verifyNever(
        () => storageService.upload(
          bucket: any(named: 'bucket'),
          bytes: any(named: 'bytes'),
          contentType: any(named: 'contentType'),
          name: any(named: 'name'),
        ),
      );
    });

    test('removes the new file when the row write fails', () async {
      when(
        () => dataSource.update(
          coupleId: any(named: 'coupleId'),
          fileId: any(named: 'fileId'),
        ),
      ).thenThrow(Exception('row failed'));

      await expectLater(
        repository.upload(bytes: bytes, contentType: 'image/jpeg'),
        throwsA(isA<LocalizedException>()),
      );

      verify(() => storageService.remove(fileId: 'file-new')).called(1);
      verifyNever(() => storageService.remove(fileId: 'file-old'));
    });
  });

  group('syncWidgetCache', () {
    setUp(() {
      when(
        () => storageService.signedUrl(
          fileId: any(named: 'fileId'),
          seconds: any(named: 'seconds'),
        ),
      ).thenAnswer((_) async => 'https://example.test/photo.jpg');
    });

    test('downloads and caches the photo for a partner without a local copy', () async {
      var downloaded = false;
      repository = CouplePhotoRepository(
        dataSource: dataSource,
        storageService: storageService,
        authenticationRepository: authenticationRepository,
        widgetDataService: widgetDataService,
        resizePhoto: (bytes) async => bytes,
        downloadPhoto: (_) async {
          downloaded = true;
          return bytes;
        },
      );

      final hasPhoto = await repository.syncWidgetCache(cacheAllowed: true);

      expect(hasPhoto, isTrue);
      expect(downloaded, isTrue);
      verify(() => widgetDataService.cacheCouplePhoto(bytes, 'png', updatedAt: existing.updatedAt))
          .called(1);
    });

    test('keeps the local copy when the updated_at marker still matches', () async {
      when(() => widgetDataService.readCachedPhotoPath(hasPlus: any(named: 'hasPlus')))
          .thenAnswer((_) async => '/tmp/mingo_widget_photo.png');
      when(() => widgetDataService.readCachedPhotoUpdatedAt())
          .thenAnswer((_) async => existing.updatedAt.toIso8601String());

      final hasPhoto = await repository.syncWidgetCache(cacheAllowed: true);

      expect(hasPhoto, isTrue);
      verifyNever(
        () => storageService.signedUrl(
          fileId: any(named: 'fileId'),
          seconds: any(named: 'seconds'),
        ),
      );
      verifyNever(
        () => widgetDataService.cacheCouplePhoto(any(), any(), updatedAt: any(named: 'updatedAt')),
      );
    });

    test('downloads again when the row updated_at changes', () async {
      when(() => widgetDataService.readCachedPhotoPath(hasPlus: any(named: 'hasPlus')))
          .thenAnswer((_) async => '/tmp/mingo_widget_photo.png');
      when(() => widgetDataService.readCachedPhotoUpdatedAt())
          .thenAnswer((_) async => DateTime.utc(2026, 11, 10).toIso8601String());

      final hasPhoto = await repository.syncWidgetCache(cacheAllowed: true);

      expect(hasPhoto, isTrue);
      verify(() => storageService.signedUrl(fileId: 'file-old')).called(1);
      verify(() => widgetDataService.cacheCouplePhoto(bytes, 'png', updatedAt: existing.updatedAt))
          .called(1);
    });

    test('falls back to the local copy when the signed URL fails', () async {
      when(() => widgetDataService.readCachedPhotoPath(hasPlus: any(named: 'hasPlus')))
          .thenAnswer((_) async => '/tmp/mingo_widget_photo.png');
      when(() => widgetDataService.readCachedPhotoUpdatedAt())
          .thenAnswer((_) async => DateTime.utc(2026, 11, 10).toIso8601String());
      when(
        () => storageService.signedUrl(
          fileId: any(named: 'fileId'),
          seconds: any(named: 'seconds'),
        ),
      ).thenThrow(FileStorageException(Exception('signed url failed')));

      final hasPhoto = await repository.syncWidgetCache(cacheAllowed: true);

      expect(hasPhoto, isTrue);
      verifyNever(
        () => widgetDataService.cacheCouplePhoto(any(), any(), updatedAt: any(named: 'updatedAt')),
      );
    });

    test('deletes the cache and reports the row when caching is not allowed', () async {
      final hasPhoto = await repository.syncWidgetCache(cacheAllowed: false);

      expect(hasPhoto, isTrue);
      verify(() => widgetDataService.clearCouplePhoto()).called(1);
      verifyNever(
        () => storageService.signedUrl(
          fileId: any(named: 'fileId'),
          seconds: any(named: 'seconds'),
        ),
      );
    });
  });

  group('remove', () {
    test('deletes the row, the file, and the cached photo', () async {
      await repository.remove();

      verify(() => dataSource.delete('couple-1')).called(1);
      verify(() => storageService.remove(fileId: 'file-old')).called(1);
      verify(() => widgetDataService.clearCouplePhoto()).called(1);
    });

    test('fails loudly when the delete touches no rows', () async {
      when(() => dataSource.delete(any())).thenAnswer((_) async => 0);

      await expectLater(repository.remove(), throwsA(isA<LocalizedException>()));
      verifyNever(() => widgetDataService.clearCouplePhoto());
    });
  });

  group('getPhoto', () {
    test('adds a short-lived signed URL to the row', () async {
      when(
        () => storageService.signedUrl(
          fileId: any(named: 'fileId'),
          seconds: any(named: 'seconds'),
        ),
      ).thenAnswer((_) async => 'https://example.test/photo.jpg');

      final photo = await repository.getPhoto();

      expect(photo?.fileId, 'file-old');
      expect(photo?.url, 'https://example.test/photo.jpg');
    });

    test('keeps the row when the signed URL fails', () async {
      when(
        () => storageService.signedUrl(
          fileId: any(named: 'fileId'),
          seconds: any(named: 'seconds'),
        ),
      ).thenThrow(FileStorageException(Exception('signed url failed')));

      final photo = await repository.getPhoto();

      expect(photo?.fileId, 'file-old');
      expect(photo?.url, isNull);
    });
  });
}
