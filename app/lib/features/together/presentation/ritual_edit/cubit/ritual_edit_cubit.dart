import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/together/data/models/ritual.dart';
import 'package:app/features/together/data/models/ritual_cadence.dart';
import 'package:app/features/together/data/repositories/together_repository.dart';
import 'package:app/features/together/data/services/ritual_reminder_service.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ritual_edit_state.dart';

class RitualEditCubit({
  required final TogetherRepository _togetherRepository,
  required final RitualReminderService _reminderService,
  required final ProfileRepository _profileRepository,
  required final PairingRepository _pairingRepository,
}) extends Cubit<RitualEditState> {
  this
    : super(
        RitualEditState(
          ritual: const Ritual(id: '', title: '', cadence: RitualCadence.weekly, weekday: 5),
        ),
      );

  final Uuid _uuid = const Uuid();

  /// Opens an existing ritual by [id], or a blank one when [id] is null.
  Future<void> start(String? id) async {
    await _loadPeople();
    if (id == null) {
      emit(
        RitualEditState(
          ritual: Ritual(id: _uuid.v4(), title: '', cadence: RitualCadence.weekly, weekday: 5),
          isNew: true,
          meId: state.meId,
          partnerId: state.partnerId,
          partnerName: state.partnerName,
        ),
      );
      return;
    }
    emit(state.copyWith(load: const Loading()));
    try {
      final rituals = await _togetherRepository.getRituals();
      final found = rituals.where((ritual) => ritual.id == id);
      emit(
        state.copyWith(
          ritual: found.isEmpty ? null : found.first,
          load: found.isEmpty
              ? Failure.fromObject(const LocalizedException(l10nKey: 'NOT_FOUND'))
              : const Success(null),
        ),
      );
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(load: Failure.fromObject(exception)));
    }
  }

  void onTitleChanged(String title) => _edit((ritual) => ritual.copyWith(title: title));

  void onCadenceChosen(RitualCadence cadence) =>
      _edit((ritual) => ritual.copyWith(cadence: cadence));

  void onWeekdayChosen(int weekday) => _edit((ritual) => ritual.copyWith(weekday: weekday));

  void onHourChosen(int hour) => _edit((ritual) => ritual.copyWith(hour: hour));

  /// Names who plans the ritual, or nobody in particular when [personId] is null.
  void onPlannerChosen(String? personId) => _edit(
    (ritual) => personId == null
        ? ritual.copyWith(clearPlanner: true)
        : ritual.copyWith(plannerId: personId),
  );

  Future<void> _loadPeople() async {
    try {
      final (me, partner) = await (
        _profileRepository.getMyProfile(),
        _pairingRepository.getPartner(),
      ).wait;
      emit(state.copyWith(meId: me.id, partnerId: partner?.id, partnerName: partner?.displayName));
    } on Object {
      return;
    }
  }

  void onReminderChanged({required bool value}) =>
      _edit((ritual) => ritual.copyWith(hasReminder: value));

  Future<void> save() async {
    if (!state.canSave || state.saveAction.isLoading) return;

    emit(state.copyWith(saveAction: const Loading()));
    try {
      await _togetherRepository.saveRitual(state.ritual, isNew: state.isNew);
      await _reminderService.update(await _togetherRepository.getRituals());
      emit(state.copyWith(saveAction: const Success(null)));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }

  /// Hides the ritual; its history stays on the server.
  Future<void> archive() async {
    if (state.isNew || state.saveAction.isLoading) return;

    emit(state.copyWith(saveAction: const Loading()));
    try {
      await _togetherRepository.archiveRitual(state.ritual.id, now: clock.now());
      await _reminderService.update(await _togetherRepository.getRituals());
      emit(state.copyWith(saveAction: const Success(null)));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }

  void _edit(Ritual Function(Ritual) update) => emit(state.copyWith(ritual: update(state.ritual)));
}
