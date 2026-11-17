import 'package:app/features/annoyances/data/data_sources/remote/fragments/generated/GentleRequestFragment.graphql.dart';
import 'package:app/features/annoyances/data/mappers/gentle_response_mapper.dart';
import 'package:app/features/annoyances/data/models/gentle_request.dart';

extension GentleRequestMapper on FragmentGentleRequestFragment {
  /// The request with the names of both people; an answer this version does not know reads as none.
  GentleRequest toModel() => GentleRequest(
    id: id,
    whenText: whenText,
    feelText: feelText,
    wishText: wishText,
    senderId: senderId,
    recipientId: recipientId,
    createdAt: createdAt,
    response: response?.toModel(),
    seenAt: seenAt,
    thankedAt: thankedAt,
    senderName: sender.displayName,
    recipientName: recipient.displayName,
  );
}
