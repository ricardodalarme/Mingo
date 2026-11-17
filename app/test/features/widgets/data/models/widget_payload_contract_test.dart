import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const expectedKeys = <String>{
    'isSignedIn',
    'isPaired',
    'hasPlus',
    'showNames',
    'allowPartnerNotes',
    'onLockScreen',
    'isOffline',
    'togetherSince',
    'relationshipPhase',
    'partnerName',
    'ownName',
    'nextDateTitle',
    'nextDateOn',
    'unopenedCards',
    'cardState',
    'partnerNote',
    'partnerNoteMedia',
    'partnerNoteAt',
    'partnerMood',
    'partnerMoodAt',
    'partnerMissedAt',
    'myMood',
    'ritualTitle',
    'ritualSchedule',
    'dailyIdeaTitle',
    'slipsCount',
    'slipsThisWeek',
    'slipDays',
    'cardSendDay',
    'cardSendHour',
    'suggestionKey',
    'cachedPhotoPath',
    'ownZone',
    'partnerZone',
    'ownLocalTime',
    'partnerLocalTime',
    'reunionTitle',
    'reunionOn',
    'reunionDays',
    'updatedAt',
  };

  test('the JSON contract keeps every key the native payloads decode', () {
    expect(WidgetPayload.fake().toJson().keys.toSet(), expectedKeys);
  });

  test('a signed-out payload keeps the contract but no personal values', () {
    final json = WidgetPayload.signedOut().toJson();

    expect(json.keys.toSet(), expectedKeys);
    expect(json['isSignedIn'], isFalse);
    expect(json['partnerName'], isNull);
    expect(json['ownName'], isNull);
    expect(json['partnerNote'], isNull);
    expect(json['partnerMood'], isNull);
    expect(json['partnerMoodAt'], isNull);
    expect(json['partnerMissedAt'], isNull);
    expect(json['cachedPhotoPath'], isNull);
    expect(json['partnerZone'], isNull);
    expect(json['reunionDays'], isNull);
    expect(json['slipDays'], isEmpty);
  });

  test('an unpaired payload keeps personal widgets and clears couple values', () {
    final json = WidgetPayload.fake()
        .copyWith(isPaired: false)
        .sanitized(referenceNow: DateTime.utc(2026, 11, 11, 12))
        .toJson();

    expect(json['partnerName'], isNull);
    expect(json['partnerNote'], isNull);
    expect(json['partnerMood'], isNull);
    expect(json['partnerMissedAt'], isNull);
    expect(json['cardState'], 'none');
    expect(json['cardSendDay'], isNull);
    expect(json['partnerZone'], isNull);
    expect(json['slipsThisWeek'], 3);
  });

  test('the names and notes gates are applied before the native write', () {
    final json = WidgetPayload.fake()
        .copyWith(showNames: false, allowPartnerNotes: false)
        .sanitized(referenceNow: DateTime.utc(2026, 11, 11, 12))
        .toJson();

    expect(json['showNames'], isFalse);
    expect(json['allowPartnerNotes'], isFalse);
    expect(json['partnerName'], isNull);
    expect(json['ownName'], isNull);
    expect(json['partnerNote'], isNull);
    expect(json['partnerNoteMedia'], isNull);
    expect(json['partnerNoteAt'], isNull);
  });

  test('the distance keys survive only for two different zones', () {
    final visible = WidgetPayload.fake()
        .sanitized(referenceNow: DateTime.utc(2026, 11, 11, 12))
        .toJson();
    final sameZone = WidgetPayload.fake()
        .copyWith(partnerZone: 'America/Sao_Paulo')
        .sanitized(referenceNow: DateTime.utc(2026, 11, 11, 12))
        .toJson();

    expect(visible['partnerZone'], 'Europe/Lisbon');
    expect(visible['ownLocalTime'], '19:40');
    expect(visible['partnerLocalTime'], '22:40');
    expect(visible['reunionDays'], 42);
    expect(sameZone['partnerZone'], isNull);
    expect(sameZone['ownLocalTime'], isNull);
    expect(sameZone['reunionDays'], isNull);
  });
}
