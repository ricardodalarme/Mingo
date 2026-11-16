import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/notifications/data/mappers/notification_kind_mapper.dart';
import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Kinds the backend creates that this version does not show yet.
  const notShown = {
    EnumNotificationType_enum.gentle_request,
    EnumNotificationType_enum.gentle_request_answered,
    EnumNotificationType_enum.quiz_shared,
    EnumNotificationType_enum.spice_invite,
    EnumNotificationType_enum.spice_off,
    EnumNotificationType_enum.memory_proposed,
    EnumNotificationType_enum.memory_accepted,
    EnumNotificationType_enum.memory_declined,
    EnumNotificationType_enum.annoyance_check,
    EnumNotificationType_enum.plus_billing_issue,
    EnumNotificationType_enum.plus_coverage_ended,
  };

  test('every other server kind is known to the app', () {
    final known = [
      for (final value in EnumNotificationType_enum.values)
        if (value != EnumNotificationType_enum.$unknown && !notShown.contains(value))
          value.toModel(),
    ];

    expect(known, everyElement(isNotNull));
    expect(known.toSet(), NotificationKind.values.toSet());
  });

  test('a kind the backend added is left out until the app shows it', () {
    for (final value in notShown) {
      expect(value.toModel(), isNull);
    }
  });

  test('multi-word kinds map from their stored spelling', () {
    expect(EnumNotificationType_enum.card_received.toModel(), NotificationKind.cardReceived);
    expect(EnumNotificationType_enum.capsule_opened.toModel(), NotificationKind.capsuleOpened);
  });

  test('a kind this version does not know is left out', () {
    expect(EnumNotificationType_enum.$unknown.toModel(), isNull);
  });
}
