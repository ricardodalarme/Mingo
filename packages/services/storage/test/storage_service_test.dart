import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nhost_sdk/nhost_sdk.dart' show Session, UserSession;
import 'package:storage_service/storage_service.dart';

void main() {
  const base = 'https://storage.test/v1';
  const accessToken =
      'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyLTEiLCJleHAiOjQxMDI0NDQ4MDAsImh0dHBzOi8vaGFzdXJhLmlvL2p3dC9jbGFpbXMiOnsieC1oYXN1cmEtdXNlci1pZCI6InVzZXItMSJ9fQ.';

  UserSession session() =>
      UserSession()..session = Session(accessToken: accessToken, refreshToken: 'refresh');

  test('upload sends the bucket and returns the file id', () async {
    final client = MockClient((request) async {
      expect(request.method, 'post');
      expect(request.url.toString(), '$base/files');
      expect(request.headers['authorization'], 'Bearer $accessToken');

      return http.Response(
        jsonEncode({
          'processedFiles': [
            {
              'id': 'file-1',
              'name': 'file',
              'size': 3,
              'mimeType': 'image/png',
              'etag': 'etag',
              'createdAt': '2026-01-01T00:00:00Z',
              'bucketId': 'avatars',
            },
          ],
        }),
        201,
        headers: {'content-type': 'application/json'},
      );
    });

    final id = await StorageService(
      baseUrl: base,
      session: session(),
      httpClient: client,
    ).upload(bucket: 'avatars', bytes: Uint8List.fromList([1, 2, 3]), contentType: 'image/png');

    expect(id, 'file-1');
  });

  test('a failed upload is a FileStorageException', () {
    final client = MockClient((_) async => http.Response(jsonEncode({'message': 'nope'}), 500));

    expect(
      StorageService(
        baseUrl: base,
        session: session(),
        httpClient: client,
      ).upload(bucket: 'avatars', bytes: Uint8List(1), contentType: 'image/png'),
      throwsA(isA<FileStorageException>()),
    );
  });

  test('signedUrl returns the presigned url', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(), '$base/files/file-1/presignedurl');
      expect(request.headers['authorization'], 'Bearer $accessToken');

      return http.Response(
        jsonEncode({'url': 'https://x/y', 'expiration': 300}),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    expect(
      await StorageService(
        baseUrl: base,
        session: session(),
        httpClient: client,
      ).signedUrl(fileId: 'file-1'),
      'https://x/y',
    );
  });

  test('a signed url is cached for the next read', () async {
    var calls = 0;
    final client = MockClient((_) async {
      calls++;
      return http.Response(
        jsonEncode({'url': 'https://x/y', 'expiration': 300}),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    final storage = StorageService(baseUrl: base, session: session(), httpClient: client);

    expect(await storage.signedUrl(fileId: 'file-1'), 'https://x/y');
    expect(await storage.signedUrl(fileId: 'file-1'), 'https://x/y');
    expect(calls, 1);
  });

  test('remove deletes the file and treats a missing file as done', () async {
    var calls = 0;
    final client = MockClient((request) async {
      calls++;
      expect(request.method, 'delete');
      expect(request.url.toString(), '$base/files/file-1');

      return http.Response('', 404);
    });

    await StorageService(
      baseUrl: base,
      session: session(),
      httpClient: client,
    ).remove(fileId: 'file-1');
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
