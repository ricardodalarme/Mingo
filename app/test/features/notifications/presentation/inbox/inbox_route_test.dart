import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:app/features/notifications/presentation/inbox/widgets/inbox_copy.dart';
import 'package:app/router/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

InboxItem _item(NotificationKind kind, {String? refId}) =>
    InboxItem(id: 'i', kind: kind, createdAt: DateTime(2026), refId: refId);

void main() {
  test('an annoyance check opens that annoyance', () {
    final route = inboxRouteFor(_item(NotificationKind.annoyanceCheck, refId: 'a1'));

    expect(route, isA<AnnoyanceCheckRoute>());
  });

  test('both sides of a gentle request open its detail', () {
    expect(
      inboxRouteFor(_item(NotificationKind.gentleRequest, refId: 'r1')),
      isA<GentleRequestDetailRoute>(),
    );
    expect(
      inboxRouteFor(_item(NotificationKind.gentleRequestAnswered, refId: 'r1')),
      isA<GentleRequestDetailRoute>(),
    );
  });

  test('a kind that points at a record needs the record id', () {
    expect(inboxRouteFor(_item(NotificationKind.annoyanceCheck)), isNull);
  });

  test('a kind without a screen of its own opens nothing', () {
    expect(inboxRouteFor(_item(NotificationKind.dailyIdea)), isNull);
  });
}
