import 'package:app/features/love_style/data/models/love_pattern.dart';
import 'package:app/features/love_style/data/models/love_style_result.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/profile.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'love_style_state.dart';

class LoveStyleCubit({
  required final LoveStyleRepository _repository,
  required final PairingRepository _pairingRepository,
}) extends Cubit<LoveStyleState> {
  this : super(const LoveStyleState());

  /// Shows the saved result when there is one; otherwise the exercise starts fresh.
  Future<void> load() async {
    emit(state.copyWith(result: const Loading(), pairingFailed: false));
    try {
      final (overview, manualValue, partner) = await (
        _repository.getOverview(),
        _repository.getManualEntry(),
        _readPartner(),
      ).wait;
      final own = overview.own;
      final result = LoveStyleResult.fromRecord(own?.ranked);
      if (isClosed) return;
      emit(
        state.copyWith(
          result: Success<LoveStyleResult?>(result),
          isAnswering: result == null,
          isInManual: manualValue != null,
          entryId: own?.id,
          clearEntry: own == null,
          isShared: own?.isShared ?? false,
          partnerRanked: overview.partner?.knownRanked,
          clearPartnerRanked: overview.partner == null,
          hasPartner: partner.profile != null,
          partnerName: partner.profile?.displayName,
          clearPartnerName: true,
          pairingFailed: partner.failed,
        ),
      );
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(result: Failure.fromObject(exception), isAnswering: false));
    }
  }

  void select(String pattern) {
    if (state.isSaving || !lovePatternKeys.contains(pattern)) return;
    final answers = [...state.answers];
    while (answers.length <= state.questionIndex) {
      answers.add('');
    }
    answers[state.questionIndex] = pattern;
    emit(state.copyWith(answers: answers));
  }

  /// Goes forward, saving the ranking after the last answer.
  Future<void> next() async {
    if (!state.canContinue || state.isSaving) return;
    if (state.isLastQuestion) {
      await _save();

      return;
    }
    emit(state.copyWith(questionIndex: state.questionIndex + 1));
  }

  void back() {
    if (state.questionIndex == 0 || state.isSaving) return;
    emit(state.copyWith(questionIndex: state.questionIndex - 1));
  }

  /// Starts again with empty answers; the saved result stays until a new one is finished.
  void retake() {
    if (state.isSaving || state.isRevokingShare) return;
    emit(state.copyWith(isAnswering: true, questionIndex: 0, answers: const [], isInManual: false));
  }

  /// Writes the result description to the person's private manual.
  Future<void> saveToManual(String description) async {
    if (state.savedResult == null || state.isInManual || state.isSavingManual) return;

    emit(state.copyWith(manualAction: const Loading()));
    try {
      await _repository.saveManualEntry(description);
      if (isClosed) return;
      emit(state.copyWith(isInManual: true, manualAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(manualAction: Failure.fromObject(exception)));
      emit(state.copyWith(manualAction: const Initial()));
    }
  }

  /// Shows the result to the partner.
  Future<void> share() async {
    final id = state.entryId;
    if (id == null || !state.hasPartner || state.isShared || state.isSharing) return;

    emit(state.copyWith(shareAction: const Loading()));
    try {
      await _repository.setShared(id: id, isShared: true);
      if (isClosed) return;
      emit(state.copyWith(isShared: true, shareAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(shareAction: Failure.fromObject(exception)));
      emit(state.copyWith(shareAction: const Initial()));
    }
  }

  /// Hides the result from the partner again.
  Future<void> revokeShare() async {
    final id = state.entryId;
    if (id == null || !state.isShared || state.isRevokingShare) return;

    emit(state.copyWith(revokeAction: const Loading()));
    try {
      await _repository.setShared(id: id, isShared: false);
      if (isClosed) return;
      emit(state.copyWith(isShared: false, revokeAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(revokeAction: Failure.fromObject(exception)));
      emit(state.copyWith(revokeAction: const Initial()));
    }
  }

  Future<void> _save() async {
    if (!state.isComplete) return;

    final answers = state.answers;
    emit(state.copyWith(saveAction: const Loading()));
    try {
      final ranked = rankLovePatterns(answers);
      final id = await _repository.saveRanked(ranked);
      if (isClosed) return;
      emit(
        state.copyWith(
          result: Success<LoveStyleResult?>(LoveStyleResult(ranked: ranked)),
          isAnswering: false,
          isInManual: false,
          entryId: id,
          isShared: false,
          saveAction: const Success(null),
        ),
      );
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }

  Future<({Profile? profile, bool failed})> _readPartner() async {
    try {
      return (profile: await _pairingRepository.getPartner(), failed: false);
    } on Object {
      return (profile: null, failed: true);
    }
  }
}
