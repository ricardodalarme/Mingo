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

    test('discreet mode clears the card state', () {
      final payload = WidgetPayload.fake().copyWith(discreet: true, cardState: 'ready');

      final sanitized = payload.sanitized(referenceNow: now);

      expect(sanitized.discreet, isTrue);
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
      expect(payload.copyWith(discreet: true).sanitized(referenceNow: now).cachedPhotoPath, isNull);
      expect(
        payload.copyWith(isSignedIn: false).sanitized(referenceNow: now).cachedPhotoPath,
        isNull,
      );
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
