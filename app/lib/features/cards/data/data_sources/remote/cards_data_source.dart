import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/fragments/generated/CardFragment.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/HoldCard.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/MarkCardRead.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/PrepareCard.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/ReactToCard.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/SendCard.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/mutations/generated/UpdateCardDraft.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/queries/generated/CardDetail.graphql.dart';
import 'package:app/features/cards/data/data_sources/remote/queries/generated/MyCards.graphql.dart';
import 'package:network/network.dart';

/// One card item and the place it takes on the card.
typedef CardItemPosition = ({String id, int position});

class CardsDataSource({required final GQLClient _client}) {
  /// Builds this week's draft from the week's slips, or returns the one that already exists.
  Future<MutationPrepareCardprepareCard> prepareCard() async {
    final response = await _client.mutate(OptionsMutationPrepareCard());

    return validateResponseData(response, getData: (data) => data.prepareCard.firstOrNull);
  }

  /// Reads one page of the sent and received cards, newest first.
  Future<List<QueryMyCardscards>> getCards({required int limit, required int offset}) async {
    final response = await _client.query(
      OptionsQueryMyCards(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: VariablesQueryMyCards(limit: limit, offset: offset),
      ),
    );

    return validateResponseData(response, getData: (data) => data.cards);
  }

  /// The card with [id], or `null` when it is gone or not visible to the person.
  Future<QueryCardDetailcardsByPk?> getCard(String id) async {
    final response = await _client.query(
      OptionsQueryCardDetail(
        fetchPolicy: FetchPolicy.networkOnly,
        variables: VariablesQueryCardDetail(id: id),
      ),
    );
    validateResponse(response);

    return response.parsedData?.cardsByPk;
  }

  /// Records that the recipient opened the card; opening it again changes nothing.
  Future<void> markRead(String cardId) async {
    final response = await _client.mutate(
      OptionsMutationMarkCardRead(variables: VariablesMutationMarkCardRead(cardId: cardId)),
    );
    validateResponse(response);
  }

  /// Replaces the recipient's reaction to the card.
  Future<String?> react({required String cardId, required String reaction, String? reply}) async {
    final response = await _client.mutate(
      OptionsMutationReactToCard(
        variables: VariablesMutationReactToCard(cardId: cardId, reaction: reaction, reply: reply),
      ),
    );

    return validateResponseData(response, getData: (data) => data.insertCardReactionsOne).reaction;
  }

  /// Sends the card; fails with `NoDataException` when the server sends nothing.
  Future<FragmentCardFragment> sendCard(String cardId) async {
    final response = await _client.mutate(
      OptionsMutationSendCard(variables: VariablesMutationSendCard(cardId: cardId)),
    );

    return validateResponseData(response, getData: (data) => data.sendCard.firstOrNull);
  }

  /// Keeps the card for later, still unsent.
  Future<FragmentCardFragment> holdCard(String cardId) async {
    final response = await _client.mutate(
      OptionsMutationHoldCard(variables: VariablesMutationHoldCard(cardId: cardId)),
    );

    return validateResponseData(response, getData: (data) => data.updateCardsByPk);
  }

  /// Saves the note, the order of the items and the items taken off the card.
  Future<FragmentCardFragment> updateDraft({
    required String cardId,
    required List<CardItemPosition> items,
    required List<String> removedItemIds,
    String? note,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateCardDraft(
        variables: VariablesMutationUpdateCardDraft(
          cardId: cardId,
          note: note,
          items: [
            for (final item in items)
              InputcardItems_updates(
                $_set: InputcardItems_set_input(position: item.position),
                where: InputcardItems_bool_exp(id: Inputuuid_comparison_exp($_eq: item.id)),
              ),
          ],
          removedItemIds: removedItemIds,
        ),
      ),
    );

    return validateResponseData(response, getData: (data) => data.updateCardsByPk);
  }
}
