import 'package:app/features/notes/data/data_sources/remote/queries/generated/SentPartnerMessages.graphql.dart';
import 'package:app/features/notes/data/mappers/message_kind_mapper.dart';
import 'package:app/features/notes/data/models/sent_message.dart';

extension SentMessageMapper on QuerySentPartnerMessagespartnerMessages {
  /// The message, with [imageUrl] as the readable link of its drawing when it has one.
  SentMessage toModel({String? imageUrl}) => SentMessage(
    id: id,
    kind: kind.toModel(),
    createdAt: createdAt,
    forWidget: forWidget,
    body: body,
    mediaFileId: mediaFileId,
    imageUrl: imageUrl,
  );
}
