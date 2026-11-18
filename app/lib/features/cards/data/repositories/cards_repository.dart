import 'dart:async';

import 'package:app/features/_shared/data/mappers/page_info_mapper.dart';
import 'package:app/features/_shared/data/models/page_info.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/cards/data/data_sources/remote/cards_data_source.dart';
import 'package:app/features/cards/data/mappers/card_detail_mapper.dart';
import 'package:app/features/cards/data/mappers/card_mapper.dart';
import 'package:app/features/cards/data/mappers/card_summary_mapper.dart';
import 'package:app/features/cards/data/models/card_detail.dart';
import 'package:app/features/cards/data/models/card_summary.dart';
import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:core/core.dart';

/// How many cards one page of the history holds.
const int cardPageSize = 20;

class CardsRepository({
  required final CardsDataSource _dataSource,
  required final AuthenticationRepository _authenticationRepository,
  final HomeWidgetsRepository? _homeWidgetsRepository,
}) {
  /// This week's card, creating the draft from the week's slips when there is none yet.
  Future<SundayCard> getDraft() async {
    return (await _dataSource.prepareCard()).toModel();
  }

  /// One page of the sent and received cards, newest first.
  Future<PageInfo<CardSummary>> getHistory({int offset = 0}) async {
    final rows = await _dataSource.getCards(limit: cardPageSize + 1, offset: offset);

    final userId = _authenticationRepository.currentUserId;

    return rows.toPageInfo(
      offset: offset,
      pageSize: cardPageSize,
      map: (row) => row.toModel(userId: userId),
    );
  }

  /// One card with its author and the answer, or a not-found failure.
  Future<CardDetail> getDetail({required String id}) async {
    final node = await _dataSource.getCard(id);
    if (node == null) throw const LocalizedException(l10nKey: 'CARD_NOT_FOUND');

    return node.toDetail(userId: _authenticationRepository.currentUserId);
  }

  /// Records that the recipient opened the card, so the sender sees it when receipts are on.
  Future<void> markRead(String cardId) async {
    await _dataSource.markRead(cardId);
    unawaited(_homeWidgetsRepository?.syncQuietly());
  }

  /// Sets the recipient's one reaction to the card.
  Future<String?> react({required String cardId, required String reaction, String? reply}) async {
    final result = await _dataSource.react(cardId: cardId, reaction: reaction, reply: reply);
    unawaited(_homeWidgetsRepository?.syncQuietly());
    return result;
  }

  /// Sends the card to the connected partner. A card that cannot go any more answers with a
  /// failure, and the caller reads the card again.
  ///
  /// Wording that matches a rule holds the card with a reason; [anyway] sends it regardless.
  Future<SundayCard> send(String cardId, {bool anyway = false}) async {
    final model = (await _dataSource.sendCard(cardId, anyway: anyway)).toModel();
    unawaited(_homeWidgetsRepository?.syncQuietly());
    return model;
  }

  /// Takes a held card back to a draft so the wording can be rewritten.
  Future<SundayCard> reopen(String cardId) async {
    return (await _dataSource.reopenCard(cardId)).toModel();
  }

  /// Keeps the card for later; nothing is lost and it can still be sent.
  Future<SundayCard> hold(String cardId) async {
    final model = (await _dataSource.holdCard(cardId)).toModel();
    unawaited(_homeWidgetsRepository?.syncQuietly());
    return model;
  }

  /// Saves the card's closing note, the order of its items and the items taken off it.
  Future<SundayCard> saveDraft(SundayCard card, {List<String> removedItemIds = const []}) async {
    return (await _dataSource.updateDraft(
      cardId: card.id,
      note: card.note,
      items: [
        for (var index = 0; index < card.items.length; index++)
          (id: card.items[index].id, position: index),
      ],
      removedItemIds: removedItemIds,
    )).toModel();
  }

  /// Whether new slips go on the weekly card by default.
  Future<bool> getSlipsDefaultForCard() async {
    return await _dataSource.getSlipsDefaultForCard(_userId);
  }

  /// Sets whether new slips go on the weekly card by default.
  Future<void> setSlipsDefaultForCard({required bool value}) async {
    await _dataSource.setSlipsDefaultForCard(userId: _userId, value: value);
  }

  String get _userId {
    final userId = _authenticationRepository.currentUserId;
    if (userId == null) throw const LocalizedException(l10nKey: 'UNAUTHENTICATED');

    return userId;
  }
}
