import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/cards/data/repositories/cards_repository.dart';
import 'package:app/features/notifications/data/models/notification_preferences.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sunday_card_state.dart';

/// The longest closing note a card accepts.
const int cardNoteMaxLength = 200;

class SundayCardCubit({
  required final CardsRepository _cardsRepository,
  required final ProfileRepository _profileRepository,
  required final PairingRepository _pairingRepository,
  required final NotificationsRepository _notificationsRepository,
}) extends Cubit<SundayCardState> {
  this : super(const SundayCardState());

  NotificationPreferences? _preferences;

  Future<void> load() async {
    if (state.card is! Success) emit(state.copyWith(card: const Loading()));
    final names = await _readNames();
    final preferences = await _readPreferences();
    try {
      final card = await _cardsRepository.getDraft();
      emit(
        state.copyWith(
          card: Success(card),
          selfName: names.self,
          partnerName: names.partner,
          isPaired: names.isPaired,
          sendDay: preferences?.cardDay,
        ),
      );
      _preferences = preferences;
    } catch (exception) {
      if (state.card is Success) return;
      emit(state.copyWith(card: Failure.fromObject(exception)));
    }
  }

  /// Chooses the weekday the card is sent, from the next card on; the previous choice stays when saving fails.
  Future<void> setSendDay(int day) async {
    final preferences = _preferences;
    if (preferences == null || day == state.sendDay) return;

    final previous = state.sendDay;
    emit(state.copyWith(sendDay: day));
    try {
      await _notificationsRepository.savePreferences(preferences.copyWith(cardDay: day));
      _preferences = preferences.copyWith(cardDay: day);
    } on Object {
      emit(state.copyWith(sendDay: previous, sendDayFailed: true));
      emit(state.copyWith(sendDayFailed: false));
    }
  }

  Future<NotificationPreferences?> _readPreferences() async {
    try {
      return await _notificationsRepository.getPreferences();
    } on Object {
      return null;
    }
  }

  void startEditing() {
    final card = state.card;
    if (card is Success<SundayCard> && card.value.isDraft) {
      emit(state.copyWith(draft: card.value, excludedIds: const {}));
    }
  }

  void cancelEditing() {
    emit(state.copyWith(clearDraft: true, excludedIds: const {}));
  }

  /// Puts an item on the card or takes it off; an item taken off stays in the editor until saved.
  void toggleItem(String id) {
    final draft = state.draft;
    if (draft == null || !draft.items.any((item) => item.id == id)) return;

    final excluded = {...state.excludedIds};
    if (!excluded.remove(id)) excluded.add(id);
    emit(state.copyWith(excludedIds: excluded));
  }

  void onNoteChanged(String note) {
    final draft = state.draft;
    if (draft == null) return;

    emit(
      state.copyWith(
        draft: draft.copyWith(
          note: note.length > cardNoteMaxLength ? note.substring(0, cardNoteMaxLength) : note,
        ),
      ),
    );
  }

  Future<void> save() async {
    final draft = state.draft;
    if (draft == null || state.saveAction.isLoading) return;

    emit(state.copyWith(saveAction: const Loading()));
    try {
      final excluded = state.excludedIds;
      final saved = await _cardsRepository.saveDraft(
        draft.copyWith(
          items: [
            for (final item in draft.items)
              if (!excluded.contains(item.id)) item,
          ],
        ),
        removedItemIds: draft.items.map((item) => item.id).where(excluded.contains).toList(),
      );
      emit(
        state.copyWith(
          card: Success(saved),
          clearDraft: true,
          excludedIds: const {},
          saveAction: const Success(null),
        ),
      );
      emit(state.copyWith(saveAction: const Initial()));
    } catch (exception) {
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }

  /// Sends the card to the connected partner. A double tap sends once.
  Future<void> send({bool anyway = false}) =>
      _deliver((card) => _cardsRepository.send(card.id, anyway: anyway));

  /// Takes a card held for its wording back to a draft and starts editing it.
  Future<void> reopen() async {
    await _deliver((card) => _cardsRepository.reopen(card.id));
    startEditing();
  }

  /// Keeps the card for later; it can still be sent until the week ends.
  Future<void> hold() => _deliver((card) => _cardsRepository.hold(card.id));

  Future<void> _deliver(Future<SundayCard> Function(SundayCard card) action) async {
    final current = state.card;
    if (current is! Success<SundayCard> || state.deliverAction.isLoading) return;
    if (current.value.isSent) return;

    emit(state.copyWith(deliverAction: const Loading(), clearDraft: true));
    try {
      final card = await action(current.value);
      emit(state.copyWith(card: Success(card), deliverAction: const Success(null)));
      emit(state.copyWith(deliverAction: const Initial()));
    } catch (exception) {
      emit(state.copyWith(deliverAction: Failure.fromObject(exception)));
      emit(state.copyWith(deliverAction: const Initial()));
    }
  }

  Future<({String? self, String? partner, bool isPaired})> _readNames() async {
    var self = state.selfName;
    var partner = state.partnerName;
    var isPaired = false;
    try {
      self ??= (await _profileRepository.getMyProfile()).displayName;
      final partnerProfile = await _pairingRepository.getPartner();
      isPaired = partnerProfile != null;
      partner ??=
          partnerProfile?.displayName ?? (await _profileRepository.getMySettings()).partnerName;
    } on Object {
      // The card still renders without the names.
    }

    return (self: self, partner: partner, isPaired: isPaired);
  }
}
