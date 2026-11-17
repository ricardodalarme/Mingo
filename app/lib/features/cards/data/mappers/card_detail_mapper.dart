import 'package:app/features/cards/data/data_sources/remote/queries/generated/CardDetail.graphql.dart';
import 'package:app/features/cards/data/mappers/card_mapper.dart';
import 'package:app/features/cards/data/models/card_detail.dart';

extension CardDetailMapper on QueryCardDetailcardsByPk {
  /// The card with the names of both people and the answer, from [userId]'s side.
  CardDetail toDetail({required String? userId}) => CardDetail(
    card: toModel(),
    isMine: authorId == userId,
    authorName: author.displayName,
    recipientName: recipient?.displayName,
    reaction: reaction?.reaction,
    reply: reaction?.reply,
  );
}
