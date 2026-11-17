import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  final key = List<int>.generate(32, (index) => index);

  setUp(() => directory = Directory.systemTemp.createTempSync('persistent_store_test'));

  tearDown(() async {
    await Hive.close();
    directory.deleteSync(recursive: true);
  });

  Future<PersistentStore> opened() async {
    final store = PersistentStore();
    await store.open(directory: directory.path, encryptionKey: key);

    return store;
  }

  test('works from memory before the box is open', () {
    final store = PersistentStore()..put('slips:1', {'body': 'hi'});

    expect(store.get('slips:1'), {'body': 'hi'});
  });

  test('what is saved is still there after the box is opened again', () async {
    final store = await opened();
    store.put('slips:1', {'body': 'hi'});
    await Hive.close();

    final reopened = await opened();

    expect(reopened.get('slips:1'), {'body': 'hi'});
  });

  test('a saved entry written again replaces the copy held in memory', () async {
    final store = PersistentStore()..put('slips:1', {'body': 'old'});
    await store.open(directory: directory.path, encryptionKey: key);

    store.put('slips:1', {'body': 'new'});

    expect(store.get('slips:1'), {'body': 'new'});
  });

  test('reset empties what is saved', () async {
    final store = await opened();
    store.put('slips:1', {'body': 'hi'});

    await store.reset();

    expect(store.get('slips:1'), isNull);
    expect(store.toMap(), isEmpty);
  });

  test('delete removes an entry from both places', () async {
    final store = await opened();
    store
      ..put('slips:1', {'body': 'hi'})
      ..delete('slips:1');

    expect(store.get('slips:1'), isNull);
  });

  test('a box that was written with another key starts empty instead of failing', () async {
    final store = await opened();
    store.put('slips:1', {'body': 'hi'});
    await Hive.close();

    final other = PersistentStore();
    await other.open(
      directory: directory.path,
      encryptionKey: List<int>.generate(32, (index) => 255 - index),
    );

    expect(other.get('slips:1'), isNull);
  });
}
