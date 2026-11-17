part of 'spice_desires_cubit.dart';

final class const SpiceDesiresState({
  final Resource<List<SpiceDesire>> desires = const Loading(),
  final List<SpiceMatch>? matches,
  final Resource<void> answerAction = const Initial(),
}) with Equatable {
  SpiceDesiresState copyWith({
    Resource<List<SpiceDesire>>? desires,
    List<SpiceMatch>? matches,
    Resource<void>? answerAction,
  }) {
    return SpiceDesiresState(
      desires: desires ?? this.desires,
      matches: matches ?? this.matches,
      answerAction: answerAction ?? this.answerAction,
    );
  }

  @override
  List<Object?> get props => [desires, matches, answerAction];
}
