import 'package:app/features/home_widgets/data/models/home_widget_card_state.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:design_system/design_system.dart' show AppThemeVariant;
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 11, 11, 12);

  HomeWidgetPayload payload({
    bool isPaired = true,
    String? nextDateOn,
    String? reunionOn,
    String? partnerZone,
  }) => HomeWidgetPayload(
    isSignedIn: true,
    isPaired: isPaired,
    updatedAt: '2026-11-11T12:00:00.000Z',
    partnerName: ' Sam ',
    partnerNote: 'Jantar hoje?',
    partnerNoteAt: '2026-11-11T09:00:00.000Z',
    partnerMood: MoodKind.loving,
    partnerMoodAt: '2026-11-11T10:00:00.000Z',
    partnerMissedAt: '2026-11-10T22:00:00.000Z',
    nextDateTitle: 'Aniversário',
    nextDateOn: nextDateOn,
    ownZone: 'America/Sao_Paulo',
    partnerZone: partnerZone,
    reunionTitle: 'Viagem',
    reunionOn: reunionOn,
    togetherSince: '2024-02-14',
  );

  group('sanitized', () {
    test('a signed-out payload keeps nothing', () {
      final cleaned = const HomeWidgetPayload(
        isSignedIn: false,
        isPaired: true,
        updatedAt: '',
        ownName: 'Alex',
      ).sanitized(referenceNow: now);

      expect(cleaned.isSignedIn, isFalse);
      expect(cleaned.ownName, isNull);
    });

    test('without a partner every partner field is cleared', () {
      final cleaned = payload(
        isPaired: false,
        partnerZone: 'Europe/Lisbon',
        reunionOn: '2026-12-23',
      ).sanitized(referenceNow: now);

      expect(cleaned.partnerName, isNull);
      expect(cleaned.partnerNote, isNull);
      expect(cleaned.partnerNoteAt, isNull);
      expect(cleaned.partnerMood, isNull);
      expect(cleaned.partnerMoodAt, isNull);
      expect(cleaned.partnerMissedAt, isNull);
      expect(cleaned.partnerZone, isNull);
      expect(cleaned.reunionOn, isNull);
    });

    test('with a partner it trims the name and keeps what the partner shared', () {
      final cleaned = payload().sanitized(referenceNow: now);

      expect(cleaned.partnerName, 'Sam');
      expect(cleaned.partnerNote, 'Jantar hoje?');
      expect(cleaned.partnerMood, MoodKind.loving);
    });

    test('a date that already passed is dropped with its title', () {
      final cleaned = payload(nextDateOn: '2026-11-10').sanitized(referenceNow: now);

      expect(cleaned.nextDateOn, isNull);
      expect(cleaned.nextDateTitle, isNull);
    });

    test('today still counts as an upcoming date', () {
      final cleaned = payload(nextDateOn: '2026-11-11').sanitized(referenceNow: now);

      expect(cleaned.nextDateOn, '2026-11-11');
      expect(cleaned.daysUntilNextDateOn(now), 0);
    });

    test('the same time zone for both people means no distance', () {
      final cleaned = payload(partnerZone: 'America/Sao_Paulo').sanitized(referenceNow: now);

      expect(cleaned.partnerZone, isNull);
      expect(cleaned.hasDistance, isFalse);
    });

    test('different zones keep the distance and a future reunion', () {
      final cleaned = payload(
        partnerZone: 'Europe/Lisbon',
        reunionOn: '2026-12-23',
      ).sanitized(referenceNow: now);

      expect(cleaned.hasDistance, isTrue);
      expect(cleaned.daysUntilReunionOn(now), 42);
    });

    test('blank milestone titles are dropped', () {
      final cleaned = const HomeWidgetPayload(
        isSignedIn: true,
        isPaired: true,
        updatedAt: '',
        milestones: [
          HomeWidgetMilestone(title: ' ', on: '2025-01-01'),
          HomeWidgetMilestone(title: 'Moramos juntos', on: '2025-06-01'),
        ],
      ).sanitized(referenceNow: now);

      expect(cleaned.milestones.map((milestone) => milestone.title), ['Moramos juntos']);
    });
  });

  group('json', () {
    test('round-trips every field', () {
      final original = HomeWidgetPayload.fake();

      expect(HomeWidgetPayload.fromJsonString(original.toJsonString()), original);
    });

    test('unknown enum values fall back to safe defaults', () {
      final decoded = HomeWidgetPayload.fromJson(<String, dynamic>{
        'isSignedIn': true,
        'theme': 'purple',
        'cardState': 'weird',
        'partnerMood': 'furious',
      });

      expect(decoded.theme, AppThemeVariant.rose);
      expect(decoded.cardState, HomeWidgetCardState.none);
      expect(decoded.partnerMood, isNull);
    });

    test('text that is not a payload decodes as signed out', () {
      expect(HomeWidgetPayload.fromJsonString('[]').isSignedIn, isFalse);
    });
  });

  group('days', () {
    test('days together count whole days at local midnight', () {
      final value = payload();

      expect(value.daysTogetherOn(DateTime(2026, 11, 11, 23, 59)), 1001);
      expect(value.daysTogetherOn(DateTime(2024, 2, 14)), 0);
    });

    test('days together never go negative', () {
      expect(payload().daysTogetherOn(DateTime(2020)), 0);
    });

    test('the duration splits into years, months and days', () {
      final duration = payload().durationOn(DateTime(2026, 11, 11));

      expect(duration, (years: 2, months: 8, days: 28));
    });

    test('no date means no counter', () {
      const value = HomeWidgetPayload(isSignedIn: true, isPaired: false, updatedAt: '');

      expect(value.daysTogetherOn(now), isNull);
      expect(value.durationOn(now), isNull);
    });
  });
}
