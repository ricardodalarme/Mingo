import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime.utc(2026, 11, 11, 12);

  group('WidgetPayload privacy', () {
    test('an unpaired payload clears the card state', () {
      final payload = WidgetPayload.fake().copyWith(isPaired: false, cardState: 'ready');

      final sanitized = payload.sanitized(referenceNow: now);

      expect(sanitized.isPaired, isFalse);
      expect(sanitized.cardState, 'none');
    });

    test('stored payloads without privacy flags fail closed', () {
      final payload = WidgetPayload.fromJson(const <String, dynamic>{
        'isSignedIn': true,
        'isPaired': true,
      });

      expect(payload.showNames, isFalse);
      expect(payload.allowPartnerNotes, isFalse);
    });

    test('a cached photo survives only when paired and Plus', () {
      const path = '/tmp/mingo_widget_photo.jpg';
      final payload = WidgetPayload.fake().copyWith(cachedPhotoPath: path);

      expect(payload.sanitized(referenceNow: now).cachedPhotoPath, path);
      expect(
        payload.copyWith(isPaired: false).sanitized(referenceNow: now).cachedPhotoPath,
        isNull,
      );
      expect(payload.copyWith(hasPlus: false).sanitized(referenceNow: now).cachedPhotoPath, isNull);
      expect(
        payload.copyWith(isSignedIn: false).sanitized(referenceNow: now).cachedPhotoPath,
        isNull,
      );
    });
  });

  group('WidgetPayload family visibility', () {
    final paired = WidgetPayload.fake().copyWith(
      partnerName: 'Marina',
      ownName: 'Luanna',
      partnerNote: 'Boa sorte!',
      partnerMood: 'loving',
      partnerMoodAt: '2026-11-11T10:00:00.000Z',
      partnerMissedAt: '2026-11-11T09:00:00.000Z',
      partnerZone: 'Europe/Lisbon',
      ownZone: 'America/Sao_Paulo',
      ownLocalTime: '19:40',
      partnerLocalTime: '22:40',
    );

    test('names are gated by the names setting', () {
      final visible = paired.sanitized(referenceNow: now);
      final hidden = paired.copyWith(showNames: false).sanitized(referenceNow: now);

      expect(visible.visiblePartnerName, 'Marina');
      expect(visible.visibleOwnName, 'Luanna');
      expect(hidden.visiblePartnerName, isNull);
      expect(hidden.visibleOwnName, isNull);
    });

    test('notes are gated by the notes setting', () {
      expect(paired.sanitized(referenceNow: now).visiblePartnerNote, 'Boa sorte!');
      expect(
        paired.copyWith(allowPartnerNotes: false).sanitized(referenceNow: now).visiblePartnerNote,
        isNull,
      );
    });

    test('the partner mood needs a pair and a shared mood', () {
      expect(paired.sanitized(referenceNow: now).visiblePartnerMood, MoodKind.loving);
      expect(
        paired.copyWith(isPaired: false).sanitized(referenceNow: now).visiblePartnerMood,
        isNull,
      );
      expect(
        paired.copyWith(partnerMood: 'unknown').sanitized(referenceNow: now).visiblePartnerMood,
        isNull,
      );
    });

    test('the distance is only kept when both zones differ', () {
      final visible = paired.sanitized(referenceNow: now);
      final sameZone = paired
          .copyWith(partnerZone: 'America/Sao_Paulo')
          .sanitized(referenceNow: now);

      expect(visible.hasDistance, isTrue);
      expect(visible.partnerZone, 'Europe/Lisbon');
      expect(sameZone.hasDistance, isFalse);
      expect(sameZone.partnerZone, isNull);
      expect(paired.copyWith(isPaired: false).sanitized(referenceNow: now).hasDistance, isFalse);
    });
  });

  group('WidgetPayload relationship phase', () {
    test('is stored by its enum name and read back', () {
      final payload = WidgetPayload.fake().copyWith(
        relationshipPhase: RelationshipPhase.livingTogether,
      );

      expect(payload.toJson()['relationshipPhase'], 'livingTogether');
      expect(
        WidgetPayload.fromJson(payload.toJson()).relationshipPhase,
        RelationshipPhase.livingTogether,
      );
    });

    test('a phase this version does not know reads as none', () {
      final json = WidgetPayload.fake().toJson()..['relationshipPhase'] = 'living_together';

      expect(WidgetPayload.fromJson(json).relationshipPhase, isNull);
    });
  });
}
