import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

class GameCubit({
  required final GamesRepository _repository,
  required final ProfileRepository _profileRepository,
}) extends Cubit<GameState> {
  this : super(const GameState());

  GameKind? _kind;

  /// Reads [kind] with its latest session; calling it again refreshes the same game.
  Future<void> load(GameKind kind) async {
    _kind = kind;
    await _read(reset: true);
  }

  /// Reads the game again on resume, pull to refresh or "check again".
  ///
  /// A person who already answered everything also asks the server to finish, which only
  /// succeeds once the partner has answered everything too.
  Future<void> refresh() => _read(reset: false);

  Future<void> _read({required bool reset}) async {
    final kind = _kind;
    if (isClosed || kind == null) return;
    if (state.play is! Success) emit(state.copyWith(play: const Loading()));
    try {
      final settings = await _profileRepository.getMySettings();
      var play = await _repository.getPlay(kind: kind, locale: settings.locale);
      if (isClosed) return;
      play = await _finishIfReady(play);
      if (isClosed) return;
      emit(_loaded(play, reset: reset));
    } catch (exception) {
      if (isClosed || state.play is Success) return;
      emit(state.copyWith(play: Failure.fromObject(exception)));
    }
  }

  /// Reads the invitation again and shows a loading action while it checks.
  Future<void> checkAgain() async {
    if (state.action.isLoading) return;

    emit(state.copyWith(action: const Loading()));
    await refresh();
    if (isClosed) return;
    emit(state.copyWith(action: const Initial()));
  }

  /// Shows the first question of a round.
  void begin() {
    final play = state.current;
    if (play == null || state.isBusy) return;
    final next = _firstUnanswered(play, 0);
    if (next < 0) {
      review();
      return;
    }
    emit(state.copyWith(step: next, draft: _draftFor(next), isReviewing: false));
  }

  /// Returns to the previous question, or to the game intro from the first one.
  ///
  /// While the partner finishes, going back from an answer opens the review again.
  void previous() {
    final play = state.current;
    if (play == null || state.isBusy) return;
    final isWaiting = play.stage(clock.now()) == GameStage.waitingForPartner;

    if (state.isReviewing) {
      if (isWaiting) {
        emit(state.copyWith(isReviewing: false, step: play.totalSteps));
        return;
      }
      final last = play.totalSteps - 1;
      emit(state.copyWith(step: last, isReviewing: false, draft: _draftFor(last)));
      return;
    }
    if (isWaiting) {
      review();
      return;
    }
    if (state.step < 0) return;
    final step = state.step - 1;
    emit(state.copyWith(step: step, draft: _draftFor(step)));
  }

  /// Opens the review of every answer in this round.
  void review() {
    final play = state.current;
    if (play == null || play.totalSteps == 0 || state.isBusy) return;

    emit(state.copyWith(isReviewing: true, draft: ''));
  }

  /// Opens [step] to edit the answer already given.
  void editStep(int step) {
    final play = state.current;
    if (play == null || state.isBusy) return;
    if (step < 0 || step >= play.totalSteps || state.lockedSteps.contains(step)) return;

    emit(state.copyWith(step: step, isReviewing: false, draft: _draftFor(step)));
  }

  void onDraftChanged(String draft) {
    if (state.isBusy || state.isLocked) return;
    emit(state.copyWith(draft: draft));
  }

  /// Keeps the draft as the answer of this step and moves to the next question.
  void submit() {
    final play = state.current;
    if (play == null || !state.canSubmit) return;

    _keep(play, {...state.answers, state.step: state.draft.trim()});
  }

  /// Keeps [answer] as the answer of this step and moves to the next question.
  void choose(String answer) {
    final play = state.current;
    if (play == null || state.isBusy || state.isLocked) return;

    _keep(play, {...state.answers, state.step: answer});
  }

  /// Keeps a skip for this step so the session can still finish.
  void skip() {
    final play = state.current;
    if (play == null || state.isBusy || state.isLocked) return;

    _keep(play, {...state.answers, state.step: gameSkippedAnswer});
  }

  /// Sends every answer changed since the last send, then opens the wait.
  ///
  /// A step the server refuses to change stays read-only instead of being retried.
  Future<void> send() async {
    final play = state.current;
    final session = play?.session;
    if (play == null || session == null || state.isBusy) return;

    final answers = {...state.answers};
    final changed = [
      for (var step = 0; step < play.totalSteps; step++)
        if (answers.containsKey(step) && answers[step] != play.own[step]) step,
    ];
    if (changed.isEmpty) {
      emit(state.copyWith(isReviewing: false, step: play.totalSteps));
      return;
    }

    emit(state.copyWith(action: const Loading()));
    final locked = {...state.lockedSteps};
    final sent = <int, String>{};
    Object? failure;
    for (final step in changed) {
      try {
        await _repository.answer(session: session, step: step, answer: answers[step]!);
        if (isClosed) return;
        sent[step] = answers[step]!;
      } catch (exception) {
        if (isClosed) return;
        if (exception is LocalizedException && exception.l10nKey == gameAnswerLockedCode) {
          locked.add(step);
          final stored = play.own[step];
          if (stored == null) {
            answers.remove(step);
          } else {
            answers[step] = stored;
          }
          failure ??= exception;
          continue;
        }
        failure = exception;
        break;
      }
    }

    var next = sent.isEmpty ? play : play.withOwnAnswers(sent);
    try {
      if (next.isOwnDone) next = await _finishIfReady(next);
    } catch (exception) {
      failure ??= exception;
    }
    if (isClosed) return;

    final nextState = state.copyWith(
      play: Success(next),
      answers: answers,
      lockedSteps: locked,
      isReviewing: failure != null,
      step: failure == null ? play.totalSteps : state.step,
      draft: failure == null ? '' : state.draft,
    );
    if (failure == null) {
      emit(nextState.copyWith(action: const Success(null)));
      emit(nextState.copyWith(action: const Initial()));
      return;
    }
    emit(nextState.copyWith(action: Failure.fromObject(failure)));
    emit(nextState.copyWith(action: const Initial()));
  }

  /// Sends the invitation for a new session.
  Future<void> invite() async {
    final play = state.current;
    if (play == null || state.isBusy || play.available.isEmpty) return;

    await _act(() => _repository.invite(play));
  }

  /// Accepts the partner's invitation.
  Future<void> join() async {
    final session = state.current?.session;
    if (session == null || state.isBusy) return;

    await _act(() => _repository.join(session));
  }

  /// Cancels the open session for both people.
  Future<void> cancel() async {
    final session = state.current?.session;
    if (session == null || state.isBusy) return;

    await _act(() => _repository.cancel(session));
  }

  GameState _loaded(GamePlay play, {required bool reset}) {
    if (!reset && state.answers.isNotEmpty) return state.copyWith(play: Success(play));

    return state.copyWith(
      play: Success(play),
      answers: play.own,
      step: play.own.isEmpty ? -1 : play.currentStep,
      isReviewing: false,
      lockedSteps: const {},
      draft: '',
    );
  }

  void _keep(GamePlay play, Map<int, String> answers) {
    final next = _firstUnanswered(play, state.step + 1, answers);
    if (next < 0) {
      emit(
        state.copyWith(answers: answers, step: play.totalSteps - 1, isReviewing: true, draft: ''),
      );
      return;
    }
    emit(state.copyWith(answers: answers, step: next, draft: _draftFor(next, answers)));
  }

  /// The stored answer of [step] as an editable draft, with a skip reading as empty.
  String _draftFor(int step, [Map<int, String>? answers]) {
    final answer = (answers ?? state.answers)[step];

    return answer == null || answer == gameSkippedAnswer ? '' : answer;
  }

  /// The first step from [from] without an answer, wrapping around the round.
  int _firstUnanswered(GamePlay play, int from, [Map<int, String>? answers]) {
    final given = answers ?? state.answers;
    for (var step = from; step < play.totalSteps; step++) {
      if (!given.containsKey(step)) return step;
    }
    for (var step = 0; step < from && step < play.totalSteps; step++) {
      if (!given.containsKey(step)) return step;
    }

    return -1;
  }

  Future<void> _act(Future<Object?> Function() action) async {
    emit(state.copyWith(action: const Loading()));
    try {
      await action();
      if (isClosed) return;
      emit(state.copyWith(draft: '', action: const Success(null)));
      await refresh();
      if (isClosed) return;
      emit(state.copyWith(action: const Initial()));
    } catch (exception) {
      _fail(exception);
    }
  }

  Future<GamePlay> _finishIfReady(GamePlay play) async {
    final session = play.session;
    if (session == null || session.status != GameStatus.active || !play.isOwnDone) return play;
    final finished = await _repository.finishIfComplete(session);
    if (finished == null) return play;
    final kind = _kind;
    if (kind == null) return play.withSession(finished);
    final settings = await _profileRepository.getMySettings();

    return _repository.getPlay(kind: kind, locale: settings.locale);
  }

  void _fail(Object exception) {
    if (isClosed) return;
    emit(state.copyWith(action: Failure.fromObject(exception)));
    emit(state.copyWith(action: const Initial()));
  }
}
