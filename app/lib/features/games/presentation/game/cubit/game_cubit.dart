import 'dart:async';

import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
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
  StreamSubscription<List<GameSession>>? _sessions;

  /// Reads [kind] with its latest session; calling it again refreshes the same game.
  Future<void> load(GameKind kind) async {
    _kind = kind;
    _sessions ??= _repository.watchSessions().listen(_onSessions);
    await _read(reset: true);
  }

  /// Reads the game again on resume or "check again".
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

  /// Reads the game again and shows a loading action while it checks.
  Future<void> checkAgain() async {
    if (state.action.isLoading) return;

    emit(state.copyWith(action: const Loading()));
    await refresh();
    if (isClosed) return;
    emit(state.copyWith(action: const Initial()));
  }

  /// Shows the first question of a round, or the wait when everything was answered.
  void begin() {
    final play = state.current;
    if (play == null || state.isBusy) return;
    final next = play.currentStep;
    emit(
      state.copyWith(
        answers: play.own,
        step: next,
        draft: next < play.totalSteps ? _draftFor(next, play.own) : '',
      ),
    );
  }

  /// Returns to the previous question, or to the game intro from the first one.
  ///
  /// While the partner finishes, going back opens the last answer so it can change.
  void previous() {
    final play = state.current;
    if (play == null || state.isBusy) return;

    if (state.step >= play.totalSteps) {
      final last = play.totalSteps - 1;
      if (last < 0) return;
      emit(state.copyWith(step: last, draft: _draftFor(last)));
      return;
    }
    if (state.step < 0) return;
    final step = state.step - 1;
    emit(state.copyWith(step: step, draft: step < 0 ? '' : _draftFor(step)));
  }

  void onDraftChanged(String draft) {
    if (state.isBusy || state.isLocked) return;
    emit(state.copyWith(draft: draft));
  }

  /// Keeps [answer] as the draft of this step; the primary action sends it.
  void choose(String answer) {
    if (state.isBusy || state.isLocked) return;

    emit(state.copyWith(draft: answer));
  }

  /// Sends the draft as this step's answer and moves on.
  Future<void> submit() async {
    if (!state.canSubmit) return;

    await _save(state.step, state.draft.trim());
  }

  /// Sends a skip for this step so the session can still finish.
  Future<void> skip() async {
    if (state.isBusy || state.isLocked) return;

    await _save(state.step, gameSkippedAnswer);
  }

  /// Sends the invitation for a new session.
  Future<void> invite() async {
    final play = state.current;
    if (play == null || state.isBusy || play.available.isEmpty) return;

    await _act(() => _repository.invite(play.kind));
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
      lockedSteps: const {},
      draft: '',
    );
  }

  Future<void> _save(int step, String answer) async {
    final play = state.current;
    final session = play?.session;
    if (play == null || session == null || state.isBusy || state.isLocked) return;

    emit(state.copyWith(action: const Loading()));
    try {
      await _repository.answer(session: session, step: step, answer: answer);
      if (isClosed) return;
      var next = play.withOwnAnswer(step, answer);
      Object? finishFailure;
      if (next.isOwnDone) {
        try {
          next = await _finishIfReady(next);
        } catch (exception) {
          finishFailure = exception;
        }
      }
      if (isClosed) return;
      final nextStep = next.isOwnDone ? next.totalSteps : next.currentStep;
      emit(
        state.copyWith(
          play: Success(next),
          answers: next.own,
          step: nextStep,
          draft: nextStep < next.totalSteps ? _draftFor(nextStep, next.own) : '',
          action: finishFailure == null ? const Initial() : Failure.fromObject(finishFailure),
        ),
      );
      if (finishFailure == null) return;
      emit(state.copyWith(action: const Initial()));
    } on LocalizedException catch (exception) {
      if (isClosed) return;
      final isLocked = exception.l10nKey == gameAnswerLockedCode;
      emit(
        state.copyWith(
          answers: isLocked ? {...state.answers, step: play.own[step] ?? ''} : state.answers,
          lockedSteps: isLocked ? {...state.lockedSteps, step} : state.lockedSteps,
          action: Failure.fromObject(exception),
        ),
      );
      emit(state.copyWith(action: const Initial()));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(action: Failure.fromObject(exception)));
      emit(state.copyWith(action: const Initial()));
    }
  }

  /// The stored answer of [step] as an editable draft, with a skip reading as empty.
  String _draftFor(int step, [Map<int, String>? answers]) {
    final answer = (answers ?? state.answers)[step];

    return answer == null || answer == gameSkippedAnswer ? '' : answer;
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

  /// Reads the game again when its latest session was created or changed by the partner, such
  /// as an invitation accepted, a game finished or one cancelled.
  void _onSessions(List<GameSession> sessions) {
    final kind = _kind;
    final loaded = state.current;
    if (kind == null || loaded == null || state.isBusy) return;

    GameSession? latest;
    for (final session in sessions) {
      if (session.game != kind) continue;
      if (latest == null || session.createdAt.isAfter(latest.createdAt)) latest = session;
    }
    final known = loaded.session;
    if (latest?.id == known?.id && latest?.status == known?.status) return;

    unawaited(refresh());
  }

  @override
  Future<void> close() async {
    await _sessions?.cancel();

    return super.close();
  }
}
