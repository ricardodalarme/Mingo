import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spice_desires_state.dart';

/// The code the server answers with when a Plus feature is used on the free plan.
const String plusRequiredCode = 'PLUS_REQUIRED';

class SpiceDesiresCubit({required final SpiceRepository _spiceRepository})
    extends Cubit<SpiceDesiresState> {
  this : super(const SpiceDesiresState());

  /// Reads the desires up to the couple's level and what both people want.
  Future<void> load() async {
    if (state.desires is! Success) emit(state.copyWith(desires: const Loading()));
    try {
      final status = await _spiceRepository.getStatus();
      final level = status.coupleLevel ?? status.myLevel;
      final (desires, matches) = await (_spiceRepository.getDesires(level), _readMatches()).wait;
      emit(state.copyWith(desires: Success(desires), matches: matches));
    } catch (exception) {
      if (state.desires is Success) return;
      emit(state.copyWith(desires: Failure.fromObject(exception)));
    }
  }

  /// Saves the answer on screen first and puts the previous one back if the server refuses it.
  Future<void> answer(SpiceDesire desire, SpiceAnswer answer) async {
    final current = state.desires;
    if (current is! Success<List<SpiceDesire>> || state.answerAction.isLoading) return;

    emit(
      state.copyWith(
        desires: Success([
          for (final item in current.value)
            if (item.slug == desire.slug) item.withAnswer(answer) else item,
        ]),
        answerAction: const Loading(),
      ),
    );
    try {
      await _spiceRepository.answerDesire(slug: desire.slug, answer: answer);
      emit(state.copyWith(answerAction: const Success(null), matches: await _readMatches()));
    } catch (exception) {
      emit(state.copyWith(desires: current, answerAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(answerAction: const Initial()));
  }

  /// The matches, or null when the free plan does not include them.
  Future<List<SpiceMatch>?> _readMatches() async {
    try {
      return await _spiceRepository.getMatches();
    } catch (exception) {
      if (Failure.fromObject(exception).exception.l10nKey == plusRequiredCode) return null;
      rethrow;
    }
  }
}
