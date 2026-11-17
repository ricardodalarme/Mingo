import 'dart:async';
import 'dart:convert';

import 'package:authentication_service/src/session_store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nhost_sdk/nhost_sdk.dart' show Session;
import 'package:secure_storage_service/secure_storage_service.dart';

class _MockStorage() extends Mock implements SecureStorageService;

void main() {
  late _MockStorage storage;
  late Map<String, String> saved;
  late SessionStore store;

  final session = Session.fromJson({
    'accessToken': 'access',
    'refreshToken': 'refresh',
    'accessTokenExpiresIn': 900,
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
  });

  setUp(() {
    storage = _MockStorage();
    saved = {};
    store = SessionStore(storage);
    when(() => storage.read(key: any(named: 'key')))
        .thenAnswer((invocation) async => saved[invocation.namedArguments[#key]]);
    when(() => storage.delete(key: any(named: 'key'))).thenAnswer((invocation) async {
      saved.remove(invocation.namedArguments[#key]);
    });
  });

  test('reads back what was written', () async {
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((invocation) async {
      saved[invocation.namedArguments[#key] as String] =
          invocation.namedArguments[#value] as String;
    });

    await store.write(session);
    final read = await store.read();

    expect(read?.refreshToken, 'refresh');
    expect(read?.user?.id, 'user-1');
  });

  test('has nothing when nothing was written', () async {
    expect(await store.read(), isNull);
  });

  test('deletes a session it cannot read, or one without tokens', () async {
    saved['auth.session'] = 'not json';
    expect(await store.read(), isNull);
    expect(saved, isEmpty);

    saved['auth.session'] = jsonEncode({'accessToken': 'access'});
    expect(await store.read(), isNull);
    expect(saved, isEmpty);
  });

  test('a slow write cannot land after a later delete', () async {
    final slowWrite = Completer<void>();
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((invocation) async {
      await slowWrite.future;
      saved[invocation.namedArguments[#key] as String] =
          invocation.namedArguments[#value] as String;
    });

    final write = store.write(session);
    final delete = store.delete();
    slowWrite.complete();
    await Future.wait([write, delete]);

    expect(saved, isEmpty);
  });
}
