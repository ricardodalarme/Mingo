import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:flutter_test/flutter_test.dart';

/// The keys the Swift and Kotlin widgets decode; adding or renaming one is a contract change.
const _nativeKeys = {
  'isSignedIn',
  'isPaired',
  'updatedAt',
  'theme',
  'ownName',
  'partnerName',
  'togetherSince',
  'milestones',
  'nextDateTitle',
  'nextDateOn',
  'cardState',
  'cardSendDay',
  'cardSendHour',
  'partnerNote',
  'partnerNoteAt',
  'partnerMood',
  'partnerMoodAt',
  'partnerMissedAt',
  'ritualTitle',
  'ritualWeekday',
  'ritualTime',
  'dailyIdeaTitle',
  'slipsThisWeek',
  'slipDays',
  'ownZone',
  'partnerZone',
  'reunionTitle',
  'reunionOn',
};

void main() {
  test('the payload writes exactly the keys the native widgets read', () {
    expect(HomeWidgetPayload.fake().toJson().keys.toSet(), _nativeKeys);
  });

  test('the payload carries facts only: dates, zones and enum names, never display text', () {
    final json = HomeWidgetPayload.fake().toJson();

    expect(json['theme'], 'rose');
    expect(json['cardState'], 'ready');
    expect(json['partnerMood'], 'loving');
    expect(json['ritualTime'], matches(RegExp(r'^\d{2}:\d{2}$')));
    expect(json['togetherSince'], matches(RegExp(r'^\d{4}-\d{2}-\d{2}$')));
  });

  test('the signed-out payload holds no personal field', () {
    final json = HomeWidgetPayload.signedOut().toJson();

    expect(json['isSignedIn'], isFalse);
    for (final key in ['ownName', 'partnerName', 'partnerNote', 'togetherSince', 'ritualTitle']) {
      expect(json[key], isNull, reason: key);
    }
  });
}
