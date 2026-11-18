import 'dart:convert';

import 'package:app/features/today/data/models/today_home.dart';
import 'package:preferences_service/preferences_service.dart';

/// The pairing last seen on this device and the person it belongs to.
typedef PairingMemory = ({String userId, String? partnerId, String? partnerName});

/// Keeps the last Hoje state so a cold start without a connection still shows something.
class TodayLocalDataSource({required final PreferencesService _preferencesService}) {
  static const _key = 'todayCache';
  static const _pairingUserIdKey = 'todayPairingUserId';
  static const _pairingPartnerIdKey = 'todayPairingPartnerId';
  static const _pairingPartnerNameKey = 'todayPairingPartnerName';

  TodayHome? read() {
    final raw = _preferencesService.readString(key: _key);
    if (raw == null) return null;

    try {
      return TodayHome.fromMap(jsonDecode(raw) as Map<String, dynamic>);
    } on Object {
      return null;
    }
  }

  Future<void> write(TodayHome home) =>
      _preferencesService.writeString(key: _key, value: jsonEncode(home.toMap()));

  /// The pairing stored on this device, or `null` when it belongs to no known person.
  PairingMemory? readPairing() {
    final userId = _preferencesService.readString(key: _pairingUserIdKey);
    if (userId == null) return null;

    return (
      userId: userId,
      partnerId: _preferencesService.readString(key: _pairingPartnerIdKey),
      partnerName: _preferencesService.readString(key: _pairingPartnerNameKey),
    );
  }

  Future<void> writePairing({
    required String userId,
    String? partnerId,
    String? partnerName,
  }) async {
    await _preferencesService.writeString(key: _pairingUserIdKey, value: userId);
    await _writeOrDelete(key: _pairingPartnerIdKey, value: partnerId);
    await _writeOrDelete(key: _pairingPartnerNameKey, value: partnerName);
  }

  Future<void> clear() async {
    await _preferencesService.delete(key: _key);
    await _preferencesService.delete(key: _pairingUserIdKey);
    await _preferencesService.delete(key: _pairingPartnerIdKey);
    await _preferencesService.delete(key: _pairingPartnerNameKey);
  }

  Future<void> _writeOrDelete({required String key, required String? value}) => value == null
      ? _preferencesService.delete(key: key)
      : _preferencesService.writeString(key: key, value: value);
}
