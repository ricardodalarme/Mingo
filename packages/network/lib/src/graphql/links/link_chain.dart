import 'dart:async';

import 'package:graphql/client.dart';
import 'package:network/src/graphql/links/auth_refresh_link.dart';
import 'package:network/src/graphql/links/logging_link.dart';
import 'package:network/src/graphql/links/retry_link.dart';
import 'package:network/src/graphql/links/timeout_link.dart';

/// Composes the links a request passes through, outermost first: identical queries in flight are
/// shared, a failed query is retried, each attempt gets a deadline, an expired session is renewed
/// once, and the token is attached just before the [terminatingLink] sends it. Subscriptions skip
/// all of that and go through [subscriptionLink] when one is given.
Link buildGraphQLLink({
  required Link terminatingLink,
  FutureOr<String?> Function()? tokenCallback,
  Future<bool> Function()? refreshSession,
  Duration queryTimeout = const Duration(seconds: 10),
  Duration mutationTimeout = const Duration(seconds: 30),
  int maxQueryAttempts = 2,
  Duration retryDelay = const Duration(milliseconds: 400),
  Link? subscriptionLink,
}) {
  final authLink = AuthLink(
    getToken: () async {
      final accessToken = await tokenCallback?.call();
      if (accessToken == null || accessToken.isEmpty) return null;
      return 'Bearer $accessToken';
    },
  );

  final httpLink = Link.from([
    DedupeLink(shouldDedupe: (request) => request.isQuery),
    LoggingLink(),
    RetryLink(maxAttempts: maxQueryAttempts, baseDelay: retryDelay),
    TimeoutLink(queryTimeout: queryTimeout, mutationTimeout: mutationTimeout),
    if (refreshSession != null) AuthRefreshLink(refreshSession: refreshSession),
    authLink,
    terminatingLink,
  ]);

  if (subscriptionLink == null) return httpLink;

  return Link.split(
    (request) => request.isSubscription,
    Link.from([LoggingLink(), subscriptionLink]),
    httpLink,
  );
}

/// The WebSocket address of a GraphQL [serverUrl]: the same endpoint over `ws` or `wss`.
String webSocketUrlFor(String serverUrl) {
  final uri = Uri.parse(serverUrl);

  return uri.replace(scheme: uri.scheme == 'https' ? 'wss' : 'ws').toString();
}

/// Builds the WebSocket link subscriptions travel through.
///
/// The token is read again each time the socket connects, so a reconnect after a renewal carries
/// the new one. Hasura reads the session from the `headers` of the connection payload.
Link buildSubscriptionLink({
  required String webSocketUrl,
  FutureOr<String?> Function()? tokenCallback,
  Future<bool> Function()? refreshSession,
  Stream<ToggleConnectionState>? toggleConnection,
  Duration reconnectDelay = const Duration(seconds: 3),
}) {
  return WebSocketLink(
    webSocketUrl,
    subProtocol: GraphQLProtocol.graphqlTransportWs,
    config: SocketClientConfig(
      delayBetweenReconnectionAttempts: reconnectDelay,
      toggleConnection: toggleConnection,
      onConnectionLost: (code, reason) async {
        if (!_isAuthClose(code)) return null;

        final isRenewed = await refreshSession?.call() ?? false;

        return isRenewed ? Duration.zero : null;
      },
      initialPayload: () async {
        final accessToken = await tokenCallback?.call();
        if (accessToken == null || accessToken.isEmpty) return <String, dynamic>{};

        return <String, dynamic>{
          'headers': <String, String>{'Authorization': 'Bearer $accessToken'},
        };
      },
    ),
  );
}

/// Whether a closed socket was refused for its token, which a renewed session fixes.
bool _isAuthClose(int? code) => code == 4401 || code == 4403;
