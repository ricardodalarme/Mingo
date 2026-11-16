import 'dart:async';

import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:uuid/uuid.dart';

part 'quick_slip_state.dart';

/// The longest slip the capture screen accepts.
const int quickSlipMaxLength = 140;

/// How long the undo stays available after a slip is saved.
const Duration undoWindow = Duration(seconds: 30);

class QuickSlipCubit({
  required final SlipRepository _slipRepository,
  required final AnnoyanceRepository _annoyanceRepository,
}) extends Cubit<QuickSlipState> {
  this : super(const QuickSlipState());

  final Uuid _uuid = const Uuid();
  String? _savedId;
  Annoyance? _savedAnnoyance;
  Timer? _undoTimer;

  /// The annoyance just saved, for the pages that go on from it.
  Annoyance? get savedAnnoyance => _savedAnnoyance;

  /// Restores a draft left less than an hour ago.
  ///
  /// Only a good slip is ever kept on the device; what bothered the person is not written to it.
  void start() {
    final draft = _slipRepository.readDraft(clock.now());
    if (draft == null) return;

    emit(state.copyWith(text: FormInput(draft.text), category: draft.category));
  }

  void onModeChanged(QuickSlipMode mode) {
    if (state.mode == mode) return;

    emit(state.copyWith(mode: mode, clearCategory: mode == QuickSlipMode.annoyance));
  }

  void onTextChanged(String text) {
    emit(state.copyWith(text: FormInput(text)));
    unawaited(_persistDraft());
  }

  void onCategoryToggled(SlipCategory category) {
    final isSame = state.category == category;
    emit(state.copyWith(category: isSame ? null : category, clearCategory: isSame));
    unawaited(_persistDraft());
  }

  /// Forgets the stored draft so the next visit starts clean.
  void discardDraft() => unawaited(_slipRepository.clearDraft());

  /// Saves what was written; returns whether it reached the server or the device.
  Future<bool> save() async {
    if (state.saveAction.isLoading || state.isSaved || !_validate()) return false;

    emit(state.copyWith(saveAction: const Loading()));
    try {
      final outcome = state.mode == QuickSlipMode.liked
          ? await _saveSlip()
          : await _saveAnnoyance();
      await _slipRepository.clearDraft();
      emit(state.copyWith(saveAction: Success(outcome), canUndo: true));
      _undoTimer = Timer(undoWindow, () => emit(state.copyWith(canUndo: false)));

      return true;
    } catch (exception) {
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));

      return false;
    }
  }

  Future<void> undo() async {
    if (!state.canUndo || state.undoAction.isLoading) return;

    emit(state.copyWith(undoAction: const Loading()));
    try {
      switch (state.mode) {
        case QuickSlipMode.liked:
          if (_savedId case final id?) await _slipRepository.undo(id);
        case QuickSlipMode.annoyance:
          if (_savedAnnoyance case final annoyance?) {
            await _annoyanceRepository.delete(annoyance.id);
          }
      }
      _undoTimer?.cancel();
      emit(state.copyWith(undoAction: const Success(null), canUndo: false));
    } catch (exception) {
      emit(state.copyWith(undoAction: Failure.fromObject(exception)));
      emit(state.copyWith(undoAction: const Initial()));
    }
  }

  Future<SlipSaveOutcome> _saveSlip() {
    final id = _savedId ??= _uuid.v4();

    return _slipRepository.saveQuick(
      id: id,
      body: state.text.value.trim(),
      createdAt: clock.now(),
      category: state.category,
    );
  }

  Future<SlipSaveOutcome> _saveAnnoyance() async {
    _savedAnnoyance = await _annoyanceRepository.save(state.text.value);

    return SlipSaveOutcome.synced;
  }

  bool _validate() {
    final validatedText = state.text.validate(
      CompositeValidator<String>([NonEmptyValidator(), MaxLengthValidator(quickSlipMaxLength)]),
    );

    emit(state.copyWith(text: validatedText));

    return validatedText.isValid;
  }

  Future<void> _persistDraft() {
    if (state.mode != QuickSlipMode.liked) return Future<void>.value();

    return _slipRepository.saveDraft(
      text: state.text.value,
      category: state.category,
      now: clock.now(),
    );
  }

  @override
  Future<void> close() {
    _undoTimer?.cancel();
    return super.close();
  }
}
