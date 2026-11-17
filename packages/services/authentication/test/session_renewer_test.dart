import 'dart:convert';
import 'dart:io';

import 'package:authentication_service/src/session_renewer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nhost_auth_dart/nhost_auth_dart.dart';
import 'package:nhost_sdk/nhost_sdk.dart' show Session;

String _jwt(DateTime expiry, {String subject = 'user-1'}) {
  String part(Object value) => base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');

  return '${part({'alg': 'none'})}.${part({'sub': subject, 'exp': expiry.millisecondsSinceEpoch ~/ 1000})}.';
}

void main() {
  final user = {
    'id': 'user-1',
    'displayName': 'Ana',
    'locale': 'en',
    'createdAt': '2026-01-01T00:00:00Z',
    'isAnonymous': false,
    'defaultRole': 'user',
    'roles': ['user'],
    'email': 'ana@test.dev',
    'emailVerified': true,
    'phoneNumber': '',
    'phoneNumberVerified': false,
  };

  Map<String, Object?> sessionBody(
    String refresh, {
    Duration lasts = const Duration(minutes: 15),
  }) => {
    'accessToken': _jwt(DateTime.now().add(lasts)),
    'accessTokenExpiresIn': lasts.inSeconds,
    'refreshToken': refresh,
    'user': user,
  };

  http.Response json(Object body, [int status = 200]) =>
      http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json'});

  http.Response error(int status, String code) =>
      json({'error': code, 'message': code, 'status': status}, status);

  late List<String> requests;
  late int renewed;
  late int refused;

  setUp(() {
    requests = [];
    renewed = 0;
    refused = 0;
  });

  /// A renewer over a real Nhost client whose server answers each request with [answer], holding a
  /// session with [refresh] as its refresh token and an access token that lasts [lasts].
  Future<(SessionRenewer, NhostAuthClient)> start({
    required Future<http.Response> Function(http.Request request) answer,
    Duration cooldown = const Duration(seconds: 10),
    Duration lasts = const Duration(minutes: 15),
    String refresh = 'refresh-1',
  }) async {
    final auth = NhostAuthClient(
      url: 'https://auth.test/v1',
      tokenRefreshInterval: const Duration(days: 36500),
      httpClient: MockClient((request) {
        requests.add(request.url.path);

        return answer(request);
      }),
    );
    addTearDown(auth.close);
    // The Nhost client is only given a session through this setter.
    await auth.setSession(Session.fromJson(sessionBody(refresh, lasts: lasts)));
    final renewer = SessionRenewer(
      auth: auth,
      onRenewed: () async => renewed++,
      onRefused: () async => refused++,
      cooldown: cooldown,
    );
    addTearDown(renewer.cancel);
    requests.clear();

    return (renewer, auth);
  }

  Future<http.Response> renewsAs(String refresh) async => json(sessionBody(refresh));

  int tokenRequests() => requests.where((path) => path.endsWith('/token')).length;

  group('renew', () {
    test('replaces the session and tells the owner to keep it', () async {
      final (renewer, auth) = await start(answer: (_) => renewsAs('refresh-2'));

      final result = await renewer.renew();

      expect(result, isTrue);
      expect(auth.userSession.session?.refreshToken, 'refresh-2');
      expect(renewed, 1);
      expect(refused, 0);
    });

    test('cannot renew without a refresh token', () async {
      final auth = NhostAuthClient(url: 'https://auth.test/v1');
      addTearDown(auth.close);
      final renewer = SessionRenewer(
        auth: auth,
        onRenewed: () async => renewed++,
        onRefused: () async => refused++,
      );

      expect(await renewer.renew(), isFalse);
      expect(renewed, 0);
    });

    test('shares one request between callers that renew at the same time', () async {
      final (renewer, _) = await start(
        answer: (_) async {
          await Future<void>.delayed(const Duration(milliseconds: 50));

          return renewsAs('refresh-2');
        },
      );

      final results = await Future.wait([renewer.renew(), renewer.renew(), renewer.renew()]);

      expect(results, [true, true, true]);
      expect(tokenRequests(), 1);
      expect(renewed, 1);
    });

    test('sends nothing when the token that was refused is not the current one any more', () async {
      final (renewer, _) = await start(answer: (_) => renewsAs('refresh-2'));

      final result = await renewer.renew(rejected: 'an-older-token');

      expect(result, isTrue);
      expect(requests, isEmpty);
    });

    test('renews when the token that was refused is the current one', () async {
      final (renewer, auth) = await start(answer: (_) => renewsAs('refresh-2'));

      final result = await renewer.renew(rejected: auth.accessToken);

      expect(result, isTrue);
      expect(tokenRequests(), 1);
    });
  });

  group('when the server refuses the refresh token', () {
    test('asks the owner to end the session on a 401', () async {
      final (renewer, _) = await start(answer: (_) async => error(401, 'invalid-refresh-token'));

      expect(await renewer.renew(), isFalse);
      expect(refused, 1);
    });

    test('asks the owner to end the session on a 400', () async {
      final (renewer, _) = await start(answer: (_) async => error(400, 'invalid-request'));

      expect(await renewer.renew(), isFalse);
      expect(refused, 1);
    });

    test('leaves a newer session alone when an older renewal is refused late', () async {
      final (renewer, auth) = await start(
        answer: (_) async {
          await Future<void>.delayed(const Duration(milliseconds: 100));

          return error(400, 'invalid-request');
        },
      );

      final renewal = renewer.renew();
      await Future<void>.delayed(const Duration(milliseconds: 20));
      // A new sign in replaces the session while the old renewal is still waiting.
      await auth.setSession(Session.fromJson(sessionBody('refresh-new')));
      await renewal;

      expect(refused, 0);
      expect(auth.userSession.session?.refreshToken, 'refresh-new');
    });
  });

  group('when the server cannot be asked', () {
    test('keeps the session and does not end it', () async {
      final (renewer, auth) = await start(
        answer: (_) async => throw const SocketException('offline'),
      );

      expect(await renewer.renew(), isFalse);
      expect(refused, 0);
      expect(auth.userSession.session, isNotNull);
    });

    test('pauses, so a server that is down is not asked again', () async {
      final (renewer, _) = await start(answer: (_) async => http.Response('', 500));

      await renewer.renew();
      await renewer.renew();
      await renewer.renew();

      expect(tokenRequests(), 1);
    });

    test('tries again once the pause is over', () async {
      final (renewer, _) = await start(
        cooldown: Duration.zero,
        answer: (_) async => http.Response('', 500),
      );

      await renewer.renew();
      await renewer.renew();

      expect(tokenRequests(), 2);
    });

    test('gives a rate limited server longer to recover than one that is down', () async {
      Future<int> requestsAfterTwoCalls(int status) async {
        final (renewer, _) = await start(
          cooldown: const Duration(milliseconds: 100),
          answer: (_) async => http.Response('', status),
        );
        await renewer.renew();
        await Future<void>.delayed(const Duration(milliseconds: 200));
        await renewer.renew();

        return tokenRequests();
      }

      expect(await requestsAfterTwoCalls(429), 1);
      expect(await requestsAfterTwoCalls(500), 2);
    });

    test('renews again after a success clears the pause', () async {
      var calls = 0;
      final (renewer, _) = await start(
        cooldown: Duration.zero,
        answer: (_) async => ++calls == 1 ? http.Response('', 500) : renewsAs('refresh-$calls'),
      );

      expect(await renewer.renew(), isFalse);
      expect(await renewer.renew(), isTrue);
      expect(await renewer.renew(), isTrue);
    });
  });

  group('isExpiring', () {
    test('is false while the token has time left', () async {
      final (renewer, _) = await start(answer: (_) => renewsAs('refresh-2'));

      expect(renewer.isExpiring, isFalse);
    });

    test('is true inside the margin', () async {
      final (renewer, _) = await start(
        lasts: const Duration(seconds: 30),
        answer: (_) => renewsAs('refresh-2'),
      );

      expect(renewer.isExpiring, isTrue);
    });

    test('is true without a session', () {
      final auth = NhostAuthClient(url: 'https://auth.test/v1');
      addTearDown(auth.close);

      expect(
        SessionRenewer(auth: auth, onRenewed: () async {}, onRefused: () async {}).isExpiring,
        isTrue,
      );
    });
  });

  group('schedule', () {
    test('renews a token that is already inside the margin', () async {
      final (renewer, _) = await start(
        lasts: const Duration(seconds: 30),
        answer: (_) => renewsAs('refresh-2'),
      );

      renewer.schedule();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(tokenRequests(), 1);
      expect(renewed, 1);
    });

    test('waits while the token has time left', () async {
      final (renewer, _) = await start(answer: (_) => renewsAs('refresh-2'));

      renewer.schedule();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(requests, isEmpty);
    });

    test('does nothing once cancelled', () async {
      final (renewer, _) = await start(
        lasts: const Duration(seconds: 30),
        answer: (_) => renewsAs('refresh-2'),
      );

      renewer
        ..schedule()
        ..cancel();
      await Future<void>.delayed(const Duration(milliseconds: 50));

      expect(requests, isEmpty);
    });
  });
}
