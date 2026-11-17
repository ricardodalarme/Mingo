import 'dart:convert';
import 'dart:io';

import 'package:app/infrastructure/initializers/query_store_initializer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';
import 'package:secure_storage_service/secure_storage_service.dart';

class _MockSecureStorage() extends Mock implements SecureStorageService;

void main() {
  late Directory directory;
  late SecureStorageService storage;

  setUp(() {
    directory = Directory.systemTemp.createTempSync('query_store_initializer_test');
    storage = _MockSecureStorage();
    when(() => storage.read(key: any(named: 'key'))).thenAnswer((_) async => null);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  final opened = <PersistentStore>[];

  tearDown(() async {
    for (final store in opened) {
      await store.close();
    }
    opened.clear();
    directory.deleteSync(recursive: true);
  });

  Future<PersistentStore> run() async {
    final store = PersistentStore();
    opened.add(store);
    await QueryStoreInitializer(
      store: store,
      secureStorage: storage,
      directory: () => directory.path,
    ).initialize();

    return store;
  }

  test('the first run creates a 32 byte key and keeps it in secure storage', () async {
    await run();

    final saved =
        verify(
              () => storage.write(
                key: 'graphql.cache.key',
                value: captureAny(named: 'value'),
              ),
            ).captured.single
            as String;
    expect(base64Decode(saved), hasLength(32));
  });

  test('a later run reads the saved results again with the key it kept', () async {
    String? savedKey;
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((invocation) async {
      savedKey = invocation.namedArguments[#value] as String;
    });
    final first = await run();
    first.put('slips:1', {'body': 'hi'});
    await first.close();
    when(() => storage.read(key: 'graphql.cache.key')).thenAnswer((_) async => savedKey);

    final second = await run();

    expect(second.get('slips:1'), {'body': 'hi'});
    verify(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).called(1);
  });
}
