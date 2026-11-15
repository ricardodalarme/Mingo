import 'dart:async';

import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_work_area.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:uuid/uuid.dart';

part 'slip_kind_state.dart';

/// The longest main text a detailed slip accepts.
const int slipKindMaxLength = 280;

/// The longest feeling or plan note a detailed slip accepts.
const int slipKindNoteMaxLength = 200;

/// The slip kinds this screen writes.
const List<SlipKind> slipKinds = [SlipKind.specific, SlipKind.ifThen, SlipKind.invisible];

class SlipKindCubit({required final SlipRepository _slipRepository}) extends Cubit<SlipKindState> {
  this : super(const SlipKindState());

  final Uuid _uuid = const Uuid();
  String? _savedId;

  /// Opens the form with the kind and text carried over from the previous screen.
  void start({required SlipKind kind, required String text}) {
    emit(
      state.copyWith(
        kind: slipKinds.contains(kind) ? kind : SlipKind.specific,
        text: FormInput(text),
      ),
    );
  }

  /// Switches the kind, keeping the main text.
  void onKindChanged(SlipKind kind) => emit(state.copyWith(kind: kind));

  /// Keeps the text for the quick form when another kind is opened from it.
  /// Forgets the stored draft so the next visit starts clean.
  void discardDraft() => unawaited(_slipRepository.clearDraft());

  Future<void> keepQuickDraft() =>
      _slipRepository.saveDraft(text: state.text.value, now: clock.now());

  void onTextChanged(String text) => emit(state.copyWith(text: FormInput(text)));

  void onFeelingChanged(String feeling) => emit(state.copyWith(feeling: FormInput(feeling)));

  void onPlanChanged(String plan) => emit(state.copyWith(plan: FormInput(plan)));

  void onWorkAreaToggled(SlipWorkArea area) {
    final isSame = state.workArea == area;
    emit(state.copyWith(workArea: isSame ? null : area, clearWorkArea: isSame));
  }

  Future<void> save() async {
    if (state.saveAction.isLoading || state.saveAction is Success || !_validate()) return;

    emit(state.copyWith(saveAction: const Loading()));
    final id = _savedId ??= _uuid.v4();
    final kind = state.kind;
    try {
      final outcome = await _slipRepository.saveQuick(
        id: id,
        body: state.text.value.trim(),
        createdAt: clock.now(),
        kind: kind,
        feeling: kind == SlipKind.specific ? _trimmedOrNull(state.feeling.value) : null,
        planNote: kind == SlipKind.ifThen ? state.plan.value.trim() : null,
        workArea: kind == SlipKind.invisible ? state.workArea : null,
      );
      emit(state.copyWith(saveAction: Success(outcome)));
    } catch (exception) {
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }

  bool _validate() {
    final validatedText = state.text.validate(
      CompositeValidator<String>([NonEmptyValidator(), MaxLengthValidator(slipKindMaxLength)]),
    );
    final validatedFeeling = state.kind == SlipKind.specific
        ? state.feeling.validate(MaxLengthValidator(slipKindNoteMaxLength))
        : state.feeling.toPure();
    final validatedPlan = state.kind == SlipKind.ifThen
        ? state.plan.validate(
            CompositeValidator<String>([
              NonEmptyValidator(),
              MaxLengthValidator(slipKindNoteMaxLength),
            ]),
          )
        : state.plan.toPure();

    emit(state.copyWith(text: validatedText, feeling: validatedFeeling, plan: validatedPlan));

    return validatedText.isValid && validatedFeeling.isValid && validatedPlan.isValid;
  }

  String? _trimmedOrNull(String value) {
    final trimmed = value.trim();

    return trimmed.isEmpty ? null : trimmed;
  }
}
