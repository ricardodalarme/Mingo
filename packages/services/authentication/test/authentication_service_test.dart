import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:authentication_service/authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage_service/secure_storage_service.dart';

class _MockStorage() extends Mock implements SecureStorageService;

void main() {
  const base = 'https://auth.test/v1';
  // Expires in 2100.
  const accessToken =
      'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyLTEiLCJleHAiOjQxMDI0NDQ4MDAsImh0dHBzOi8vaGFzdXJhLmlvL2p3dC9jbGFpbXMiOnsieC1oYXN1cmEtdXNlci1pZCI6InVzZXItMSJ9fQ.';
  // Expired in 2020.
  const expiredToken =
      'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyLTEiLCJleHAiOjE2MDAwMDAwMDAsImh0dHBzOi8vaGFzdXJhLmlvL2p3dC9jbGFpbXMiOnsieC1oYXN1cmEtdXNlci1pZCI6InVzZXItMSJ9fQ.';
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

  Map<String, Object?> sessionOf({String token = accessToken, String refresh = 'refresh-1'}) => {
    'accessToken': token,
    'accessTokenExpiresIn': 900,
    'refreshToken': refresh,
    'user': user,
  };

  http.Response json(Object body, [int status = 200]) =>
      http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json'});

  http.Response refused() => json({
    'error': 'invalid-refresh-token',
    'message': 'Invalid or expired refresh token',
    'status': 401,
  }, 401);

  http.Response unreadable() => json({
    'error': 'invalid-request',
    'message': 'The request payload is incorrect',
    'status': 400,
  }, 400);

  late _MockStorage storage;
  late Map<String, String> saved;
  late List<String> requests;

  setUp(() {
    storage = _MockStorage();
    saved = {};
    requests = [];
    when(() => storage.read(key: any(named: 'key')))
        .thenAnswer((invocation) async => saved[invocation.namedArguments[#key]]);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((invocation) async {
      saved[invocation.namedArguments[#key] as String] =
          invocation.namedArguments[#value] as String;
    });
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((invocation) async {
      saved.remove(invocation.namedArguments[#key]);
    });
  });

  /// A service started with [stored] in secure storage, if any, and the server answering with
  /// [answer], which also records each request in [requests].
  Future<AuthenticationService> start({
    String? stored,
    Future<http.Response> Function(http.Request request)? answer,
    Duration cooldown = const Duration(seconds: 10),
    Duration startupWait = const Duration(seconds: 3),
  }) async {
    if (stored != null) {
      saved['auth.session'] = jsonEncode({
        'accessToken': stored,
        'refreshToken': 'refresh-1',
        'user': user,
      });
    }
    final service = AuthenticationService(
      httpClient: MockClient((request) {
        requests.add(request.url.path);

        return (answer ?? (_) async => http.Response('', 200))(request);
      }),
      secureStorage: storage,
      refreshCooldown: cooldown,
      startupWait: startupWait,
    );
    addTearDown(service.dispose);
    await service.initialize(url: base);
    await pumpEventQueue();
    requests.clear();

    return service;
  }

  Future<http.Response> offline(http.Request _) async => throw const SocketException('offline');

  String? savedRefreshToken() =>
      (jsonDecode(saved['auth.session']!) as Map<String, Object?>)['refreshToken'] as String?;

  int tokenRequests() => requests.where((path) => path.endsWith('/token')).length;

  group('signing in', () {
    test('keeps the session in secure storage', () async {
      final service = await start(
        answer: (request) async {
          expect(request.url.toString(), '$base/signin/email-password');
          expect(jsonDecode(request.body), {'email': 'ana@test.dev', 'password': 'secret-1'});

          return json({'session': sessionOf()});
        },
      );

      await service.signInWithEmailAndPassword(email: 'ana@test.dev', password: 'secret-1');

      expect(service.currentUserId, 'user-1');
      expect(service.isAuthenticated, isTrue);
      expect(saved, contains('auth.session'));
    });

    test('keeps the auth code of a refusal', () async {
      final service = await start(
        answer: (_) async => json({'error': 'invalid-email-password'}, 401),
      );

      expect(
        service.signInWithEmailAndPassword(email: 'ana@test.dev', password: 'wrong'),
        throwsA(
          isA<AuthenticationException>().having((e) => e.code, 'code', 'invalid-email-password'),
        ),
      );
    });
  });

  group('starting up', () {
    test('restores the stored session', () async {
      final service = await start(stored: accessToken);

      expect(service.currentUserId, 'user-1');
      expect(service.isAuthenticated, isTrue);
      expect(requests, isEmpty);
    });

    test('renews a stored session whose access token expired', () async {
      final service = await start(
        stored: expiredToken,
        answer: (_) async => json(sessionOf(refresh: 'refresh-2')),
      );

      expect(service.userSession.session?.refreshToken, 'refresh-2');
      expect(savedRefreshToken(), 'refresh-2');
    });

    test('keeps an expired session when the server cannot be reached', () async {
      final service = await start(stored: expiredToken, answer: offline);

      expect(service.isAuthenticated, isTrue);
      expect(service.currentUserId, 'user-1');
      expect(saved, contains('auth.session'));
    });

    test('does not wait for a server that never answers', () async {
      final never = Completer<http.Response>();
      final stopwatch = Stopwatch()..start();

      final service = await start(
        stored: expiredToken,
        answer: (_) => never.future,
        startupWait: const Duration(milliseconds: 50),
      );

      expect(stopwatch.elapsed, lessThan(const Duration(seconds: 2)));
      expect(service.isAuthenticated, isTrue);
    });

    test('ends a stored session the server refuses', () async {
      final service = await start(stored: expiredToken, answer: (_) async => refused());

      expect(service.isAuthenticated, isFalse);
      expect(saved, isNot(contains('auth.session')));
    });

    test('ends a stored session the server cannot read', () async {
      final service = await start(stored: expiredToken, answer: (_) async => unreadable());

      expect(service.isAuthenticated, isFalse);
      expect(saved, isNot(contains('auth.session')));
    });

    test('forgets a stored session that cannot be read', () async {
      saved['auth.session'] = 'not json';

      final service = await start();

      expect(service.isAuthenticated, isFalse);
      expect(saved, isNot(contains('auth.session')));
    });
  });

  group('refreshSession', () {
    test('keeps the person signed in when the server cannot be reached', () async {
      final service = await start(stored: accessToken, answer: offline);

      final renewed = await service.refreshSession();

      expect(renewed, isFalse);
      expect(service.isAuthenticated, isTrue);
      expect(saved, contains('auth.session'));
    });

    test('does not announce the sign in again after each failure', () async {
      final service = await start(stored: accessToken, answer: (_) async => http.Response('', 429));
      final changes = <bool>[];
      service.authStateChanges.listen(changes.add);

      await service.refreshSession();
      await service.refreshSession();
      await service.refreshSession();
      await pumpEventQueue();

      expect(changes, isEmpty);
    });

    test('ends the session when the server refuses the refresh token', () async {
      final service = await start(stored: accessToken, answer: (_) async => refused());
      final changes = <bool>[];
      service.authStateChanges.listen(changes.add);

      final renewed = await service.refreshSession();
      await pumpEventQueue();

      expect(renewed, isFalse);
      expect(service.isAuthenticated, isFalse);
      expect(changes, [false]);
      expect(saved, isNot(contains('auth.session')));
    });

    test('ends the session when the server cannot read the refresh token', () async {
      final service = await start(stored: accessToken, answer: (_) async => unreadable());

      await service.refreshSession();
      await pumpEventQueue();

      expect(service.isAuthenticated, isFalse);
      expect(saved, isNot(contains('auth.session')));
    });

    test('is not undone by signing out while it runs', () async {
      final service = await start(
        stored: accessToken,
        answer: (request) async {
          if (!request.url.path.endsWith('/token')) return http.Response('', 200);
          await Future<void>.delayed(const Duration(milliseconds: 150));

          return json(sessionOf(refresh: 'refresh-2'));
        },
      );

      final renewal = service.refreshSession();
      await Future<void>.delayed(const Duration(milliseconds: 30));
      await service.signOut();
      await renewal;
      await pumpEventQueue();

      expect(service.isAuthenticated, isFalse);
      expect(saved, isNot(contains('auth.session')));
    });
  });

  group('getFreshAccessToken', () {
    test('is the current token while it has time left, with no request', () async {
      final service = await start(stored: accessToken);

      final token = await service.getFreshAccessToken();

      expect(token, accessToken);
      expect(requests, isEmpty);
    });

    test('renews a token that is about to expire before returning it', () async {
      final service = await start(
        stored: expiredToken,
        answer: offline,
        cooldown: Duration.zero,
        startupWait: Duration.zero,
      );
      requests.clear();

      final token = await service.getFreshAccessToken();

      expect(tokenRequests(), 1);
      expect(token, expiredToken);
    });

    test('is null when signed out', () async {
      final service = await start();

      expect(await service.getFreshAccessToken(), isNull);
    });
  });

  group('signing out', () {
    test('clears the stored session and announces it once', () async {
      final service = await start(stored: accessToken);
      final changes = <bool>[];
      service.authStateChanges.listen(changes.add);

      await service.signOut();
      await pumpEventQueue();

      expect(service.isAuthenticated, isFalse);
      expect(saved, isNot(contains('auth.session')));
      expect(changes, [false]);
    });
  });

  test('an empty auth url is refused', () {
    expect(AuthenticationService().initialize(url: ''), throwsA(isA<AuthenticationException>()));
  });
}
