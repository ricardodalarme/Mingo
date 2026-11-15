import 'package:preferences_service/preferences_service.dart';

/// Keeps the invite code a signed-out person opened, until they sign in or accept it.
class InviteCodeStore({required final PreferencesService _preferencesService}) {
  static const _key = 'pendingInviteCode';

  String? read() => _preferencesService.readString(key: _key);

  Future<void> save(String code) => _preferencesService.writeString(key: _key, value: code);

  Future<void> clear() async {
    try {
      await _preferencesService.delete(key: _key);
    } on Object {
      // Nothing to clean up if the device storage is unavailable.
    }
  }
}
