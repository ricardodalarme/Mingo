import 'package:app/features/notifications/data/data_sources/remote/queries/generated/MyInbox.graphql.dart';
import 'package:app/features/notifications/data/mappers/notification_kind_mapper.dart';
import 'package:app/features/notifications/data/models/inbox_item.dart';

extension InboxItemRowMapper on QueryMyInboxinboxItems {
  /// Null for a row of a kind this version does not know.
  InboxItem? toModel() {
    final kind = type.toModel();
    if (kind == null) return null;

    return InboxItem(id: id, kind: kind, createdAt: createdAt, readAt: readAt, refId: refId);
  }
}
