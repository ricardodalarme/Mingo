part of 'accept_invite_cubit.dart';

/// What happened to a typed invite code.
enum AcceptOutcome() {
  /// The two people are connected.
  connected,

  /// The code is unknown, expired or already used.
  unusable,

  /// The code is the one this person created.
  ownCode,
}

final class const AcceptInviteState({
  final FormInput<String> code = const FormInput(''),
  final Resource<AcceptOutcome> acceptAction = const Initial(),
  final String? partnerName,
  final String? selfName,
  final String? partnerHint,
  final bool isInviting = false,
}) with Equatable {
  AcceptInviteState copyWith({
    FormInput<String>? code,
    Resource<AcceptOutcome>? acceptAction,
    String? partnerName,
    String? selfName,
    String? partnerHint,
    bool? isInviting,
  }) {
    return AcceptInviteState(
      code: code ?? this.code,
      acceptAction: acceptAction ?? this.acceptAction,
      partnerName: partnerName ?? this.partnerName,
      selfName: selfName ?? this.selfName,
      partnerHint: partnerHint ?? this.partnerHint,
      isInviting: isInviting ?? this.isInviting,
    );
  }

  @override
  List<Object?> get props => [code, acceptAction, partnerName, selfName, partnerHint, isInviting];
}
