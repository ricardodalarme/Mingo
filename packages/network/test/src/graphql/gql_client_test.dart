import 'dart:async';

import 'package:graphql/client.dart';
import 'package:network/network.dart' hide Response;
import 'package:test/test.dart';

import '../../helpers/link_helpers.dart';

void main() {
  late int reads;
  late int value;
  late GQLClient client;

  setUp(() {
    reads = 0;
    value = 1;
    final link = terminating((request) {
      final isMutation = request.operation.operationName == 'Bump';
      if (isMutation) {
        value += 1;

        return Stream.value(okResponse(value));
      }
      reads += 1;

      return Stream.value(okResponse(value));
    });
    client = GQLClient.withClient(
      GraphQLClient(
        cache: GraphQLCache(),
        link: link,
        defaultPolicies: DefaultPolicies(
          watchQuery: Policies.safe(
            FetchPolicy.cacheAndNetwork,
            ErrorPolicy.none,
            CacheRereadPolicy.mergeOptimistic,
          ),
        ),
      ),
    );
  });

  WatchQueryOptions<Map<String, dynamic>> watchOptions() =>
      WatchQueryOptions(document: parseString('query Probe { a }'), operationName: 'Probe');

  MutationOptions<Map<String, dynamic>> mutationOptions() =>
      MutationOptions(document: parseString('mutation Bump { a }'), operationName: 'Bump');

  test('watch emits the result of the network', () async {
    final first = await client.watch(watchOptions()).first;

    expect(first.data, {'a': 1});
  });

  test('watch reads again after a successful mutation', () async {
    final results = <Object?>[];
    final subscription = client.watch(watchOptions()).listen((result) {
      results.add(result.data?['a']);
    });
    await pumpEventQueue();

    await client.mutate(mutationOptions());
    await pumpEventQueue();

    expect(results.last, 2);
    expect(reads, greaterThanOrEqualTo(2));
    await subscription.cancel();
  });

  test('a read that returns the same data does not emit again', () async {
    final results = <Object?>[];
    final subscription = client.watch(watchOptions()).listen((result) {
      results.add(result.data?['a']);
    });
    await pumpEventQueue();
    value -= 1;

    await client.mutate(mutationOptions());
    await pumpEventQueue();

    expect(results, [1]);
    expect(reads, greaterThanOrEqualTo(2));
    await subscription.cancel();
  });

  test('a cancelled watch is not read again after a mutation', () async {
    final subscription = client.watch(watchOptions()).listen((_) {});
    await pumpEventQueue();
    await subscription.cancel();
    final before = reads;

    await client.mutate(mutationOptions());
    await pumpEventQueue();

    expect(reads, before);
  });

  group('a read that cannot reach the server', () {
    late bool isOffline;
    late bool answersWithGraphQLError;
    late GQLClient reader;

    setUp(() {
      isOffline = false;
      answersWithGraphQLError = false;
      reader = GQLClient.withClient(
        GraphQLClient(
          cache: GraphQLCache(),
          link: terminating((request) {
            if (isOffline) return Stream.error(transportError());
            if (answersWithGraphQLError) {
              return Stream.value(
                const Response(
                  errors: [GraphQLError(message: 'NOT_PAIRED')],
                  response: {},
                ),
              );
            }

            return Stream.value(okResponse());
          }),
        ),
      );
    });

    QueryOptions<Map<String, dynamic>> readOptions([
      FetchPolicy policy = FetchPolicy.networkOnly,
    ]) => QueryOptions(
      document: parseString('query Probe { a }'),
      operationName: 'Probe',
      fetchPolicy: policy,
      parserFn: (json) => json,
    );

    test('is answered from the saved copy of the same query', () async {
      await reader.query(readOptions());
      isOffline = true;

      final result = await reader.query(readOptions());

      expect(result.hasException, isFalse);
      expect(result.data, {'a': 1});
      expect(result.source, QueryResultSource.cache);
    });

    test('fails as before when nothing was saved', () async {
      isOffline = true;

      final result = await reader.query(readOptions());

      expect(result.hasException, isTrue);
      expect(result.exception?.linkException, isNotNull);
    });

    test('keeps a server error, even when a copy was saved', () async {
      await reader.query(readOptions());
      answersWithGraphQLError = true;

      final result = await reader.query(readOptions());

      expect(result.hasException, isTrue);
      expect(result.exception?.graphqlErrors, isNotEmpty);
    });

    test('is answered even while a watch of the same query is open and failing', () async {
      await reader.query(readOptions());
      isOffline = true;
      final subscription = reader
          .watch(
            WatchQueryOptions<Map<String, dynamic>>(
              document: parseString('query Probe { a }'),
              operationName: 'Probe',
              fetchPolicy: FetchPolicy.cacheAndNetwork,
            ),
          )
          .listen((_) {}, onError: (Object _) {});
      await pumpEventQueue();

      final result = await reader.query(readOptions());

      expect(result.hasException, isFalse);
      expect(result.data, {'a': 1});
      expect(result.parsedData, {'a': 1});
      await subscription.cancel();
    });

    test('is not answered from the cache when the read did not ask for the network only', () async {
      isOffline = true;

      final result = await reader.query(readOptions(FetchPolicy.cacheFirst));

      expect(result.hasException, isTrue);
    });
  });
}
