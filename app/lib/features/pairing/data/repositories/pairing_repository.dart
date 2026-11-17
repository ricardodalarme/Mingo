import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/pairing/data/data_sources/local/pairing_local_data_source.dart';
import 'package:app/features/pairing/data/data_sources/remote/pairing_data_source.dart';
import 'package:app/features/pairing/data/mappers/partner_profile_mapper.dart';
import 'package:app/features/pairing/data/models/active_invite.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:logger/logger.dart';

class PairingRepository({
  required final PairingDataSource _pairingDataSource,
  required final PairingLocalDataSource _localDataSource,
  required final AuthenticationRepository _authenticationRepository,
}) {
  final Logger _logger = Logger('PairingRepository');

  /// Emits when the couple forms or ends, so screens that show the partner can read again.
  /// The invite already created and still valid, or a new one.
  Future<ActiveInvite> getOrCreateInvite(DateTime now) async {
    final stored = await _localDataSource.read();
    if (stored != null && !stored.isExpired(now)) return stored;

    return createInvite();
  }

  /// The invite this person created and kept on the device, or `null`.
  Future<ActiveInvite?> getActiveInvite() async {
    return await _localDataSource.read();
  }

  /// Creates an invite; the server cancels the previous one, so only the latest is valid.
  Future<ActiveInvite> createInvite() async {
    final created = await _pairingDataSource.createInvite();
    final invite = ActiveInvite(id: created.id, code: created.code, expiresAt: created.expiresAt);
    await _localDataSource.write(invite);
    return invite;
  }

  /// Whether [code] connected the two people. `false` covers every code that cannot be used.
  Future<bool> acceptInvite(String code) async {
    final connected = await _pairingDataSource.acceptInvite(code);
    if (connected) {
      await _localDataSource.clear();
    }
    return connected;
  }

  /// The connected partner, or `null` when the person is not paired.
  Future<Profile?> getPartner() async {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) return null;

    return (await _pairingDataSource.getPartner(userId))?.toModel();
  }

  /// Emits whether the person is connected, now and each time that changes; empty when signed out.
  Stream<bool> watchIsConnected() {
    if (_authenticationRepository.currentUserId == null) return const Stream.empty();

    return _pairingDataSource.watchIsConnected().handleError((Object e, StackTrace stack) {
      _logger.error('The couple subscription failed', error: e, stackTrace: stack);
    });
  }

  Future<void> cancelInvite(String inviteId) async {
    await _pairingDataSource.cancelInvite(inviteId);
    await _localDataSource.clear();
  }

  /// Ends the couple and clears the stored invite.
  Future<void> unpair() async {
    await _pairingDataSource.unpair();
    await _localDataSource.clear();
  }

  /// Keeps the person's shared rows private or deletes them, after [unpair].
  Future<void> resolveSharedItems({required bool keep}) async {
    await _pairingDataSource.resolveSharedItems(keep: keep);
  }
}
