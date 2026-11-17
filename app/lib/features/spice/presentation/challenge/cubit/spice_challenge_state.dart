part of 'spice_challenge_cubit.dart';

final class const SpiceChallengeState({
  final Resource<SpiceChallenge?> challenge = const Loading(),
  final Resource<void> actAction = const Initial(),
}) with Equatable {
  SpiceChallengeState copyWith({Resource<SpiceChallenge?>? challenge, Resource<void>? actAction}) {
    return SpiceChallengeState(
      challenge: challenge ?? this.challenge,
      actAction: actAction ?? this.actAction,
    );
  }

  @override
  List<Object?> get props => [challenge, actAction];
}
