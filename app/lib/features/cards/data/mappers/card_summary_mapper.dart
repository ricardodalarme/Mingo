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

extension CardSummaryPageMapper on List<QueryMyCardscards> {
  /// The first [pageSize] cards; the page has a next one when the read held more than that.
  CardSummaryPage toPage({required int offset, required int pageSize, required String? userId}) {
    final pageRows = take(pageSize).toList();

    return CardSummaryPage(
      items: [for (final row in pageRows) row.toModel(userId: userId)],
      hasNext: length > pageSize,
      offset: offset + pageRows.length,
    );
  }
}
