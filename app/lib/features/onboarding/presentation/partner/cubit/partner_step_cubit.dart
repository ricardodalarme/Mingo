import 'package:app/features/profile/data/models/partner_intent.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'partner_step_state.dart';

class PartnerStepCubit({required final ProfileRepository _profileRepository})
    extends Cubit<PartnerChoice> {
  this : super(PartnerChoice.invite);

  void choose(PartnerChoice choice) => emit(state == choice ? state : choice);

  /// Keeps the current choice in the person's own settings.
  ///
  /// A failed write is not fatal: the person still moves on and can invite later.
  Future<void> save() async {
    try {
      final profile = await _profileRepository.getMyProfile();
      await _profileRepository.updatePartnerIntent(profileId: profile.id, intent: _intent);
    } on LocalizedException {
      return;
    } on Object {
      return;
    }
  }

  PartnerIntent get _intent => switch (state) {
    PartnerChoice.invite => PartnerIntent.invite,
    PartnerChoice.later => PartnerIntent.later,
    PartnerChoice.soloOnly => PartnerIntent.soloOnly,
  };
}
