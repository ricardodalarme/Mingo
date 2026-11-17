part of 'spice_settings_cubit.dart';

final class const SpiceSettingsState({
  final Resource<SpiceSettings> settings = const Loading(),
  final Resource<void> saveAction = const Initial(),
}) with Equatable {
  SpiceSettingsState copyWith({Resource<SpiceSettings>? settings, Resource<void>? saveAction}) {
    return SpiceSettingsState(
      settings: settings ?? this.settings,
      saveAction: saveAction ?? this.saveAction,
    );
  }

  @override
  List<Object?> get props => [settings, saveAction];
}
