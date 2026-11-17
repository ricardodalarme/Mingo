import 'dart:convert';
import 'dart:io';

import 'package:authentication_service/authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nhost_auth_dart/nhost_auth_dart.dart';
import 'package:nhost_sdk/nhost_sdk.dart' show Session;
import 'package:secure_storage_service/secure_storage_service.dart';

class _MockStorage() extends Mock implements SecureStorageService;

void main() {
  const base = 'https://auth.test/v1';
  const accessToken =
      'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyLTEiLCJleHAiOjQxMDI0NDQ4MDAsImh0dHBzOi8vaGFzdXJhLmlvL2p3dC9jbGFpbXMiOnsieC1oYXN1cmEtdXNlci1pZCI6InVzZXItMSJ9fQ.';
  const expiredToken =
      'eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJzdWIiOiJ1c2VyLTEiLCJleHAiOjE2MDAwMDAwMDAsImh0dHBzOi8vaGFzdXJhLmlvL2p3dC9jbGFpbXMiOnsieC1oYXN1cmEtdXNlci1pZCI6InVzZXItMSJ9fQ.';
  final session = {
    'accessToken': accessToken,
    'accessTokenExpiresIn': 900,
    'refreshToken': 'refresh',
    'refreshTokenId': 'id',
    'user': {
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
    },
  };

  late _MockStorage storage;

  setUp(() {
    storage = _MockStorage();
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((_) async {});
  });

  test('sign in stores the session', () async {
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    final httpClient = MockClient((request) async {
      expect(request.url.toString(), '$base/signin/email-password');
      expect(jsonDecode(request.body), {'email': 'ana@test.dev', 'password': 'secret-1'});

      return http.Response(
        jsonEncode({'session': session}),
        200,
        headers: {'content-type': 'application/json'},
      );
    });

    final service = AuthenticationService(
      authClient: NhostAuthClient(url: base, httpClient: httpClient),
      secureStorage: storage,
    );
    addTearDown(service.dispose);
    await service.initialize(url: base);
    await service.signInWithEmailAndPassword(email: 'ana@test.dev', password: 'secret-1');

    expect(service.currentSession?.user.id, 'user-1');
    expect(service.isAuthenticated, isTrue);
    verify(
      () => storage.write(
        key: 'auth.session',
        value: any(named: 'value'),
      ),
    ).called(greaterThan(0));
  });

  test('a refused sign in keeps an auth code', () async {
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
    final httpClient = MockClient(
      (_) async => http.Response(
        jsonEncode({'error': 'invalid-email-password'}),
        401,
        headers: {'content-type': 'application/json'},
      ),
    );
    final service = AuthenticationService(
      authClient: NhostAuthClient(url: base, httpClient: httpClient),
      secureStorage: storage,
    );
    addTearDown(service.dispose);
    await service.initialize(url: base);

    expect(
      service.signInWithEmailAndPassword(email: 'ana@test.dev', password: 'wrong'),
      throwsA(
        isA<AuthenticationException>().having((e) => e.code, 'code', 'invalid-email-password'),
      ),
    );
  });

  test('a stored session is restored at start', () async {
    final stored = Session(
      accessToken: accessToken,
      accessTokenExpiresIn: const Duration(seconds: 900),
      refreshToken: 'refresh',
      user: Session.fromJson({
        'accessToken': accessToken,
        'refreshToken': 'refresh',
        'user': session['user'],
      }).user,
    );
    when(() => storage.read(key: 'auth.session'))
        .thenAnswer((_) async => jsonEncode(stored.toJson()));
    final service = AuthenticationService(
      authClient: NhostAuthClient(
        url: base,
        httpClient: MockClient((_) async => http.Response('', 200)),
      ),
      secureStorage: storage,
    );
    addTearDown(service.dispose);
    await service.initialize(url: base);

    expect(service.currentSession?.user.id, 'user-1');
  });

  test('a stored session with an expired access token is refreshed at start', () async {
    var refreshes = 0;
    final client = MockClient((request) async {
      expect(request.url.toString(), '$base/token');
      refreshes++;

      return http.Response(
        jsonEncode({
          'accessToken': accessToken,
          'accessTokenExpiresIn': 900,
          'refreshToken': 'refresh-2',
          'user': session['user'],
        }),
        200,
        headers: {'content-type': 'application/json'},
      );
    });
    when(() => storage.read(key: 'auth.session')).thenAnswer(
      (_) async => jsonEncode({
        'accessToken': expiredToken,
        'refreshToken': 'refresh-1',
        'user': session['user'],
      }),
    );
    final service = AuthenticationService(
      authClient: NhostAuthClient(url: base, httpClient: client),
      secureStorage: storage,
    );
    addTearDown(service.dispose);
    await service.initialize(url: base);

    expect(refreshes, 1);
    expect(service.currentSession?.refreshToken, 'refresh-2');
    expect(service.currentSession?.user.id, 'user-1');
  });

  group('when the server cannot be reached', () {
    http.Response rejected() => http.Response(
      jsonEncode({
        'error': 'invalid-refresh-token',
        'message': 'Invalid or expired refresh token',
        'status': 401,
      }),
      401,
      headers: {'content-type': 'application/json'},
    );

    Future<AuthenticationService> start({
      required String storedToken,
      required Future<http.Response> Function() answer,
    }) async {
      when(() => storage.read(key: 'auth.session')).thenAnswer(
        (_) async => jsonEncode({
          'accessToken': storedToken,
          'refreshToken': 'refresh-1',
          'user': session['user'],
        }),
      );
      final service = AuthenticationService(
        httpClient: MockClient((_) => answer()),
        secureStorage: storage,
      );
      addTearDown(service.dispose);
      await service.initialize(url: base);
      await pumpEventQueue();

      return service;
    }

    Future<http.Response> offline() async => throw const SocketException('offline');

    test('a failed renewal keeps the person signed in', () async {
      final service = await start(storedToken: accessToken, answer: offline);

      final renewed = await service.refreshSession();

      expect(renewed, isFalse);
      expect(service.isAuthenticated, isTrue);
      verifyNever(() => storage.delete(key: any(named: 'key')));
    });

    test('a renewal the server rejects signs the person out', () async {
      final service = await start(storedToken: accessToken, answer: () async => rejected());
      final changes = <bool>[];
      service.authStateChanges.listen(changes.add);

      final renewed = await service.refreshSession();
      await pumpEventQueue();

      expect(renewed, isFalse);
      expect(service.isAuthenticated, isFalse);
      expect(changes, contains(false));
      verify(() => storage.delete(key: 'auth.session')).called(greaterThan(0));
    });

    test('an expired session is restored at start and stays signed in', () async {
      final service = await start(storedToken: expiredToken, answer: offline);

      expect(service.isAuthenticated, isTrue);
      expect(service.currentSession?.user.id, 'user-1');
      verifyNever(() => storage.delete(key: any(named: 'key')));
    });

    test('an expired session the server rejects is cleared at start', () async {
      final service = await start(storedToken: expiredToken, answer: () async => rejected());

      expect(service.isAuthenticated, isFalse);
      verify(() => storage.delete(key: 'auth.session')).called(greaterThan(0));
    });
  });

  test('an empty auth url is refused', () {
    expect(AuthenticationService().initialize(url: ''), throwsA(isA<AuthenticationException>()));
  });
}
