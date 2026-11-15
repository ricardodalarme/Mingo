import 'package:app/router/observers/analytics_router_observer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('relationship and grief routes report a generic settings screen', () {
    expect(analyticsScreenNameFor('RelationshipChangedRoute'), 'settings');
    expect(analyticsScreenNameFor('GriefSupportRoute'), 'settings');
    expect(analyticsScreenNameFor('RelationshipRoute'), 'settings');
    expect(analyticsScreenNameFor('UnpairRoute'), 'settings');
    expect(analyticsScreenNameFor('UsRoute'), 'settings');
    expect(analyticsScreenNameFor('TouchRoute'), 'settings');
    expect(analyticsScreenNameFor('CapsulesRoute'), 'settings');
    expect(analyticsScreenNameFor('GuidesRoute'), 'settings');
    expect(analyticsScreenNameFor('GuideRoute'), 'settings');
    expect(analyticsScreenNameFor('DistanceRoute'), 'settings');
    expect(analyticsScreenNameFor('CheckinRoute'), 'settings');
  });

  test('cycle, mood and fight screens stay out of analytics', () {
    expect(analyticsScreenNameFor('HeavyDayRoute'), 'settings');
    expect(analyticsScreenNameFor('SensitiveDaysRoute'), 'settings');
    expect(analyticsScreenNameFor('MoodRoute'), 'settings');
    expect(analyticsScreenNameFor('NeedRoute'), 'settings');
    expect(analyticsScreenNameFor('FightStyleRoute'), 'settings');
    expect(analyticsScreenNameFor('SafeModeRoute'), 'settings');
  });

  test('ordinary routes keep their name and missing names stay empty', () {
    expect(analyticsScreenNameFor('HomeRoute'), 'HomeRoute');
    expect(analyticsScreenNameFor(null), isNull);
  });
}
