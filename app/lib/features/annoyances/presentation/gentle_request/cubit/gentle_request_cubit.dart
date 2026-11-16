import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';

part 'gentle_request_state.dart';

/// The longest each of the three sentences may be.
const int gentleRequestMaxLength = 140;

class GentleRequestCubit({
  required final AnnoyanceRepository _annoyanceRepository,
  required final ProfileRepository _profileRepository,
}) extends Cubit<GentleRequestState> {
  this : super(const GentleRequestState());

  /// Reads the partner's name for the preview.
  Future<void> start() async {
    try {
      final name = (await _profileRepository.getMySettings()).partnerName;
      if (!isClosed) emit(state.copyWith(partnerName: name));
    } on Object {
      // The preview falls back to a generic wording.
    }
  }

  void onWhenChanged(String value) => emit(state.copyWith(whenText: FormInput(value)));

  void onFeelChanged(String value) => emit(state.copyWith(feelText: FormInput(value)));

  void onWishChanged(String value) => emit(state.copyWith(wishText: FormInput(value)));

  /// Sends the request and, with [annoyanceId], lets the annoyance it came from go.
  Future<void> send({String? annoyanceId}) async {
    if (state.sendAction.isLoading || !_validate()) return;

    emit(state.copyWith(sendAction: const Loading()));
    try {
      await _annoyanceRepository.sendGentleRequest(
        whenText: state.whenText.value,
        feelText: state.feelText.value,
        wishText: state.wishText.value,
        annoyanceId: annoyanceId,
      );
      emit(state.copyWith(sendAction: const Success(null)));
    } catch (exception) {
      emit(state.copyWith(sendAction: Failure.fromObject(exception)));
      emit(state.copyWith(sendAction: const Initial()));
    }
  }

  bool _validate() {
    CompositeValidator<String> rules() => CompositeValidator<String>([
      NonEmptyValidator(),
      MaxLengthValidator(gentleRequestMaxLength),
    ]);
    final validatedWhen = state.whenText.validate(rules());
    final validatedFeel = state.feelText.validate(rules());
    final validatedWish = state.wishText.validate(rules());

    emit(state.copyWith(whenText: validatedWhen, feelText: validatedFeel, wishText: validatedWish));

    return validatedWhen.isValid && validatedFeel.isValid && validatedWish.isValid;
  }
}
