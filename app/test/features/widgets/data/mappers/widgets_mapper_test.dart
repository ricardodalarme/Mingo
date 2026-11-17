import 'package:app/features/distance/data/models/distance_info.dart';
import 'package:app/features/widgets/data/data_sources/remote/queries/generated/WidgetOverview.graphql.dart';
import 'package:app/features/widgets/data/mappers/widgets_mapper.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 11, 11, 12);

  Map<String, dynamic> settings() => <String, dynamic>{
    'userId': 'profile-1',
    'phase': 'dating',
    'togetherSince': '2024-02-14',
    'partnerName': 'Redacted',
    'relationshipStatus': 'together',
    'widgetAllowPartnerNotes': true,
    'widgetOnLockScreen': false,
    'widgetShowNames': true,
    '__typename': 'UserSettings',
  };

  QueryWidgetOverview response({
    Map<String, dynamic>? settingsJson,
    List<Map<String, dynamic>> partnerNote = const [],
    List<Map<String, dynamic>> plus = const [],
    bool paired = true,
  }) => QueryWidgetOverview.fromJson(<String, dynamic>{
    'today': <dynamic>[
      <String, dynamic>{
        'userId': 'profile-1',
        'localDate': '2026-11-11',
        'coupleId': paired ? 'couple-1' : null,
        'partnerId': 'profile-2',
        'partnerName': 'Marina',
        'togetherSince': '2024-02-14',
        'cardId': 'card-1',
        'unopenedCards': 0,
        'slipsThisWeek': 2,
        'slipsTotal': 9,
        'slipDays': <dynamic>['2026-11-09', '2026-11-10', '2026-11-11'],
        'nextDateOn': '2026-12-01',
        'nextDate': <String, dynamic>{'title': 'Aniversário', '__typename': 'ImportantDates'},
        '__typename': 'Today',
      },
    ],
    'settings': settingsJson ?? settings(),
    'notificationSettingsByPk': <String, dynamic>{
      'cardDay': 6,
      'cardHour': 18,
      '__typename': 'notificationSettings',
    },
    'me': <String, dynamic>{'displayName': 'Luanna', '__typename': 'profiles'},
    'plusStates': plus,
    'partnerNote': partnerNote,
    'partnerMood': <dynamic>[],
    'partnerMiss': <dynamic>[],
    'myMood': <dynamic>[],
    'rituals': <dynamic>[],
    'idea': <dynamic>[],
    '__typename': 'Query',
  });

  WidgetOverview map(QueryWidgetOverview value, {String? cardStatus, DistanceInfo? distance}) =>
      value.toModel(
        contentSource: WidgetContentSource.favorites,
        rotationCadence: WidgetRotationCadence.daily,
        cardStatus: cardStatus,
        distance: distance,
        now: now,
      );

  test('partner name and date come from today', () {
    final overview = map(response());

    expect(overview.payload.partnerName, 'Marina');
    expect(overview.payload.nextDateTitle, 'Aniversário');
    expect(overview.payload.isPaired, isTrue);
    expect(overview.payload.togetherSince, '2024-02-14');
  });

  test('missing settings fail closed for names and notes', () {
    final overview =
        QueryWidgetOverview.fromJson(<String, dynamic>{
          'today': <dynamic>[
            <String, dynamic>{
              'userId': 'profile-1',
              'coupleId': 'couple-1',
              'partnerName': 'Marina',
              '__typename': 'Today',
            },
          ],
          'plusStates': <dynamic>[],
          'partnerNote': <dynamic>[],
          'partnerMood': <dynamic>[],
          'partnerMiss': <dynamic>[],
          'myMood': <dynamic>[],
          'rituals': <dynamic>[],
          'idea': <dynamic>[],
          '__typename': 'Query',
        }).toModel(
          contentSource: WidgetContentSource.favorites,
          rotationCadence: WidgetRotationCadence.daily,
          now: now,
        );

    expect(overview.preferences.showNames, isFalse);
    expect(overview.preferences.allowPartnerNotes, isFalse);
    expect(overview.payload.partnerName, isNull);
  });

  test('Plus comes from the plus state row', () {
    final withoutPlus = map(response());
    final withPlus = map(
      response(
        plus: <Map<String, dynamic>>[
          <String, dynamic>{'hasPlus': true, '__typename': 'PlusStates'},
        ],
      ),
    );

    expect(withoutPlus.payload.hasPlus, isFalse);
    expect(withPlus.payload.hasPlus, isTrue);
  });

  test('the card state reads the card status and the unopened count', () {
    expect(map(response(), cardStatus: 'sent').payload.cardState, 'sent');
    expect(map(response(), cardStatus: 'held').payload.cardState, 'ready');
    expect(map(response(), cardStatus: 'draft').payload.cardState, 'ready');
    expect(map(response()).payload.cardState, 'none');
  });

  test('the partner note comes from the latest partner message for the widget', () {
    final overview = map(
      response(
        partnerNote: <Map<String, dynamic>>[
          <String, dynamic>{
            'body': 'Boa sorte na reunião!',
            'kind': 'note',
            'mediaFileId': null,
            'createdAt': '2026-11-11T09:00:00.000Z',
            '__typename': 'PartnerMessages',
          },
        ],
      ),
    );

    expect(overview.payload.partnerNote, 'Boa sorte na reunião!');
    expect(overview.payload.partnerNoteAt, '2026-11-11T09:00:00.000Z');
  });

  test('an unpaired person never gets a partner name', () {
    expect(map(response(paired: false)).payload.partnerName, isNull);
  });

  test('partner mood and the miss signal carry their timestamps', () {
    final overview =
        QueryWidgetOverview.fromJson(<String, dynamic>{
          'today': <dynamic>[
            <String, dynamic>{
              'userId': 'profile-1',
              'coupleId': 'couple-1',
              'partnerName': 'Marina',
              '__typename': 'Today',
            },
          ],
          'settings': settings(),
          'plusStates': <dynamic>[],
          'partnerNote': <dynamic>[],
          'partnerMood': <dynamic>[
            <String, dynamic>{
              'mood': 'loving',
              'updatedAt': '2026-11-11T10:00:00.000Z',
              '__typename': 'sharedMoods',
            },
          ],
          'partnerMiss': <dynamic>[
            <String, dynamic>{'createdAt': '2026-11-11T08:00:00.000Z', '__typename': 'signals'},
          ],
          'myMood': <dynamic>[],
          'rituals': <dynamic>[],
          'idea': <dynamic>[],
          '__typename': 'Query',
        }).toModel(
          contentSource: WidgetContentSource.favorites,
          rotationCadence: WidgetRotationCadence.daily,
          now: now,
        );

    expect(overview.payload.partnerMood, 'loving');
    expect(overview.payload.partnerMoodAt, '2026-11-11T10:00:00.000Z');
    expect(overview.payload.partnerMissedAt, '2026-11-11T08:00:00.000Z');
  });

  test('the week count and slip days stay separate from the total', () {
    final payload = map(response()).payload;

    expect(payload.slipsCount, 9);
    expect(payload.slipsThisWeek, 2);
    expect(payload.slipDays, ['2026-11-09', '2026-11-10', '2026-11-11']);
  });

  test('the card send day and hour come from the notification settings', () {
    final payload = map(response()).payload;

    expect(payload.cardSendDay, 6);
    expect(payload.cardSendHour, 18);
  });

  test('the distance clocks come from the distance repository', () {
    final payload = map(response(), distance: DistanceInfo.fake()).payload;

    expect(payload.hasDistance, isTrue);
    expect(payload.ownZone, 'America/Sao_Paulo');
    expect(payload.partnerZone, 'Europe/Lisbon');
    expect(payload.ownLocalTime, '19:40');
    expect(payload.partnerLocalTime, '22:40');
    expect(payload.reunionDays, 42);
  });

  test('hidden names and notes never reach the payload', () {
    final overview = map(
      response(
        settingsJson: <String, dynamic>{
          'userId': 'profile-1',
          'phase': 'dating',
          'widgetAllowPartnerNotes': false,
          'widgetOnLockScreen': false,
          'widgetShowNames': false,
          '__typename': 'UserSettings',
        },
        partnerNote: <Map<String, dynamic>>[
          <String, dynamic>{
            'body': 'Boa sorte na reunião!',
            'kind': 'note',
            'mediaFileId': null,
            'createdAt': '2026-11-11T09:00:00.000Z',
            '__typename': 'PartnerMessages',
          },
        ],
      ),
    );

    expect(overview.payload.partnerName, isNull);
    expect(overview.payload.ownName, isNull);
    expect(overview.payload.partnerNote, isNull);
  });
}
