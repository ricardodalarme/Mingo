part of 'card_settings_cubit.dart';

final class const CardSettingsState({
  final Resource<NotificationPreferences> preferences = const Loading(),
  final bool slipsDefaultForCard = false,
  final bool saveFailed = false,
}) with Equatable {
  CardSettingsState copyWith({
    Resource<NotificationPreferences>? preferences,
    bool? slipsDefaultForCard,
    bool? saveFailed,
  }) {
    return CardSettingsState(
      preferences: preferences ?? this.preferences,
      slipsDefaultForCard: slipsDefaultForCard ?? this.slipsDefaultForCard,
      saveFailed: saveFailed ?? this.saveFailed,
    );
  }

  @override
  List<Object?> get props => [preferences, slipsDefaultForCard, saveFailed];
}
