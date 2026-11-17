import 'dart:async';

import 'package:graphql/client.dart';
import 'package:logger/logger.dart';
import 'package:network/src/graphql/links/link_chain.dart';
import 'package:network/src/graphql/links/timeout_link.dart';
import 'package:test/test.dart';

import '../../../helpers/link_helpers.dart';

void main() {
  late List<Request> sent;

  setUp(() => sent = []);

  Link build({
    required Stream<Response> Function(int call) handler,
    FutureOr<String?> Function()? tokenCallback,
    Future<bool> Function(String? rejected)? refreshSession,
    Duration queryTimeout = const Duration(milliseconds: 60),
    Duration mutationTimeout = const Duration(milliseconds: 200),
  }) => buildGraphQLLink(
    terminatingLink: terminating((request) {
      sent.add(request);

      return handler(sent.length);
    }),
    tokenCallback: tokenCallback,
    refreshSession: refreshSession,
    queryTimeout: queryTimeout,
    mutationTimeout: mutationTimeout,
    retryDelay: Duration.zero,
  );

  Stream<Response> slow(Duration delay) => Future<Response>.delayed(delay, okResponse).asStream();

  String? authorization(Request request) =>
      request.context.entry<HttpLinkHeaders>()?.headers['Authorization'];

  group('dedupe', () {
    test('shares one request between identical queries in flight, even with a token', () async {
      final link = build(
        handler: (_) => slow(const Duration(milliseconds: 20)),
        tokenCallback: () => 'abc',
        refreshSession: (_) async => true,
      );

      await Future.wait([link.request(queryRequest()).first, link.request(queryRequest()).first]);

      expect(sent, hasLength(1));
    });

    test('keeps queries with different variables apart', () async {
      final link = build(handler: (_) => slow(const Duration(milliseconds: 20)));

      await Future.wait([
        link.request(queryRequest({'id': 1})).first,
        link.request(queryRequest({'id': 2})).first,
      ]);

      expect(sent, hasLength(2));
    });

    test('never merges mutations, even identical ones', () async {
      final link = build(handler: (_) => slow(const Duration(milliseconds: 20)));

      await Future.wait([
        link.request(mutationRequest()).first,
        link.request(mutationRequest()).first,
      ]);

      expect(sent, hasLength(2));
    });
  });

  test('a reload after the first request finished goes to the network again', () async {
    final link = build(handler: (_) => Stream.value(okResponse()));

    await link.request(queryRequest()).first;
    await link.request(queryRequest()).first;

    expect(sent, hasLength(2));
  });

  group('auth', () {
    test('waits for an asynchronous token', () async {
      final link = build(
        handler: (_) => Stream.value(okResponse()),
        refreshSession: (_) async => true,
        tokenCallback: () async {
          await Future<void>.delayed(const Duration(milliseconds: 10));

          return 'late';
        },
      );

      await link.request(queryRequest()).first;

      expect(authorization(sent.single), 'Bearer late');
    });

    test('attaches the bearer token to every request', () async {
      final link = build(
        handler: (_) => Stream.value(okResponse()),
        tokenCallback: () => 'abc',
        refreshSession: (_) async => true,
      );

      await link.request(queryRequest()).first;

      expect(authorization(sent.single), 'Bearer abc');
    });

    test('sends no authorization header without a token', () async {
      final link = build(
        handler: (_) => Stream.value(okResponse()),
        tokenCallback: () => '',
        refreshSession: (_) async => true,
      );

      await link.request(queryRequest()).first;

      expect(authorization(sent.single), isNull);
    });

    test('the request sent again after a 401 carries the renewed token', () async {
      var token = 'old';
      final link = build(
        handler: (call) => call == 1 ? Stream.error(httpError(401)) : Stream.value(okResponse()),
        tokenCallback: () => token,
        refreshSession: (_) async {
          token = 'new';
          return true;
        },
      );

      await link.request(queryRequest()).first;

      expect(sent.map(authorization), ['Bearer old', 'Bearer new']);
    });
  });

  group('timeout and retry', () {
    test('retries a query that got no answer in time', () async {
      final link = build(
        handler: (call) =>
            call == 1 ? StreamController<Response>().stream : Stream.value(okResponse()),
      );

      await link.request(queryRequest()).first;

      expect(sent, hasLength(2));
    });

    test('gives up on a query that keeps timing out', () async {
      final link = build(handler: (_) => StreamController<Response>().stream);

      expect(await failureOf(link.request(queryRequest())), isA<RequestTimeoutException>());
      expect(sent, hasLength(2));
    });

    test('lets a mutation run longer than a query and does not retry it', () async {
      final link = build(handler: (_) => slow(const Duration(milliseconds: 120)));

      await link.request(mutationRequest()).first;

      expect(sent, hasLength(1));
    });

    test('fails a mutation that outlasts its limit without a second attempt', () async {
      final link = build(
        handler: (_) => StreamController<Response>().stream,
        mutationTimeout: const Duration(milliseconds: 40),
      );

      expect(await failureOf(link.request(mutationRequest())), isA<RequestTimeoutException>());
      expect(sent, hasLength(1));
    });
  });

  group('subscriptions', () {
    test('travel through the subscription link and skip the http chain', () async {
      final live = <Request>[];
      final link = buildGraphQLLink(
        terminatingLink: terminating((request) {
          sent.add(request);

          return Stream.value(okResponse());
        }),
        subscriptionLink: terminating((request) {
          live.add(request);

          return Stream.value(okResponse('live'));
        }),
      );

      final response = await link.request(subscriptionRequest()).first;

      expect(response.data, {'a': 'live'});
      expect(live, hasLength(1));
      expect(sent, isEmpty);
    });

    test('leave queries on the http chain when a subscription link is given', () async {
      final live = <Request>[];
      final link = buildGraphQLLink(
        terminatingLink: terminating((request) {
          sent.add(request);

          return Stream.value(okResponse());
        }),
        subscriptionLink: terminating((request) {
          live.add(request);

          return Stream.value(okResponse('live'));
        }),
      );

      await link.request(queryRequest()).first;

      expect(sent, hasLength(1));
      expect(live, isEmpty);
    });
  });

  group('webSocketUrlFor', () {
    test('keeps the endpoint and swaps the scheme', () {
      expect(webSocketUrlFor('https://x.graphql.nhost.run/v1'), 'wss://x.graphql.nhost.run/v1');
      expect(webSocketUrlFor('http://localhost:8080/v1/graphql'), 'ws://localhost:8080/v1/graphql');
    });
  });

  group('logging', () {
    late List<LogRecord> records;
    late StreamSubscription<LogRecord> listener;

    setUp(() {
      records = [];
      listener = Logger.records
          .where((record) => record.loggerName == 'GraphQL')
          .listen(records.add);
    });

    tearDown(() => listener.cancel());

    test(
      'a failed query on the http chain is logged once, after retries and the deadline',
      () async {
        final link = buildGraphQLLink(
          terminatingLink: terminating((request) => Stream.error(transportError())),
          queryTimeout: const Duration(milliseconds: 60),
          retryDelay: Duration.zero,
        );

        try {
          await link.request(queryRequest()).toList();
        } on Object {
          // The failure is what the test reads from the log.
        }

        expect(records, hasLength(1));
        expect(records.single.level, LogLevel.WARNING);
        expect(records.single.message, startsWith('query Probe failed '));
      },
    );

    test('a good query is a debug line', () async {
      final link = build(handler: (_) => Stream.value(okResponse()));

      await link.request(queryRequest()).toList();

      expect(records.single.level, LogLevel.FINE);
      expect(records.single.message, startsWith('query Probe ok '));
    });

    test('a subscription is logged when it starts', () async {
      final link = buildGraphQLLink(
        terminatingLink: terminating((request) => Stream.value(okResponse())),
        subscriptionLink: terminating((request) => Stream.value(okResponse())),
      );

      await link.request(subscriptionRequest()).toList();

      expect(records.first.message, 'subscription Probe started');
    });
  });
}
