import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:storage_service/storage_service.dart';

void main() {
  const base = 'https://storage.test/v1';

  test('upload sends the bucket and returns the file id', () async {
    final client = MockClient((request) async {
      expect(request.method, 'POST');
      expect(request.url.toString(), '$base/files');
      expect(request.headers['authorization'], 'Bearer access');

      return http.Response(
        jsonEncode({
          'processedFiles': [
            {'id': 'file-1', 'bucketId': 'avatars'},
          ],
        }),
        201,
      );
    });

    final id = await StorageService(
      baseUrl: base,
      tokenCallback: () async => 'access',
      httpClient: client,
    ).upload(bucket: 'avatars', bytes: Uint8List.fromList([1, 2, 3]), contentType: 'image/png');

    expect(id, 'file-1');
  });

  test('a failed upload is a FileStorageException', () {
    final client = MockClient((_) async => http.Response(jsonEncode({'message': 'nope'}), 500));

    expect(
      StorageService(
        baseUrl: base,
        httpClient: client,
      ).upload(bucket: 'avatars', bytes: Uint8List(1), contentType: 'image/png'),
      throwsA(isA<FileStorageException>()),
    );
  });

  test('signedUrl returns the presigned url', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), '$base/files/file-1/presignedurl');
      expect(request.headers['authorization'], 'Bearer access');

      return http.Response(jsonEncode({'url': 'https://x/y'}), 200);
    });

    expect(
      await StorageService(
        baseUrl: base,
        tokenCallback: () async => 'access',
        httpClient: client,
      ).signedUrl(fileId: 'file-1'),
      'https://x/y',
    );
  });

  test('remove deletes the file and treats a missing file as done', () async {
    var calls = 0;
    final client = MockClient((request) async {
      calls++;
      expect(request.method, 'DELETE');
      expect(request.url.toString(), '$base/files/file-1');

      return http.Response('', 404);
    });

    await StorageService(baseUrl: base, httpClient: client).remove(fileId: 'file-1');
    expect(calls, 1);
  });

  test('download returns the bytes behind an absolute url', () async {
    final client = MockClient((request) async {
      expect(request.url, Uri.parse('https://x/y'));

      return http.Response.bytes([1, 2, 3], 200);
    });

    expect(await StorageService(httpClient: client).download('https://x/y'), [1, 2, 3]);
  });

  test('a download outside 2xx is a FileStorageException', () {
    final client = MockClient((_) async => http.Response('missing', 404));

    expect(
      StorageService(httpClient: client).download('https://x/y'),
      throwsA(isA<FileStorageException>()),
    );
  });
}
