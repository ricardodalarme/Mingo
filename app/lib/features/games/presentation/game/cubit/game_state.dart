part of 'game_cubit.dart';

final class const GameState({
  final Resource<GamePlay> play = const Loading(),
  final Map<int, String> answers = const {},
  final int step = -1,
  final bool isReviewing = false,
  final Set<int> lockedSteps = const {},
  final String draft = '',
  final Resource<void> action = const Initial(),
}) with Equatable {
  /// The loaded game, or null while loading or failed.
  GamePlay? get current => switch (play) {
    Success(:final value) => value,
    _ => null,
  };

  /// Whether an invitation, answer or other change is being sent.
  bool get isBusy => action.isLoading;

  /// Whether the game intro is on screen before the first question.
  bool get isIntro => step < 0 && !isReviewing;

  /// Whether the answer of the step being edited cannot change any more.
  bool get isLocked => lockedSteps.contains(step);

  bool get canSubmit => !isBusy && !isLocked && draft.trim().isNotEmpty;

  GameState copyWith({
    Resource<GamePlay>? play,
    Map<int, String>? answers,
    int? step,
    bool? isReviewing,
    Set<int>? lockedSteps,
    String? draft,
    Resource<void>? action,
  }) {
    return GameState(
      play: play ?? this.play,
      answers: answers ?? this.answers,
      step: step ?? this.step,
      isReviewing: isReviewing ?? this.isReviewing,
      lockedSteps: lockedSteps ?? this.lockedSteps,
      draft: draft ?? this.draft,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [play, answers, step, isReviewing, lockedSteps, draft, action];
}
