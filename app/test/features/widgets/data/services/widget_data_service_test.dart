import 'dart:io';
import 'dart:typed_data';

import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/data/services/widget_data_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Map<String, String?> memoryStore;
  late List<String?> updatedIOSKinds;
  late List<String?> updatedAndroidProviders;
  late List<String?> scheduledMidnightProviders;
  late List<String?> cancelledMidnightProviders;
  late String? configuredGroupId;
  late Directory tempDir;
  late WidgetDataService service;

  setUp(() {
    memoryStore = <String, String?>{};
    updatedIOSKinds = <String?>[];
    updatedAndroidProviders = <String?>[];
    scheduledMidnightProviders = <String?>[];
    cancelledMidnightProviders = <String?>[];
    configuredGroupId = null;
    tempDir = Directory.systemTemp.createTempSync('widget_photo_test');
    addTearDown(() {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    });

    final driver = WidgetStoreDriver(
      setAppGroupIdFn: (groupId) async {
        configuredGroupId = groupId;
        return true;
      },
      saveStringFn: (id, data) async {
        memoryStore[id] = data;
        return true;
      },
      getStringFn: (id) async => memoryStore[id],
      updateWidgetFn: ({iOSName, androidName, qualifiedAndroidName}) async {
        updatedIOSKinds.add(iOSName);
        updatedAndroidProviders.add(qualifiedAndroidName);
        return true;
      },
      scheduleWidgetUpdatesFn: (dates, {name, androidName, qualifiedAndroidName}) async {
        if (dates.isNotEmpty) {
          scheduledMidnightProviders.add(qualifiedAndroidName);
        }
      },
      cancelScheduledWidgetUpdatesFn: ({name, androidName, qualifiedAndroidName}) async {
        cancelledMidnightProviders.add(qualifiedAndroidName);
      },
      appGroupPathFn: () async => tempDir.path,
      applicationSupportDirectoryFn: () async => tempDir,
    );

    service = WidgetDataService(driver: driver);
  });

  test('writePayload configures App Group, sanitizes data, reloads families, and schedules midnight updates', () async {
    final now = DateTime.utc(2026, 11, 11, 12);
    final payload = WidgetPayload.fake();

    final written = await service.writePayload(payload, referenceNow: now);
    final stored = await service.readStoredPayload();

    expect(configuredGroupId, WidgetDataService.appGroupId);
    expect(stored, isNotNull);
    expect(stored!.partnerName, 'Marina');
    expect(stored.nextDateTitle, 'Aniversário');
    expect(written.updatedAt, now.toIso8601String());
    expect(updatedIOSKinds, contains('MingoOwnSmallWidget'));
    expect(updatedIOSKinds, contains('MingoLockScreenWidget'));
    expect(
      updatedAndroidProviders,
      contains('dev.dalarme.mingo.widgets.MingoOwnSmallWidgetProvider'),
    );
    expect(
      scheduledMidnightProviders,
      containsAll([
        'dev.dalarme.mingo.widgets.MingoCoupleCounterWidgetProvider',
        'dev.dalarme.mingo.widgets.MingoCouplePhotosWidgetProvider',
        'dev.dalarme.mingo.widgets.MingoCardEncounterWidgetProvider',
      ]),
    );
  });

  test(
    'clearForSignOut overwrites payload with neutral signed-out state and cancels midnight alarms',
    () async {
      await service.writePayload(WidgetPayload.fake());
      cancelledMidnightProviders.clear();

      final cleared = await service.clearForSignOut(referenceNow: DateTime.utc(2026, 11, 11, 15));
      final stored = await service.readStoredPayload();

      expect(cleared.isSignedIn, isFalse);
      expect(stored, isNotNull);
      expect(stored!.isSignedIn, isFalse);
      expect(stored.partnerName, isNull);
      expect(stored.partnerNote, isNull);
      expect(stored.nextDateTitle, isNull);
      expect(stored.unopenedCards, 0);
      expect(
        cancelledMidnightProviders,
        contains('dev.dalarme.mingo.widgets.MingoCoupleCounterWidgetProvider'),
      );
    },
  );

  test('cacheCouplePhoto writes bytes to a widget-accessible folder and stores the path', () async {
    final bytes = Uint8List.fromList([1, 2, 3, 4]);

    final path = await service.cacheCouplePhoto(bytes, 'jpg');

    expect(path, isNotNull);
    expect(path, startsWith(tempDir.path));
    expect(memoryStore[WidgetDataService.cachedPhotoStorageKey], path);
    expect(File(path!).readAsBytesSync(), bytes);
  });

  test('cacheCouplePhoto deletes the previous file when the extension changes', () async {
    final oldPath = await service.cacheCouplePhoto(Uint8List.fromList([1]), 'png');
    final newPath = await service.cacheCouplePhoto(Uint8List.fromList([2]), 'jpg');

    expect(File(oldPath!).existsSync(), isFalse);
    expect(File(newPath!).existsSync(), isTrue);
    expect(memoryStore[WidgetDataService.cachedPhotoStorageKey], newPath);
  });

  test('cacheCouplePhoto stores the row updated_at marker', () async {
    final updatedAt = DateTime.utc(2026, 11, 11, 12);

    await service.cacheCouplePhoto(Uint8List.fromList([1]), 'png', updatedAt: updatedAt);

    expect(await service.readCachedPhotoUpdatedAt(), updatedAt.toIso8601String());
  });

  test('clearCouplePhoto deletes the file and clears the stored path', () async {
    final path = await service.cacheCouplePhoto(Uint8List.fromList([1]), 'jpg');

    await service.clearCouplePhoto();

    expect(File(path!).existsSync(), isFalse);
    expect(memoryStore[WidgetDataService.cachedPhotoStorageKey], isNull);
    expect(memoryStore[WidgetDataService.cachedPhotoUpdatedAtKey], isNull);
  });

  test('readCachedPhotoPath deletes the file without Plus', () async {
    final path = await service.cacheCouplePhoto(Uint8List.fromList([1]), 'jpg');

    final resolved = await service.readCachedPhotoPath(hasPlus: false);

    expect(resolved, isNull);
    expect(File(path!).existsSync(), isFalse);
    expect(memoryStore[WidgetDataService.cachedPhotoStorageKey], isNull);
  });

  test('writePayload deletes the cached photo without Plus', () async {
    final path = await service.cacheCouplePhoto(Uint8List.fromList([1]), 'jpg');

    await service.writePayload(WidgetPayload.fake().copyWith(hasPlus: false));

    expect(File(path!).existsSync(), isFalse);
    expect(memoryStore[WidgetDataService.cachedPhotoStorageKey], isNull);
  });
}
