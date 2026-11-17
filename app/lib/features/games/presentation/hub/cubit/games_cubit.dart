import 'dart:async';

import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/models/games_overview.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'games_state.dart';

class GamesCubit({required final GamesRepository _repository}) extends Cubit<GamesState> {
  this : super(const GamesState());

  StreamSubscription<List<GameSession>>? _sessions;
  Set<(String, GameStatus)>? _seen;

  /// Reads the games and their latest sessions, again on resume or pull to refresh.
  Future<void> load() async {
    if (isClosed) return;
    _sessions ??= _repository.watchSessions().listen(_onSessions);
    if (state.overview is! Success) emit(state.copyWith(overview: const Loading()));
    try {
      final overview = await _repository.getOverview();
      if (isClosed) return;
      emit(state.copyWith(overview: Success(overview)));
    } catch (exception) {
      if (isClosed || state.overview is Success) return;
      emit(state.copyWith(overview: Failure.fromObject(exception)));
    }
  }

  /// Reads the games again when a session was created or changed, which is how an invitation
  /// from the partner shows up while the hub is open.
  void _onSessions(List<GameSession> sessions) {
    final current = {for (final session in sessions) (session.id, session.status)};
    final seen = _seen;
    final isChange = seen != null && !seen.containsAll(current);
    _seen = current;
    if (isChange && state.overview is Success) unawaited(load());
  }

  @override
  Future<void> close() async {
    await _sessions?.cancel();

    return super.close();
  }
}
