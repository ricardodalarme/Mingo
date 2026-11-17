import 'dart:async';

import 'package:graphql/client.dart';
import 'package:logger/logger.dart';
import 'package:network/src/graphql/links/logging_link.dart';
import 'package:network/src/graphql/links/timeout_link.dart';
import 'package:test/test.dart';

import '../../../helpers/link_helpers.dart';

/// Keeps what the link logs, telling a warning from a debug line.
class _FakeLogger() implements Logger {
  final List<({String message, bool isProblem})> lines = [];

  @override
  void debug(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      lines.add((message: message.toString(), isProblem: false));

  @override
  void warning(dynamic message, {Object? error, StackTrace? stackTrace}) =>
      lines.add((message: message.toString(), isProblem: true));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeLogger logger;
  late List<({String message, bool isProblem})> lines;

  setUp(() {
    logger = _FakeLogger();
    lines = logger.lines;
  });

  Link build(
    Stream<Response> Function(Request request) handler, {
    Duration slowAfter = const Duration(hours: 1),
  }) => Link.from([LoggingLink(logger: logger, slowAfter: slowAfter), terminating(handler)]);

  Future<void> run(Link link, Request request) async {
    try {
      await link.request(request).toList();
    } on Object {
      // The failure is what the test reads from the log.
    }
  }

  List<String> messages() => [for (final line in lines) line.message];

  test('a query that went well is logged with its name and time', () async {
    await run(build((_) => Stream.value(okResponse())), queryRequest());

    expect(lines, hasLength(1));
    expect(lines.single.message, matches(RegExp(r'^query Probe ok \d+ms$')));
    expect(lines.single.isProblem, isFalse);
  });

  test('a mutation says so', () async {
    await run(build((_) => Stream.value(okResponse())), mutationRequest());

    expect(lines.single.message, startsWith('mutation Probe ok '));
  });

  test('a slow call is a warning, not a debug line', () async {
    final link = build((_) => Stream.value(okResponse()), slowAfter: Duration.zero);

    await run(link, queryRequest());

    expect(lines.single.message, matches(RegExp(r'^query Probe slow \d+ms$')));
    expect(lines.single.isProblem, isTrue);
  });

  test('a GraphQL error is logged with its stable code and passed on', () async {
    final link = build(
      (_) => Stream.value(
        const Response(
          errors: [GraphQLError(message: 'Check constraint violation. FREE_LIMIT_REACHED')],
          response: {},
        ),
      ),
    );

    final responses = await link.request(mutationRequest()).toList();

    expect(responses.single.errors, isNotEmpty);
    expect(
      lines.single.message,
      matches(RegExp(r'^mutation Probe failed \d+ms FREE_LIMIT_REACHED$')),
    );
    expect(lines.single.isProblem, isTrue);
  });

  test('an error with no stable code is logged by the code the server attached', () async {
    final link = build(
      (_) => Stream.value(
        const Response(
          errors: [
            GraphQLError(
              message: 'Permission denied for table slips with id 123',
              extensions: {'code': 'access-denied'},
            ),
          ],
          response: {},
        ),
      ),
    );

    await run(link, queryRequest());

    expect(lines.single.message, endsWith(' access-denied'));
  });

  test('an error with no code at all is logged as unknown, never as its text', () async {
    final link = build(
      (_) => Stream.value(
        const Response(
          errors: [GraphQLError(message: 'duplicate key value (a-secret-body)')],
          response: {},
        ),
      ),
    );

    await run(link, queryRequest());

    expect(lines.single.message, endsWith(' UNKNOWN'));
    expect(messages().join(), isNot(contains('secret')));
  });

  test('a request that never got an answer is logged as a network failure', () async {
    await run(build((_) => Stream.error(transportError())), queryRequest());

    expect(lines.single.message, matches(RegExp(r'^query Probe failed \d+ms NETWORK$')));
    expect(lines.single.isProblem, isTrue);
  });

  test('a request that timed out is logged as a timeout', () async {
    await run(
      build((_) => Stream.error(const RequestTimeoutException(Duration(seconds: 10)))),
      queryRequest(),
    );

    expect(lines.single.message, endsWith(' TIMEOUT'));
  });

  test('a failed call is logged once even when the stream then ends', () async {
    await run(build((_) => Stream.error(transportError())), queryRequest());

    expect(lines, hasLength(1));
  });

  test('variables and data never reach the log', () async {
    await run(
      build((_) => Stream.value(okResponse('private-text'))),
      queryRequest({'body': 'what I wrote'}),
    );

    final text = messages().join();
    expect(text, isNot(contains('what I wrote')));
    expect(text, isNot(contains('private-text')));
  });

  group('subscriptions', () {
    test('log when they start and end, not for each event', () async {
      await run(
        build((_) => Stream.fromIterable([okResponse(), okResponse(2), okResponse(3)])),
        subscriptionRequest(),
      );

      expect(messages().first, 'subscription Probe started');
      expect(messages().last, matches(RegExp(r'^subscription Probe ended \d+ms$')));
      expect(lines, hasLength(2));
    });

    test('log a failed subscription as a warning', () async {
      await run(build((_) => Stream.error(transportError())), subscriptionRequest());

      expect(lines.last.message, matches(RegExp(r'^subscription Probe failed \d+ms NETWORK$')));
      expect(lines.last.isProblem, isTrue);
    });
  });
}
