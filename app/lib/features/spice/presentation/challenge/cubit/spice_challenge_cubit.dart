import 'dart:async';

import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spice_challenge_state.dart';

class SpiceChallengeCubit({required final SpiceRepository _spiceRepository})
    extends Cubit<SpiceChallengeState> {
  this : super(const SpiceChallengeState());

  StreamSubscription<SpiceChallenge?>? _live;

  Future<void> load() async {
    if (state.challenge is! Success) emit(state.copyWith(challenge: const Loading()));
    try {
      emit(state.copyWith(challenge: Success(await _spiceRepository.getChallenge())));
      _watch();
    } catch (exception, stack) {
      addError(exception, stack);
      if (state.challenge is Success) return;
      emit(state.copyWith(challenge: Failure.fromObject(exception)));
    }
  }

  Future<void> act(SpiceChallengeAction action) async {
    if (state.actAction.isLoading) return;

    emit(state.copyWith(actAction: const Loading()));
    try {
      final challenge = await _spiceRepository.actOnChallenge(action);
      emit(state.copyWith(challenge: Success(challenge), actAction: const Success(null)));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(actAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(actAction: const Initial()));
  }

  /// Follows the challenge after the first read, so the partner accepting it shows up while the
  /// page is open.
  void _watch() {
    _live ??= _spiceRepository.watchChallenge().listen((challenge) {
      if (state.challenge is! Success || state.actAction.isLoading || challenge == null) return;
      emit(state.copyWith(challenge: Success(challenge)));
    });
  }

  @override
  Future<void> close() async {
    await _live?.cancel();

    return super.close();
  }
}
