import 'dart:async';
import 'dart:convert';

import 'package:core/core.dart';
import 'package:logger/logger.dart';
import 'package:network/network.dart';
import 'package:path_provider/path_provider.dart';
import 'package:secure_storage_service/secure_storage_service.dart';

/// Opens the encrypted box that keeps query results on the device, so the app can read them
/// again without a connection.
///
/// The cache works from memory when the box cannot be opened.
final class QueryStoreInitializer({
  final PersistentStore? store,
  final SecureStorageService? secureStorage,
  final FutureOr<String> Function()? directory,
}) extends Initializer {
  static const String _keyName = 'graphql.cache.key';
  static final Logger _logger = Logger('QueryStoreInitializer');

  @override
  FailurePolicy get failurePolicy => FailurePolicy.nonCritical;

  @override
  Future<void> initialize() async {
    _logger.info('Opening the saved queries');

    final injector = AppInjector.instance;
    final key = await _key(secureStorage ?? injector.get<SecureStorageService>());
    final path = await (directory?.call() ?? _supportDirectory());
    await (store ?? injector.get<PersistentStore>()).open(directory: path, encryptionKey: key);
  }

  Future<String> _supportDirectory() async => (await getApplicationSupportDirectory()).path;

  Future<List<int>> _key(SecureStorageService storage) async {
    final saved = await storage.read(key: _keyName);
    if (saved != null) return base64Decode(saved);

    final key = PersistentStore.generateKey();
    await storage.write(key: _keyName, value: base64Encode(key));

    return key;
  }
}
