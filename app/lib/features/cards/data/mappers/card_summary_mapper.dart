import 'package:app/features/cards/data/data_sources/remote/queries/generated/MyCards.graphql.dart';
import 'package:app/features/cards/data/models/card_summary.dart';

extension CardSummaryMapper on QueryMyCardscards {
  /// The card as the history lists it for [userId]: whether it is theirs, what came back and
  /// whether the recipient opened it.
  CardSummary toModel({required String? userId}) => CardSummary(
    id: id,
    isMine: authorId == userId,
    sentAt: sentAt ?? weekStart,
    itemCount: items.length,
    reaction: reaction?.reaction,
    hasReply: (reaction?.reply ?? '').isNotEmpty,
    isOpened: open != null,
  );
}
