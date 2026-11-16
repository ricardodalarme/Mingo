import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notifications/data/mappers/notification_kind_mapper.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every server kind is known to the app', () {
    final known = [
      for (final value in EnumNotificationType_enum.values)
        if (value != EnumNotificationType_enum.$unknown) value.toModel(),
    ];

    expect(known, everyElement(isNotNull));
    expect(known.toSet(), NotificationKind.values.toSet());
  });

  test('multi-word kinds map from their stored spelling', () {
    expect(EnumNotificationType_enum.card_received.toModel(), NotificationKind.cardReceived);
    expect(EnumNotificationType_enum.capsule_opened.toModel(), NotificationKind.capsuleOpened);
    expect(
      EnumNotificationType_enum.gentle_request_answered.toModel(),
      NotificationKind.gentleRequestAnswered,
    );
  });

  test('a kind this version does not know is left out', () {
    expect(EnumNotificationType_enum.$unknown.toModel(), isNull);
  });
}
