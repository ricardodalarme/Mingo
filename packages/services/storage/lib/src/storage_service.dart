import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:nhost_sdk/nhost_sdk.dart' show ApiException, UserSession;
import 'package:nhost_storage_dart/nhost_storage_dart.dart';

import 'package:storage_service/src/file_storage_exception.dart';

/// Stores private files in Nhost Storage and reads them back through short-lived URLs.
class StorageService({
  final String? baseUrl,
  final UserSession? session,
  final http.Client? httpClient,
}) {
  late final NhostStorageClient _client = NhostStorageClient(
    url: _url,
    session: session,
    httpClient: httpClient,
  );

  final Map<String, ({String url, DateTime expiresAt})> _urls = {};

  String get _url {
    final url = baseUrl ?? '';
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  /// Uploads [bytes] to [bucket] and returns the id of the stored file.
  Future<String> upload({
    required String bucket,
    required Uint8List bytes,
    required String contentType,
    String name = 'file',
  }) async {
    try {
      final files = await _client.uploadFiles(
        files: [FileData(bytes, filename: name, contentType: contentType)],
        bucketId: bucket,
      );

      return files.first.id;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    }
  }

  /// A URL that lets the file with [fileId] be read.
  Future<String> signedUrl({required String fileId, int seconds = 300}) async {
    final cached = _urls[fileId];
    if (cached != null && DateTime.now().isBefore(cached.expiresAt)) return cached.url;
    try {
      final url = (await _client.getPresignedUrl(fileId)).url;
      _urls[fileId] = (url: url, expiresAt: DateTime.now().add(const Duration(minutes: 4)));
      return url;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    }
  }

  /// Removes the file with [fileId]; a file that is already gone is not an error.
  Future<void> remove({required String fileId}) async {
    _urls.remove(fileId);
    try {
      await _client.delete(fileId);
    } on ApiException catch (error) {
      if (error.statusCode == 404) return;
      Error.throwWithStackTrace(FileStorageException(error), StackTrace.current);
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    }
  }

  /// The bytes behind an absolute [url], such as a signed read URL.
  Future<Uint8List> download(String url) async {
    final client = httpClient ?? http.Client();
    try {
      final response = await client.get(Uri.parse(url));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('download failed with ${response.statusCode}');
      }

      return response.bodyBytes;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    } finally {
      if (httpClient == null) client.close();
    }
  }
}
