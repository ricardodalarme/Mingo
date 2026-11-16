import 'package:app/features/cards/data/repositories/cards_repository.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'card_settings_state.dart';

class CardSettingsCubit({
  required final CardsRepository _cardsRepository,
  required final NotificationsRepository _notificationsRepository,
}) extends Cubit<CardSettingsState> {
  this : super(const CardSettingsState());

  Future<void> load() async {
    emit(state.copyWith(preferences: const Loading()));
    try {
      final (preferences, isDefault) = await (
        _notificationsRepository.getPreferences(),
        _cardsRepository.getSlipsDefaultForCard(),
      ).wait;
      if (isClosed) return;
      emit(state.copyWith(preferences: Success(preferences), slipsDefaultForCard: isDefault));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(preferences: Failure.fromObject(exception)));
    }
  }

  Future<void> setDay(int day) =>
      _savePreferences((preferences) => preferences.copyWith(cardDay: day));

  Future<void> setHour(int hour) =>
      _savePreferences((preferences) => preferences.copyWith(cardHour: hour));

  /// Chooses whether new slips go on the weekly card by default; the choice returns when saving fails.
  Future<void> setSlipsDefaultForCard({required bool value}) async {
    final previous = state.slipsDefaultForCard;
    if (value == previous) return;

    emit(state.copyWith(slipsDefaultForCard: value));
    try {
      await _cardsRepository.setSlipsDefaultForCard(value: value);
    } on Object {
      _fail(() => state.copyWith(slipsDefaultForCard: previous));
    }
  }

  Future<void> _savePreferences(
    NotificationPreferences Function(NotificationPreferences) change,
  ) async {
    final current = state.preferences;
    if (current is! Success<NotificationPreferences>) return;

    final next = change(current.value);
    if (next == current.value) return;

    emit(state.copyWith(preferences: Success(next)));
    try {
      await _notificationsRepository.savePreferences(next);
    } on Object {
      _fail(() => state.copyWith(preferences: current));
    }
  }

  void _fail(CardSettingsState Function() restore) {
    if (isClosed) return;
    emit(restore().copyWith(saveFailed: true));
    emit(state.copyWith(saveFailed: false));
  }
}
