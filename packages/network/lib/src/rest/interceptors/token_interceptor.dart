import 'dart:async';

import 'package:dio/dio.dart';

/// Sends the access token with each request, and renews the session once when the server answers
/// 401, then sends the request again with the new token.
class TokenInterceptor({
  required final FutureOr<String?> Function() _tokenCallback,
  required final Future<bool> Function(String? rejected) _refreshSession,
  required final Dio _client,
}) extends Interceptor {
  static const String _sent = 'sentToken';
  static const String _isRetry = 'isTokenRetry';

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenCallback();
    if (token != null && !options.headers.containsKey('authorization')) {
      options.headers['authorization'] = 'Bearer $token';
      options.extra[_sent] = token;
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final sent = options.extra[_sent];
    if (err.response?.statusCode != 401 || sent is! String || options.extra[_isRetry] == true) {
      return handler.next(err);
    }
    if (!await _refreshSession(sent)) return handler.next(err);

    final token = await _tokenCallback();
    if (token == null) return handler.next(err);
    options.extra[_isRetry] = true;
    options.headers['authorization'] = 'Bearer $token';
    try {
      handler.resolve(await _client.fetch<Object?>(options));
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }
}
