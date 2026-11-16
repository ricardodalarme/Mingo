import 'dart:convert';

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

  test('an empty auth url is refused', () {
    expect(AuthenticationService().initialize(url: ''), throwsA(isA<AuthenticationException>()));
  });
}
