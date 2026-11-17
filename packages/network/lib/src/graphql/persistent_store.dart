import 'package:graphql/client.dart';
import 'package:hive_ce/hive.dart';
import 'package:logger/logger.dart';

/// A cache store that saves everything in an encrypted box on the device.
///
/// It works from memory until [open] finishes, so it can be handed to a client before the box is
/// ready.
// ignore: must_be_immutable, the box is opened after the store is handed to the client
class PersistentStore() implements Store {
  static const String _boxName = 'graphql';
  static const int _compactAfterDeleted = 200;
  static final Logger _logger = Logger('PersistentStore');

  final InMemoryStore _memory = InMemoryStore();
  HiveStore? _saved;

  /// A new key for [open].
  static List<int> generateKey() => Hive.generateSecureKey();

  /// Opens the box in [directory], encrypted with [encryptionKey].
  ///
  /// A box that cannot be read is deleted and opened empty, because everything in it can be
  /// fetched again.
  Future<void> open({required String directory, required List<int> encryptionKey}) async {
    Hive.init(directory);
    final cipher = HiveAesCipher(encryptionKey);
    Future<Box<dynamic>> openBox() => Hive.openBox<dynamic>(
      _boxName,
      encryptionCipher: cipher,
      compactionStrategy: (entries, deleted) => deleted > _compactAfterDeleted,
    );

    Box<dynamic> box;
    try {
      box = await openBox();
    } on Object catch (error, stack) {
      _logger.warning(
        'The saved queries could not be read, starting empty',
        error: error,
        stackTrace: stack,
      );
      await Hive.deleteBoxFromDisk(_boxName);
      box = await openBox();
    }
    _saved = HiveStore(box);
  }

  /// Closes the box, after finishing what is still being written.
  Future<void> close() async => _saved?.box.close();

  @override
  Map<String, dynamic>? get(String dataId) => _memory.get(dataId) ?? _saved?.get(dataId);

  @override
  void put(String dataId, Map<String, dynamic>? value) {
    final saved = _saved;
    if (saved != null) {
      _memory.delete(dataId);
      saved.put(dataId, value);
    } else {
      _memory.put(dataId, value);
    }
  }

  @override
  void putAll(Map<String, Map<String, dynamic>?> data) => data.forEach(put);

  @override
  void delete(String dataId) {
    _memory.delete(dataId);
    _saved?.delete(dataId);
  }

  @override
  Future<void> reset() async {
    _memory.reset();
    await _saved?.reset();
  }

  @override
  Map<String, Map<String, dynamic>?> toMap() => {...?_saved?.toMap(), ..._memory.toMap()};
}
