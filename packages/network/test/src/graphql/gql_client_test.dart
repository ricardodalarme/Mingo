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

  test('a cancelled watch is not read again after a mutation', () async {
    final subscription = client.watch(watchOptions()).listen((_) {});
    await pumpEventQueue();
    await subscription.cancel();
    final before = reads;

    await client.mutate(mutationOptions());
    await pumpEventQueue();

    expect(reads, before);
  });
}
