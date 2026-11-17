import 'dart:async';
import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:graphql_query_compress/graphql_query_compress.dart';
import 'package:network/src/graphql/links/link_chain.dart';

class GQLClient._(final GraphQLClient _client) {
  factory({
    required String serverUrl,
    FutureOr<String?> Function()? tokenCallback,
    Future<bool> Function()? refreshSession,
    Map<String, String> defaultHeaders = const {},
    Duration queryTimeout = const Duration(seconds: 10),
    Duration mutationTimeout = const Duration(seconds: 30),
  }) {
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
      ),
    );

    return GQLClient._(
      GraphQLClient(
        cache: GraphQLCache(),
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
    );
  }

  /// Wraps an existing [client], so a test can supply its own link.
  factory withClient(GraphQLClient client) => GQLClient._(client);

  final Set<ObservableQuery<Object?>> _watched = {};

  Future<QueryResult<T>> query<T>(QueryOptions<T> options) {
    return _client.query(options);
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
