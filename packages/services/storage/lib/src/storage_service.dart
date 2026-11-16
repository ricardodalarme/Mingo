import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:storage_service/src/file_storage_exception.dart';

/// Stores private files in Nhost Storage and reads them back through short-lived URLs.
class StorageService({
  final String? baseUrl,
  final Future<String?> Function()? tokenCallback,
  final http.Client? httpClient,
}) {
  final http.Client _client = httpClient ?? http.Client();

  String get _baseUrl {
    final url = baseUrl ?? '';
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  Future<Map<String, String>> _headers() async {
    final token = await tokenCallback?.call();

    return {if (token != null && token.isNotEmpty) 'authorization': 'Bearer $token'};
  }

  /// Uploads [bytes] to [bucket] and returns the id of the stored file.
  Future<String> upload({
    required String bucket,
    required Uint8List bytes,
    required String contentType,
    String name = 'file',
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse('$_baseUrl/files'))
        ..headers.addAll(await _headers())
        ..fields['bucket-id'] = bucket
        ..files.add(
          http.MultipartFile.fromBytes(
            'file[]',
            bytes,
            filename: name,
            contentType: _mediaType(contentType),
          ),
        );
      final response = await http.Response.fromStream(await _client.send(request));
      final body = _decode(response);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('${body['message'] ?? 'upload failed with ${response.statusCode}'}');
      }
      final files = body['processedFiles'] as List<dynamic>? ?? const [];

      return (files.first as Map<String, Object?>)['id']! as String;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    }
  }

  /// A URL that lets the file with [fileId] be read for [seconds] seconds.
  Future<String> signedUrl({required String fileId, int seconds = 300}) async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/files/$fileId/presignedurl'),
        headers: await _headers(),
      );
      final body = _decode(response);
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('${body['message'] ?? 'signed url failed with ${response.statusCode}'}');
      }

      return body['url']! as String;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    }
  }

  /// Removes the file with [fileId]; a file that is already gone is not an error.
  Future<void> remove({required String fileId}) async {
    try {
      final response = await _client.delete(
        Uri.parse('$_baseUrl/files/$fileId'),
        headers: await _headers(),
      );
      if (response.statusCode == 404) return;
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('delete failed with ${response.statusCode}');
      }
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    }
  }

  /// The bytes behind an absolute [url], such as a signed read URL.
  Future<Uint8List> download(String url) async {
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('download failed with ${response.statusCode}');
      }

      return response.bodyBytes;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(FileStorageException(error), stackTrace);
    }
  }

  Map<String, Object?> _decode(http.Response response) {
    if (response.body.isEmpty) return const {};
    final value = jsonDecode(response.body);
    if (value is Map<String, Object?>) return value;
    if (value is Map) return Map<String, Object?>.from(value);

    return {'message': '$value'};
  }

  MediaType _mediaType(String value) {
    final parts = value.split('/');

    return MediaType(parts.first, parts.length > 1 ? parts[1] : 'octet-stream');
  }
}
