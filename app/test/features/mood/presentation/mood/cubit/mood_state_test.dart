import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('clearMood and clearNeed drop the selection', () {
    const state = MoodState(mood: MoodKind.happy, need: NeedKind.hug);

    final cleared = state.copyWith(clearMood: true, clearNeed: true);

    expect(cleared.mood, isNull);
    expect(cleared.need, isNull);
  });

  test('clearPartnerName drops the partner name', () {
    const state = MoodState(partnerName: 'Bia');

    expect(state.copyWith(clearPartnerName: true).partnerName, isNull);
  });

  test('clearPartnerMood drops the shared mood', () {
    final state = MoodState(
      partnerMood: PartnerMood(day: DateTime(2026, 11, 10), mood: MoodKind.tired),
    );

    expect(state.copyWith(clearPartnerMood: true).partnerMood, isNull);
  });

  test('changing the share keeps the mood and need', () {
    const state = MoodState(mood: MoodKind.happy, need: NeedKind.hug);

    final updated = state.copyWith(share: MoodShare.mood);

    expect(updated.mood, MoodKind.happy);
    expect(updated.need, NeedKind.hug);
  });

  test('the audience is always private without a partner', () {
    const shared = MoodState(share: MoodShare.moodNeed, hasPartner: true);
    expect(shared.audience, MoodShare.moodNeed);

    final alone = shared.copyWith(hasPartner: false);
    expect(alone.audience, MoodShare.none);
    expect(alone.share, MoodShare.moodNeed);
  });

  test('the saved audience comes from the row, not from a choice in progress', () {
    final entry = MoodEntry(
      id: 'm1',
      day: DateTime(2026, 11, 10),
      mood: MoodKind.happy,
      share: MoodShare.mood,
    );
    final state = MoodState(
      entry: Success<MoodEntry?>(entry),
      hasPartner: true,
      share: MoodShare.none,
    );

    expect(state.savedAudience, MoodShare.mood);

    expect(state.copyWith(hasPartner: false).savedAudience, MoodShare.none);
    expect(const MoodState().savedAudience, MoodShare.none);
  });

  test('canSave needs a mood and a need when both are shared', () {
    expect(const MoodState().canSave, isFalse);

    const moodOnly = MoodState(mood: MoodKind.happy, share: MoodShare.mood);
    expect(moodOnly.canSave, isTrue);

    const missingNeed = MoodState(mood: MoodKind.happy, share: MoodShare.moodNeed);
    expect(missingNeed.canSave, isFalse);

    const withNeed = MoodState(
      mood: MoodKind.happy,
      need: NeedKind.listen,
      share: MoodShare.moodNeed,
    );
    expect(withNeed.canSave, isTrue);
  });
}
