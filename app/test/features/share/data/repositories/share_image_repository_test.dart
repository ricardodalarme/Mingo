import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:app/features/share/data/repositories/share_image_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_service/share_service.dart';

class _FakeShareService(final Directory directory) extends ShareService {
  bool failsToWrite = false;
  String? sharedPath;
  String? mimeType;
  Uint8List? sharedBytes;

  @override
  Future<File> writeTemporaryFile({required String fileName, required Uint8List bytes}) {
    if (failsToWrite) throw const ShareException('no directory');

    return File('${directory.path}/$fileName').writeAsBytes(bytes, flush: true);
  }

  @override
  Future<void> shareFile({
    required File file,
    required String mimeType,
    String? text,
    Rect? sharePositionOrigin,
  }) async {
    sharedPath = file.path;
    this.mimeType = mimeType;
    sharedBytes = file.readAsBytesSync();
  }

  @override
  Future<void> deleteTemporaryFile(File file) async {
    if (file.existsSync()) file.deleteSync();
  }
}

void main() {
  late Directory directory;
  late _FakeShareService shareService;
  late ShareImageRepository repository;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('share_image_test');
    shareService = _FakeShareService(directory);
    repository = ShareImageRepository(shareService: shareService);
  });

  tearDown(() => directory.deleteSync(recursive: true));

  test('writes the png to a temporary file, shares it and removes it', () async {
    final png = Uint8List.fromList([0x89, 0x50, 0x4e, 0x47]);

    await repository.share(png);

    expect(shareService.sharedPath, isNotNull);
    expect(shareService.mimeType, 'image/png');
    expect(shareService.sharedBytes, png);
    expect(File(shareService.sharedPath!).existsSync(), isFalse);
  });

  test('rethrows a storage failure so the sheet can say it did not work', () {
    shareService.failsToWrite = true;

    expect(repository.share(Uint8List.fromList([1])), throwsA(isA<ShareException>()));
  });
}
