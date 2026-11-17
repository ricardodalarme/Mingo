import 'dart:async';

import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/pairing/data/mappers/invite_code_mapper.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

part 'accept_invite_state.dart';

/// Length of the invite codes the server issues.
const int inviteCodeLength = 8;

final RegExp _inviteCodePattern = RegExp('^[A-Z0-9]{$inviteCodeLength}\$');

class AcceptInviteCubit({
  required final PairingRepository _pairingRepository,
  required final ProfileRepository _profileRepository,
  required final InviteCodeStore _inviteCodes,
}) extends Cubit<AcceptInviteState> {
  this : super(const AcceptInviteState());

  /// Pre-fills the code from [code] or from the one kept when the link was opened.
  void start({String? code}) {
    unawaited(_loadPartnerHint());
    final pending = code ?? _inviteCodes.read();
    if (pending == null || pending.isEmpty) return;

    onCodeChanged(pending);
  }

  /// Switches between typing a code and showing the person's own code.
  void showInviting({required bool isInviting}) => emit(state.copyWith(isInviting: isInviting));

  Future<void> _loadPartnerHint() async {
    try {
      final name = (await _profileRepository.getMySettings()).partnerName;
      if (!isClosed) emit(state.copyWith(partnerHint: name));
    } on Object {
      // The headline falls back to a generic wording.
    }
  }

  /// Normalizes [value] and forgets the outcome of the previous attempt.
  void onCodeChanged(String value) {
    emit(
      state.copyWith(
        code: FormInput(_code(value)),
        acceptAction: state.acceptAction.isLoading ? state.acceptAction : const Initial(),
      ),
    );
  }

  Future<void> accept() async {
    if (state.acceptAction.isLoading || !_validate()) return;

    emit(state.copyWith(acceptAction: const Loading()));
    try {
      if (await _isOwnCode(state.code.value)) {
        await _inviteCodes.clear();
        emit(state.copyWith(acceptAction: const Success(AcceptOutcome.ownCode)));
        return;
      }
      final connected = await _pairingRepository.acceptInvite(state.code.value);
      await _inviteCodes.clear();
      if (!connected) {
        emit(state.copyWith(acceptAction: const Success(AcceptOutcome.unusable)));
        return;
      }
      final partner = await _readPartnerName();
      final self = await _readOwnName();
      emit(
        state.copyWith(
          acceptAction: const Success(AcceptOutcome.connected),
          partnerName: partner,
          selfName: self,
        ),
      );
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(acceptAction: Failure.fromObject(exception)));
      emit(state.copyWith(acceptAction: const Initial()));
    }
  }

  /// Lets the person type another code after an unusable one.
  void tryAgain() => emit(AcceptInviteState(code: state.code, partnerHint: state.partnerHint));

  /// The code in [value], which may be a pasted invite link.
  String _code(String value) {
    final trimmed = value.trim();
    final uri = Uri.tryParse(trimmed);
    final linked = uri == null ? null : inviteCodeFromUri(uri);
    final code = (linked ?? trimmed).replaceAll(RegExp(r'\s'), '').toUpperCase();

    return code.length > inviteCodeLength ? code.substring(0, inviteCodeLength) : code;
  }

  Future<bool> _isOwnCode(String code) async {
    try {
      return (await _pairingRepository.getActiveInvite())?.code == code;
    } on Object {
      return false;
    }
  }

  bool _validate() {
    final validatedCode = state.code.validate(
      CompositeValidator<String>([
        NonEmptyValidator(),
        MinLengthValidator(inviteCodeLength),
        MaxLengthValidator(inviteCodeLength),
        PatternValidator(_inviteCodePattern),
      ]),
    );

    emit(state.copyWith(code: validatedCode));

    return validatedCode.isValid;
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
      return (await _pairingRepository.getPartner())?.displayName;
    } on Object {
      return null;
    }
  }
}
