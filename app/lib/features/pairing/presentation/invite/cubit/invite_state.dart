part of 'invite_cubit.dart';

final class const InviteState({
  final Resource<ActiveInvite> invite = const Loading(),
  final String? partnerName,
  final bool hasShared = false,
  final String? selfName,
  final bool isConnected = false,
  final Resource<void> revokeAction = const Initial(),
}) with Equatable {
  InviteState copyWith({
    Resource<ActiveInvite>? invite,
    String? partnerName,
    bool? hasShared,
    String? selfName,
    bool? isConnected,
    Resource<void>? revokeAction,
  }) {
    return InviteState(
      invite: invite ?? this.invite,
      partnerName: partnerName ?? this.partnerName,
      hasShared: hasShared ?? this.hasShared,
      selfName: selfName ?? this.selfName,
      isConnected: isConnected ?? this.isConnected,
      revokeAction: revokeAction ?? this.revokeAction,
    );
  }

  @override
  List<Object?> get props => [invite, partnerName, hasShared, selfName, isConnected, revokeAction];
}
