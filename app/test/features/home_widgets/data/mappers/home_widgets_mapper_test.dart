import 'package:app/features/distance/data/models/distance_info.dart';
import 'package:app/features/home_widgets/data/data_sources/remote/queries/generated/HomeWidgetOverview.graphql.dart';
import 'package:app/features/home_widgets/data/mappers/home_widgets_mapper.dart';
import 'package:app/features/home_widgets/data/models/home_widget_card_state.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:design_system/design_system.dart' show AppThemeVariant;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 11, 11, 12);

  QueryHomeWidgetOverview response({
    bool paired = true,
    int unopenedCards = 0,
    String theme = 'rosa',
    List<Map<String, dynamic>> milestones = const [],
    List<Map<String, dynamic>> partnerMood = const [],
    List<Map<String, dynamic>> rituals = const [],
  }) => QueryHomeWidgetOverview.fromJson(<String, dynamic>{
    'today': <dynamic>[
      <String, dynamic>{
        'userId': 'profile-1',
        'coupleId': paired ? 'couple-1' : null,
        'partnerName': 'Sam',
        'togetherSince': '2024-02-14',
        'cardId': 'card-1',
        'unopenedCards': unopenedCards,
        'slipsThisWeek': 2,
        'slipDays': <dynamic>['2026-11-09', '2026-11-10'],
        'nextDateOn': '2026-12-01',
        'nextDate': <String, dynamic>{'title': 'Aniversário', '__typename': 'ImportantDates'},
        '__typename': 'Today',
      },
    ],
    'me': <String, dynamic>{'displayName': 'Alex', '__typename': 'profiles'},
    'settings': <String, dynamic>{
      'userId': 'profile-1',
      'theme': theme,
      'togetherSince': '2024-02-14',
      '__typename': 'userSettings',
    },
    'notificationSettingsByPk': <String, dynamic>{
      'cardDay': 0,
      'cardHour': 18,
      '__typename': 'notificationSettings',
    },
    'milestones': milestones,
    'partnerNote': <dynamic>[
      <String, dynamic>{
        'body': 'Jantar hoje?',
        'createdAt': '2026-11-11T09:00:00.000Z',
        '__typename': 'partnerMessages',
      },
    ],
    'partnerMood': partnerMood,
    'partnerMiss': <dynamic>[],
    'rituals': rituals,
    'idea': <dynamic>[
      <String, dynamic>{
        'slug': 'bilhete',
        'title': 'Deixe um bilhete',
        '__typename': 'dailyContent',
      },
    ],
    '__typename': 'query_root',
  });

  test('the people, the dates and the theme come across', () {
    final payload = response().toPayload(now: now);

    expect(payload.isPaired, isTrue);
    expect(payload.ownName, 'Alex');
    expect(payload.partnerName, 'Sam');
    expect(payload.togetherSince, '2024-02-14');
    expect(payload.nextDateTitle, 'Aniversário');
    expect(payload.nextDateOn, '2026-12-01');
    expect(payload.theme, AppThemeVariant.rose);
    expect(payload.dailyIdeaTitle, 'Deixe um bilhete');
    expect(payload.slipsThisWeek, 2);
    expect(payload.slipDays, ['2026-11-09', '2026-11-10']);
  });

  test('each server theme maps to the matching variant', () {
    expect(response(theme: 'azul').toPayload(now: now).theme, AppThemeVariant.blue);
    expect(response(theme: 'neutro').toPayload(now: now).theme, AppThemeVariant.neutral);
  });

  test('without a couple the partner fields are cleared', () {
    final payload = response(paired: false).toPayload(now: now);

    expect(payload.isPaired, isFalse);
    expect(payload.partnerName, isNull);
    expect(payload.partnerNote, isNull);
  });

  test('a shared partner mood and the note arrive with their times', () {
    final payload = response(
      partnerMood: [
        <String, dynamic>{
          'mood': 'loving',
          'updatedAt': '2026-11-11T10:00:00.000Z',
          '__typename': 'sharedMoods',
        },
      ],
    ).toPayload(now: now);

    expect(payload.partnerMood, MoodKind.loving);
    expect(payload.partnerMoodAt, '2026-11-11T10:00:00.000Z');
    expect(payload.partnerNote, 'Jantar hoje?');
    expect(payload.partnerNoteAt, '2026-11-11T09:00:00.000Z');
  });

  test('the ritual keeps its weekday and a trimmed HH:mm time', () {
    final payload = response(
      rituals: [
        <String, dynamic>{
          'id': 'ritual-1',
          'title': 'Caminhada',
          'weekday': 7,
          'atTime': '10:00:00',
          '__typename': 'rituals',
        },
      ],
    ).toPayload(now: now);

    expect(payload.ritualTitle, 'Caminhada');
    expect(payload.ritualWeekday, 7);
    expect(payload.ritualTime, '10:00');
  });

  test('milestones are listed oldest first', () {
    final payload = response(
      milestones: [
        <String, dynamic>{
          'id': 'b',
          'title': 'Moramos juntos',
          'happenedOn': '2025-06-01',
          '__typename': 'storyEvents',
        },
        <String, dynamic>{
          'id': 'a',
          'title': 'Primeiro beijo',
          'happenedOn': '2024-03-01',
          '__typename': 'storyEvents',
        },
      ],
    ).toPayload(now: now);

    expect(payload.milestones.map((milestone) => milestone.title), [
      'Primeiro beijo',
      'Moramos juntos',
    ]);
  });

  group('card state', () {
    test('an unopened card is ready', () {
      expect(response(unopenedCards: 1).toPayload(now: now).cardState, HomeWidgetCardState.ready);
    });

    test('a sent card is sent and a held one is ready', () {
      expect(
        response().toPayload(cardStatus: 'sent', now: now).cardState,
        HomeWidgetCardState.sent,
      );
      expect(
        response().toPayload(cardStatus: 'held', now: now).cardState,
        HomeWidgetCardState.ready,
      );
    });

    test('no card means none, and the send day and hour follow the notification settings', () {
      final payload = response().toPayload(now: now);

      expect(payload.cardState, HomeWidgetCardState.none);
      expect(payload.cardSendDay, 0);
      expect(payload.cardSendHour, 18);
    });
  });

  test('the distance carries both zones and the reunion date', () {
    final payload = response().toPayload(
      distance: DistanceInfo(
        own: ZoneClock(zone: 'America/Sao_Paulo', time: DateTime(2026, 11, 11, 9)),
        partner: ZoneClock(zone: 'Europe/Lisbon', time: DateTime(2026, 11, 11, 12)),
        nextReunion: DateTime(2026, 12, 23),
        reunionTitle: 'Viagem',
      ),
      now: now,
    );

    expect(payload.ownZone, 'America/Sao_Paulo');
    expect(payload.partnerZone, 'Europe/Lisbon');
    expect(payload.reunionOn, '2026-12-23');
    expect(payload.reunionTitle, 'Viagem');
  });
}
