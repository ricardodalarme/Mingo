import 'dart:async';

import 'package:graphql/client.dart';

/// Renews the session once when the server rejects the token, then sends the request again.
///
/// Hasura answers an expired token with an HTTP 200 and a GraphQL `invalid-jwt` error, so the link
/// checks both the response errors and an HTTP 401. Place it outside the `AuthLink`, so the repeated
/// request reads the new token. Requests that fail at the same time share one renewal. When the
/// renewal fails, or the repeated request is rejected again, the response is returned to the caller.
class AuthRefreshLink({required final Future<bool> Function() refreshSession}) extends Link {
  Future<bool>? _refreshing;

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    var retried = false;
    try {
      await for (final response in forward!(request)) {
        if (!retried && _isInvalidToken(response)) {
          retried = true;
          if (!await _refresh()) {
            yield response;
            return;
          }
          yield* forward(request);
          return;
        }
        yield response;
      }
    } on LinkException catch (exception) {
      if (!retried && exception is HttpLinkServerException && exception.statusCode == 401) {
        if (!await _refresh()) rethrow;
        yield* forward!(request);
        return;
      }
      rethrow;
    }
  }

  bool _isInvalidToken(Response response) =>
      response.errors?.any(
        (error) =>
            error.extensions?['code'] == 'invalid-jwt' ||
            error.message.contains('JWTExpired') ||
            error.message.contains('Could not verify JWT'),
      ) ??
      false;

  Future<bool> _refresh() => _refreshing ??= _renew().whenComplete(() => _refreshing = null);

  Future<bool> _renew() async {
    try {
      return await refreshSession();
    } on Object {
      return false;
    }
  }
}
