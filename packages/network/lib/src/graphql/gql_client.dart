import 'dart:async';
import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:graphql_query_compress/graphql_query_compress.dart';
import 'package:logger/logger.dart';
import 'package:network/src/graphql/links/link_chain.dart';

class GQLClient._(
  final GraphQLClient _client, [
  final StreamController<ToggleConnectionState>? _toggle,
]) {
  factory({
    required String serverUrl,
    FutureOr<String?> Function()? tokenCallback,
    Future<bool> Function()? refreshSession,
    Map<String, String> defaultHeaders = const {},
    Duration queryTimeout = const Duration(seconds: 10),
    Duration mutationTimeout = const Duration(seconds: 30),
    Store? store,
  }) {
    // ignore: close_sinks, the client lives as long as the app
    final toggle = StreamController<ToggleConnectionState>.broadcast();
    final link = buildGraphQLLink(
      terminatingLink: HttpLink(
        serverUrl,
        defaultHeaders: defaultHeaders,
        serializer: const RequestSerializerWithCompressor(),
      ),
      tokenCallback: tokenCallback,
      refreshSession: refreshSession,
      queryTimeout: queryTimeout,
      mutationTimeout: mutationTimeout,
      subscriptionLink: buildSubscriptionLink(
        webSocketUrl: webSocketUrlFor(serverUrl),
        tokenCallback: tokenCallback,
        refreshSession: refreshSession,
        toggleConnection: toggle.stream,
      ),
    );

    return GQLClient._(
      GraphQLClient(
        cache: GraphQLCache(store: store),
        link: link,
        // TimeoutLink owns the deadlines; the client's own timer completes a request twice.
        queryRequestTimeout: null,
        defaultPolicies: DefaultPolicies(
          query: Policies.safe(
            FetchPolicy.cacheAndNetwork,
            ErrorPolicy.none,
            CacheRereadPolicy.mergeOptimistic,
          ),
        ),
      ),
      toggle,
    );
  }

  /// Wraps an existing [client], so a test can supply its own link.
  factory withClient(GraphQLClient client) => GQLClient._(client);

  static final Logger _logger = Logger('GQLClient');

  final Set<ObservableQuery<Object?>> _watched = {};

  /// Runs a query. A `networkOnly` read that cannot reach the server is answered from the saved
  /// copy of the same query when there is one, and fails as it did when there is none.
  Future<QueryResult<T>> query<T>(QueryOptions<T> options) async {
    final result = await _client.query(options);
    if (options.fetchPolicy != FetchPolicy.networkOnly || !_isUnreachable(result)) return result;

    final saved = await _client.query(
      options.copyWithPolicies(
        Policies(
          fetch: FetchPolicy.cacheOnly,
          error: options.errorPolicy,
          cacheReread: options.cacheRereadPolicy,
        ),
      ),
    );
    final data = saved.data;
    if (data == null) {
      _logger.debug('${options.operationName} has no saved copy');

      return result;
    }

    _logger.info('${options.operationName} could not reach the server, answered from saved data');

    // An open watch of the same query hands back its own failed result, so the saved data is
    // returned on its own.
    return QueryResult<T>(options: options, source: QueryResultSource.cache, data: data);
  }

  bool _isUnreachable(QueryResult<Object?> result) {
    final exception = result.exception;

    return exception != null && exception.linkException != null && exception.graphqlErrors.isEmpty;
  }

  /// Runs a mutation and, when it succeeds, reads every open [watch] again so each screen that
  /// shows data the mutation may have changed catches up.
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async {
    final result = await _client.mutate(options);
    if (!result.hasException) _refetchWatched();

    return result;
  }

  /// Opens a live query that emits each time the result changes, and ends when the stream is
  /// cancelled. It runs over a WebSocket to the `serverUrl` endpoint, connected on first use.
  Stream<QueryResult<T>> subscribe<T>(SubscriptionOptions<T> options) {
    return _client.subscribe(options);
  }

  /// Opens a watched query that emits the cached result first, then the network result, and
  /// again whenever the cache entries it reads change or a mutation succeeds.
  ///
  /// Results with neither data nor an error (the empty first loading result) are skipped, and so
  /// is a result whose data equals the one before, such as the read after a mutation that changed
  /// nothing this query shows. The query closes when the stream is cancelled.
  Stream<QueryResult<T>> watch<T>(WatchQueryOptions<T> options) {
    late final ObservableQuery<T> query;
    StreamSubscription<QueryResult<T>>? subscription;
    late final StreamController<QueryResult<T>> controller;
    String? lastData;
    bool isNew(QueryResult<T> result) {
      if (result.hasException) {
        lastData = null;

        return true;
      }
      final data = jsonEncode(result.data);
      final changed = data != lastData;
      lastData = data;

      return changed;
    }

    controller = StreamController<QueryResult<T>>(
      onListen: () {
        query = _client.watchQuery(options);
        _watched.add(query);
        subscription = query.stream
            .where((result) => result.data != null || result.hasException)
            .where(isNew)
            .listen(controller.add, onError: controller.addError, onDone: controller.close);
        if (!options.fetchResults) query.fetchResults();
      },
      onCancel: () async {
        await subscription?.cancel();
        _watched.remove(query);
        await query.close();
      },
    );

    return controller.stream;
  }

  /// Closes the subscription socket and stops it reconnecting, such as while the app is in the
  /// background; the open subscriptions resume with [resumeSubscriptions].
  void pauseSubscriptions() => _toggle?.add(ToggleConnectionState.disconnect);

  /// Opens the subscription socket again after [pauseSubscriptions].
  void resumeSubscriptions() => _toggle?.add(ToggleConnectionState.connect);

  /// Drops everything cached, such as when another person signs in.
  void resetCache() {
    _client.cache.store.reset();
  }

  void _refetchWatched() {
    for (final query in List.of(_watched)) {
      if (!query.isRefetchSafe) continue;
      unawaited(query.refetch().then<void>((_) {}, onError: (Object _) {}));
    }
  }
}
