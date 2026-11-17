import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spice_settings_state.dart';

class SpiceSettingsCubit({required final SpiceRepository _spiceRepository})
    extends Cubit<SpiceSettingsState> {
  this : super(const SpiceSettingsState());

  Future<void> load() async {
    if (state.settings is! Success) emit(state.copyWith(settings: const Loading()));
    try {
      emit(state.copyWith(settings: Success(await _spiceRepository.getSettings())));
    } catch (exception, stack) {
      addError(exception, stack);
      if (state.settings is Success) return;
      emit(state.copyWith(settings: Failure.fromObject(exception)));
    }
  }

  Future<void> onLevelChosen(SpiceLevel level) =>
      _save((settings) => settings.copyWith(maxLevel: level));

  Future<void> onNotificationsChanged({required bool isOn}) =>
      _save((settings) => settings.copyWith(notifications: isOn));

  /// Shows the change at once and puts the previous settings back if the server refuses it.
  Future<void> _save(SpiceSettings Function(SpiceSettings) change) async {
    final current = state.settings;
    if (current is! Success<SpiceSettings> || state.saveAction.isLoading) return;

    final next = change(current.value);
    emit(state.copyWith(settings: Success(next), saveAction: const Loading()));
    try {
      await _spiceRepository.setSettings(next);
      emit(state.copyWith(saveAction: const Success(null)));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(settings: current, saveAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(saveAction: const Initial()));
  }
}
