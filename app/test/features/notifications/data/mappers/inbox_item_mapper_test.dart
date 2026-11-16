import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notifications/data/data_sources/remote/queries/generated/MyInbox.graphql.dart';
import 'package:app/features/notifications/data/mappers/inbox_item_mapper.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a row becomes an item that is unread until it has a read time', () {
    final created = DateTime.utc(2026, 11, 16, 18);

    final unread = QueryMyInboxinboxItems(
      id: 'i1',
      type: EnumNotificationType_enum.card_received,
      createdAt: created,
    ).toModel();
    final read = QueryMyInboxinboxItems(
      id: 'i2',
      type: EnumNotificationType_enum.daily_idea,
      createdAt: created,
      readAt: created,
    ).toModel();

    expect(unread?.kind, NotificationKind.cardReceived);
    expect(unread?.isRead, isFalse);
    expect(read?.isRead, isTrue);
  });

  test('a row of an unknown kind is left out', () {
    final item = QueryMyInboxinboxItems(
      id: 'i1',
      type: EnumNotificationType_enum.$unknown,
      createdAt: DateTime.utc(2026),
    ).toModel();

    expect(item, isNull);
  });
}
