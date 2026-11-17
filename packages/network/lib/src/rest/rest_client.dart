import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:network/src/rest/interceptors/token_interceptor.dart';

abstract interface class RestClient() {
  Future<Response<T>> get<T>(String path, {Object? data, Map<String, dynamic>? queryParameters});
  Future<Response<T>> put<T>(String path, {Object? data, Map<String, dynamic>? queryParameters});
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });
  Future<Response<T>> patch<T>(String path, {Object? data, Map<String, dynamic>? queryParameters});
  Future<Response<T>> delete<T>(String path, {Object? data, Map<String, dynamic>? queryParameters});

  /// Sends a POST and yields the response body line by line as it arrives.
  ///
  /// The lines are yielded for any status code, so a caller that reads an error body can do so; closing
  /// the subscription cancels the request.
  Stream<String> postLines(String path, {Object? data, Map<String, String>? headers});
}

class const RestClientImpl._(final Dio _client) implements RestClient {
  /// A client for [baseUrl]. With [tokenCallback], each request carries the access token, and a
  /// 401 calls [refreshSession] with the refused token and, when it renews the session, sends the
  /// request again.
  factory({
    required String baseUrl,
    FutureOr<String?> Function()? tokenCallback,
    Future<bool> Function(String? rejected)? refreshSession,
    @visibleForTesting HttpClientAdapter? adapter,
  }) {
    final client = Dio(BaseOptions(baseUrl: baseUrl));
    if (adapter != null) client.httpClientAdapter = adapter;
    if (tokenCallback != null && refreshSession != null) {
      client.interceptors.add(
        TokenInterceptor(
          tokenCallback: tokenCallback,
          refreshSession: refreshSession,
          client: client,
        ),
      );
    }

    return RestClientImpl._(client);
  }

  @override
  Future<Response<T>> get<T>(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _client.get(path, queryParameters: queryParameters, data: data);
  }

  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) {
    return _client.post(
      path,
      queryParameters: queryParameters,
      data: data,
      options: Options(headers: headers),
    );
  }

  @override
  Future<Response<T>> put<T>(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _client.put(path, queryParameters: queryParameters, data: data);
  }

  @override
  Future<Response<T>> patch<T>(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _client.patch(path, queryParameters: queryParameters, data: data);
  }

  @override
  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _client.delete(path, queryParameters: queryParameters, data: data);
  }

  @override
  Stream<String> postLines(String path, {Object? data, Map<String, String>? headers}) async* {
    final cancel = CancelToken();
    try {
      final response = await _client.post<ResponseBody>(
        path,
        data: data,
        cancelToken: cancel,
        options: Options(
          responseType: ResponseType.stream,
          headers: headers,
          validateStatus: (_) => true,
        ),
      );
      yield* response.data!.stream
          .cast<List<int>>()
          .transform(utf8.decoder)
          .transform(const LineSplitter());
    } finally {
      cancel.cancel();
    }
  }
}
