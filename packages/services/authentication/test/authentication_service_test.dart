import 'dart:convert';

import 'package:authentication_service/authentication_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secure_storage_service/secure_storage_service.dart';

class _MockStorage() extends Mock implements SecureStorageService;

void main() {
  const base = 'https://auth.test/v1';
  final session = {
    'accessToken': 'access',
    'accessTokenExpiresIn': 900,
    'refreshToken': 'refresh',
    'refreshTokenId': 'id',
    'user': {'id': 'user-1', 'email': 'ana@test.dev', 'displayName': 'Ana'},
  };

  late _MockStorage storage;

  setUp(() => storage = _MockStorage());

  test('sign in stores the session', () async {
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
    final client = MockClient((request) async {
      expect(request.url.toString(), '$base/signin/email-password');
      expect(jsonDecode(request.body), {'email': 'ana@test.dev', 'password': 'secret-1'});

      return http.Response(jsonEncode({'session': session}), 200);
    });

    final service = AuthenticationService(httpClient: client, secureStorage: storage);
    await service.initialize(url: base);
    await service.signInWithEmailAndPassword(email: 'ana@test.dev', password: 'secret-1');

    expect(service.currentSession?.user.id, 'user-1');
    expect(service.isAuthenticated, isTrue);
    verify(
      () => storage.write(
        key: 'auth.session',
        value: any(named: 'value'),
      ),
    ).called(1);
  });

  test('a refused sign in keeps an auth code', () async {
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
    final client = MockClient(
      (_) async => http.Response(jsonEncode({'error': 'invalid-email-password'}), 401),
    );
    final service = AuthenticationService(httpClient: client, secureStorage: storage);
    await service.initialize(url: base);

    expect(
      service.signInWithEmailAndPassword(email: 'ana@test.dev', password: 'wrong'),
      throwsA(
        isA<AuthenticationException>().having((e) => e.code, 'code', 'invalid-email-password'),
      ),
    );
  });

  test('a stored session is restored at start', () async {
    when(() => storage.read(key: 'auth.session')).thenAnswer(
      (_) async => jsonEncode({
        'accessToken': 'access',
        'refreshToken': 'refresh',
        'expiresAt': DateTime.now().add(const Duration(hours: 1)).toIso8601String(),
        'user': {'id': 'user-1', 'email': 'ana@test.dev', 'displayName': 'Ana'},
      }),
    );
    final service = AuthenticationService(
      httpClient: MockClient((_) async => http.Response('', 200)),
      secureStorage: storage,
    );
    await service.initialize(url: base);

    expect(service.currentSession?.user.id, 'user-1');
  });

  test('an empty auth url is refused', () {
    expect(AuthenticationService().initialize(url: ''), throwsA(isA<AuthenticationException>()));
  });
}
