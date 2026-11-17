import 'dart:async';

import 'package:graphql/client.dart';
import 'package:network/src/graphql/links/token_link.dart';
import 'package:test/test.dart';

import '../../../helpers/link_helpers.dart';

void main() {
  late List<Request> sent;
  late FakeSession session;

  setUp(() {
    sent = [];
    session = FakeSession(current: 'old');
  });

  Link build({required Stream<Response> Function(int call) handler}) => Link.from([
    TokenLink(tokenCallback: session.token, refreshSession: session.renew),
    terminating((request) {
      sent.add(request);

      return handler(sent.length);
    }),
  ]);

  Stream<Response> invalidJwt() => Stream.value(
    const Response(
      response: {},
      errors: [
        GraphQLError(
          message: 'Could not verify JWT: JWTExpired',
          extensions: {'code': 'invalid-jwt'},
        ),
      ],
    ),
  );

  test('sends the access token as a bearer token', () async {
    final link = build(handler: (_) => Stream.value(okResponse()));

    await link.request(queryRequest()).first;

    expect(authorizationOf(sent.single), 'Bearer old');
  });

  test('keeps the headers the request already has', () async {
    final link = build(handler: (_) => Stream.value(okResponse()));
    final request = queryRequest().updateContextEntry<HttpLinkHeaders>(
      (_) => const HttpLinkHeaders(headers: {'x-custom': '1'}),
    );

    await link.request(request).first;

    expect(sent.single.context.entry<HttpLinkHeaders>()?.headers['x-custom'], '1');
    expect(authorizationOf(sent.single), 'Bearer old');
  });

  test('sends no authorization header when signed out, and never renews', () async {
    session.current = null;
    final link = build(handler: (_) => Stream.error(httpError(401)));

    expect(await failureOf(link.request(queryRequest())), isA<HttpLinkServerException>());

    expect(authorizationOf(sent.single), isNull);
    expect(session.renewals, isEmpty);
  });

  group('when the server answers 401', () {
    test('renews the session and sends the request again with the new token', () async {
      final link = build(
        handler: (call) => call == 1 ? Stream.error(httpError(401)) : Stream.value(okResponse()),
      );
      session.onRenew = (_) async {
        session.current = 'new';

        return true;
      };

      final response = await link.request(queryRequest()).first;

      expect(response.data, {'a': 1});
      expect(session.renewals, ['old']);
      expect(sent.map(authorizationOf), ['Bearer old', 'Bearer new']);
    });

    test('also repeats a mutation, since a rejected token means it never ran', () async {
      final link = build(
        handler: (call) => call == 1 ? Stream.error(httpError(401)) : Stream.value(okResponse()),
      );

      await link.request(mutationRequest()).first;

      expect(sent, hasLength(2));
    });

    test('returns the 401 when the session cannot be renewed', () async {
      session.onRenew = (_) async => false;
      final link = build(handler: (_) => Stream.error(httpError(401)));

      expect(await failureOf(link.request(queryRequest())), isA<HttpLinkServerException>());
      expect(sent, hasLength(1));
    });

    test('does not loop when the repeated request is rejected again', () async {
      final link = build(handler: (_) => Stream.error(httpError(401)));

      final error = await failureOf(link.request(queryRequest()));

      expect((error! as HttpLinkServerException).statusCode, 401);
      expect(sent, hasLength(2));
      expect(session.renewals, hasLength(1));
    });

    test('passes any other status on without renewing', () async {
      final link = build(handler: (_) => Stream.error(httpError(500)));

      final error = await failureOf(link.request(queryRequest()));

      expect((error! as HttpLinkServerException).statusCode, 500);
      expect(session.renewals, isEmpty);
    });
  });

  group('when the engine reports invalid-jwt with HTTP 200', () {
    test('renews the session and sends the request again', () async {
      final link = build(handler: (call) => call == 1 ? invalidJwt() : Stream.value(okResponse()));

      final response = await link.request(queryRequest()).first;

      expect(response.data, {'a': 1});
      expect(session.renewals, ['old']);
      expect(sent, hasLength(2));
    });

    test('returns the error when the session cannot be renewed', () async {
      session.onRenew = (_) async => false;
      final link = build(handler: (_) => invalidJwt());

      final response = await link.request(queryRequest()).first;

      expect(response.errors, isNotEmpty);
      expect(sent, hasLength(1));
    });

    test('does not loop when the repeated request is still invalid', () async {
      final link = build(handler: (_) => invalidJwt());

      final response = await link.request(queryRequest()).first;

      expect(response.errors, isNotEmpty);
      expect(sent, hasLength(2));
      expect(session.renewals, hasLength(1));
    });

    test('leaves other GraphQL errors alone', () async {
      final link = build(
        handler: (_) => Stream.value(
          const Response(
            response: {},
            errors: [GraphQLError(message: 'NOT_PAIRED')],
          ),
        ),
      );

      final response = await link.request(queryRequest()).first;

      expect(response.errors, isNotEmpty);
      expect(session.renewals, isEmpty);
      expect(sent, hasLength(1));
    });
  });
}
