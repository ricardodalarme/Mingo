import 'dart:async';

import 'package:graphql/client.dart';

/// Attaches the access token to each request, and renews the session once when the server rejects
/// it, then sends the request again with the new token.
///
/// Hasura answers an expired token with an HTTP 200 and a GraphQL `invalid-jwt` error, so the link
/// checks both the response errors and an HTTP 401. Either means the request was refused before it
/// ran, so it is safe to send again, mutations included. When the session cannot be renewed, or the
/// repeated request is rejected again, the response goes to the caller.
class TokenLink({
  required final FutureOr<String?> Function() _tokenCallback,
  required final Future<bool> Function(String? rejected) _refreshSession,
}) extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final token = await _tokenCallback();
    try {
      await for (final response in forward!(_withToken(request, token))) {
        if (token != null && _isInvalidToken(response) && await _refreshSession(token)) {
          yield* forward(_withToken(request, await _tokenCallback()));
          return;
        }
        yield response;
      }
    } on HttpLinkServerException catch (exception) {
      if (token == null || exception.statusCode != 401 || !await _refreshSession(token)) rethrow;
      yield* forward!(_withToken(request, await _tokenCallback()));
    }
  }

  Request _withToken(Request request, String? token) {
    if (token == null || token.isEmpty) return request;

    return request.updateContextEntry<HttpLinkHeaders>(
      (entry) => HttpLinkHeaders(headers: {...?entry?.headers, 'Authorization': 'Bearer $token'}),
    );
  }

  bool _isInvalidToken(Response response) =>
      response.errors?.any(
        (error) =>
            error.extensions?['code'] == 'invalid-jwt' ||
            error.message.contains('JWTExpired') ||
            error.message.contains('Could not verify JWT'),
      ) ??
      false;
}
