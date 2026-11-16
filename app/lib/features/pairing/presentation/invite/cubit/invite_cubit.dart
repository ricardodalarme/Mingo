import 'dart:async';

import 'package:app/features/pairing/data/models/active_invite.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_service/share_service.dart';

part 'invite_state.dart';

class InviteCubit({
  required final PairingRepository _pairingRepository,
  required final ProfileRepository _profileRepository,
  required final ShareService _shareService,
}) extends Cubit<InviteState> {
  this : super(const InviteState());

  StreamSubscription<bool>? _connection;
  bool? _wasConnected;

  /// Starts once; later calls keep what is already loaded.
  Future<void> ensureStarted() async {
    if (state.invite is Success<ActiveInvite>) return;
    await start();
  }

  /// Loads the partner name and the invite to share, creating one when needed.
  Future<void> start() async {
    emit(state.copyWith(invite: const Loading()));
    final partnerName = await _readPartnerName();
    try {
      final invite = await _pairingRepository.getOrCreateInvite(clock.now());
      emit(state.copyWith(invite: Success(invite), partnerName: partnerName));
      _watchConnection();
    } catch (exception) {
      emit(state.copyWith(invite: Failure.fromObject(exception), partnerName: partnerName));
    }
  }

  /// Creates a fresh invite, which cancels the previous one on the server.
  Future<void> renew() async {
    emit(state.copyWith(invite: const Loading(), hasShared: false));
    try {
      emit(state.copyWith(invite: Success(await _pairingRepository.createInvite())));
    } catch (exception) {
      emit(state.copyWith(invite: Failure.fromObject(exception)));
    }
  }

  /// Opens the share sheet with [message] and remembers the invite was sent.
  Future<void> share(String message) async {
    try {
      await _shareService.shareText(text: message);
      emit(state.copyWith(hasShared: true));
    } on Object {
      // The share sheet may be unavailable; copying still works.
    }
  }

  Future<void> copy(String message) async {
    await Clipboard.setData(ClipboardData(text: message));
    emit(state.copyWith(hasShared: true));
  }

  Future<void> revoke() async {
    final invite = state.invite;
    if (invite is! Success<ActiveInvite> || state.revokeAction.isLoading) return;

    emit(state.copyWith(revokeAction: const Loading()));
    try {
      await _pairingRepository.cancelInvite(invite.value.id);
      emit(state.copyWith(revokeAction: const Success(null)));
    } catch (exception) {
      emit(state.copyWith(revokeAction: Failure.fromObject(exception)));
      emit(state.copyWith(revokeAction: const Initial()));
    }
  }

  /// Follows the couple on the server; a change from alone to connected means the invite was
  /// accepted, while being connected from the start is not news.
  void _watchConnection() {
    if (_connection != null) return;

    _connection = _pairingRepository.watchIsConnected().listen((isConnected) {
      final wasAlone = _wasConnected == false;
      _wasConnected = isConnected;
      if (wasAlone && isConnected) unawaited(_markConnected());
    }, onError: (Object _) {});
  }

  Future<void> _markConnected() async {
    final partner = await _readPartner();
    final self = await _readOwnName();
    if (isClosed) return;

    emit(
      state.copyWith(isConnected: true, partnerName: partner ?? state.partnerName, selfName: self),
    );
  }

  Future<String?> _readPartner() async {
    try {
      return (await _pairingRepository.getPartner())?.displayName;
    } on Object {
      return null;
    }
  }

  Future<String?> _readOwnName() async {
    try {
      return (await _profileRepository.getMyProfile()).displayName;
    } on Object {
      return null;
    }
  }

  Future<String?> _readPartnerName() async {
    try {
      return (await _profileRepository.getMySettings()).partnerName;
    } on Object {
      return null;
    }
  }

  @override
  Future<void> close() async {
    await _connection?.cancel();

    return super.close();
  }
}
