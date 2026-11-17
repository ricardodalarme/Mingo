import 'package:app/features/notifications/data/mappers/notification_preferences_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('the stored choices become the preferences', () {
    final preferences = (
      isEnabled: false,
      mutedTypes: {'card_sent', 'spice_invite'},
      cardDay: 6,
      cardHour: 20,
      dailyMax: 2,
    ).toModel();

    expect(preferences.isEnabled, isFalse);
    expect(preferences.mutedTypes, {'card_sent', 'spice_invite'});
    expect(preferences.cardDay, 6);
    expect(preferences.cardHour, 20);
    expect(preferences.dailyMax, 2);
  });

  test('no muted type means every type is on', () {
    final preferences = (
      isEnabled: true,
      mutedTypes: <String>{},
      cardDay: 0,
      cardHour: 9,
      dailyMax: 3,
    ).toModel();

    expect(preferences.mutedTypes, isEmpty);
  });
}
