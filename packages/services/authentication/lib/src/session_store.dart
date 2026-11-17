import 'dart:async';
import 'dart:convert';

import 'package:nhost_sdk/nhost_sdk.dart' show Session;
import 'package:secure_storage_service/secure_storage_service.dart';

/// Keeps the session in secure storage, one operation at a time, so a late write cannot undo a
/// delete.
class SessionStore(final SecureStorageService _storage) {
  static const String _key = 'auth.session';

  Future<void> _last = Future.value();

  /// The saved session, or null when there is none or it cannot be read; a session that cannot be
  /// read is deleted.
  Future<Session?> read() => _queue(() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return null;
    try {
      final session = Session.fromJson(jsonDecode(raw));
      if (session.accessToken != null && session.refreshToken != null) return session;
    } on Object {
      // Falls through to the delete below.
    }
    await _storage.delete(key: _key);

    return null;
  });

  Future<void> write(Session session) =>
      _queue(() => _storage.write(key: _key, value: jsonEncode(session.toJson())));

  Future<void> delete() => _queue(() => _storage.delete(key: _key));

  Future<T> _queue<T>(Future<T> Function() operation) {
    final result = _last.then((_) => operation());
    _last = result.then<void>((_) {}, onError: (Object _) {});

    return result;
  }
}
