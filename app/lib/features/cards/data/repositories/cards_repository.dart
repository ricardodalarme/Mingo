import 'dart:async';

import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:app/features/cards/data/data_sources/remote/cards_data_source.dart';
import 'package:app/features/cards/data/mappers/card_mapper.dart';
import 'package:app/features/cards/data/models/card_detail.dart';
import 'package:app/features/cards/data/models/card_summary.dart';
import 'package:app/features/cards/data/models/sunday_card.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

/// How many cards one page of the history holds.
const int cardPageSize = 20;

class CardsRepository({
  required final CardsDataSource _dataSource,
  required final AuthenticationRepository _authenticationRepository,
  final WidgetsRepository? _widgetsRepository,
}) {
  final Logger _logger = Logger('CardsRepository');

  /// This week's card, creating the draft from the week's slips when there is none yet.
  Future<SundayCard> getDraft() async {
    try {
      return (await _dataSource.prepareCard()).toModel();
    } catch (e, stack) {
      _logger.error('Failed to load the card draft', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// One page of the sent and received cards, newest first.
  Future<CardSummaryPage> getHistory({int offset = 0}) async {
    try {
      final rows = await _dataSource.getCards(limit: cardPageSize + 1, offset: offset);
      final pageRows = rows.take(cardPageSize).toList();
      final userId = _authenticationRepository.currentUserId;

      return CardSummaryPage(
        items: [
          for (final row in pageRows)
            CardSummary(
              id: row.id,
              isMine: row.authorId == userId,
              sentAt: row.sentAt ?? row.weekStart,
              itemCount: row.items.length,
              reaction: row.reaction?.reaction,
              hasReply: (row.reaction?.reply ?? '').isNotEmpty,
              isOpened: row.open != null,
            ),
        ],
        hasNext: rows.length > cardPageSize,
        offset: offset + pageRows.length,
      );
    } catch (e, stack) {
      _logger.error('Failed to load the card history', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// One card with its author and the answer, or a not-found failure.
  Future<CardDetail> getDetail({required String id}) async {
    try {
      final node = await _dataSource.getCard(id);
      if (node == null) throw const LocalizedException(l10nKey: 'CARD_NOT_FOUND');

      return CardDetail(
        card: node.toModel(),
        isMine: node.authorId == _authenticationRepository.currentUserId,
        authorName: node.author.displayName,
        recipientName: node.recipient?.displayName,
        reaction: node.reaction?.reaction,
        reply: node.reaction?.reply,
      );
    } catch (e, stack) {
      _logger.error('Failed to load the card', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Records that the recipient opened the card, so the sender sees it when receipts are on.
  Future<void> markRead(String cardId) async {
    try {
      await _dataSource.markRead(cardId);
      unawaited(_widgetsRepository?.syncQuietly());
    } catch (e, stack) {
      _logger.error('Failed to mark the card as read', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Sets the recipient's one reaction to the card.
  Future<String?> react({required String cardId, required String reaction, String? reply}) async {
    try {
      final result = await _dataSource.react(cardId: cardId, reaction: reaction, reply: reply);
      unawaited(_widgetsRepository?.syncQuietly());
      return result;
    } catch (e, stack) {
      _logger.error('Failed to react to the card', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Sends the card to the connected partner. A card that cannot go any more answers with a
  /// failure, and the caller reads the card again.
  ///
  /// Wording that matches a rule holds the card with a reason; [anyway] sends it regardless.
  Future<SundayCard> send(String cardId, {bool anyway = false}) async {
    try {
      final model = (await _dataSource.sendCard(cardId, anyway: anyway)).toModel();
      unawaited(_widgetsRepository?.syncQuietly());
      return model;
    } catch (e, stack) {
      _logger.error('Failed to send the card', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Takes a held card back to a draft so the wording can be rewritten.
  Future<SundayCard> reopen(String cardId) async {
    try {
      return (await _dataSource.reopenCard(cardId)).toModel();
    } catch (e, stack) {
      _logger.error('Failed to reopen the card', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Keeps the card for later; nothing is lost and it can still be sent.
  Future<SundayCard> hold(String cardId) async {
    try {
      final model = (await _dataSource.holdCard(cardId)).toModel();
      unawaited(_widgetsRepository?.syncQuietly());
      return model;
    } catch (e, stack) {
      _logger.error('Failed to hold the card', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Saves the card's closing note, the order of its items and the items taken off it.
  Future<SundayCard> saveDraft(SundayCard card, {List<String> removedItemIds = const []}) async {
    try {
      return (await _dataSource.updateDraft(
        cardId: card.id,
        note: card.note,
        items: [
          for (var index = 0; index < card.items.length; index++)
            (id: card.items[index].id, position: index),
        ],
        removedItemIds: removedItemIds,
      )).toModel();
    } catch (e, stack) {
      _logger.error('Failed to save the card draft', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
