import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:network/src/rest/interceptors/token_interceptor.dart';

class RestClient._(final Dio _client) {
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

    return RestClient._(client);
  }

  Future<Response<T>> get<T>(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _client.get(path, queryParameters: queryParameters, data: data);
  }

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

  Future<Response<T>> put<T>(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _client.put(path, queryParameters: queryParameters, data: data);
  }

  Future<Response<T>> patch<T>(String path, {Object? data, Map<String, dynamic>? queryParameters}) {
    return _client.patch(path, queryParameters: queryParameters, data: data);
  }

  Future<Response<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _client.delete(path, queryParameters: queryParameters, data: data);
  }

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
