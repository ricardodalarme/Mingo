import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/presentation/need_sheet/cubit/need_sheet_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  NeedSheetCubit build({MoodKind? mood, NeedKind? need, MoodShare share = MoodShare.none}) =>
      NeedSheetCubit()..start(mood: mood, need: need, share: share);

  test('starts from the mood, need and audience already on screen', () {
    final cubit = build(mood: MoodKind.happy, need: NeedKind.chocolate, share: MoodShare.moodNeed);
    addTearDown(cubit.close);

    expect(cubit.state.mood, MoodKind.happy);
    expect(cubit.state.need, NeedKind.chocolate);
    expect(cubit.state.share, MoodShare.moodNeed);
  });

  test('tapping the selected need clears it', () {
    final cubit = build(mood: MoodKind.happy, need: NeedKind.chocolate);
    addTearDown(cubit.close);

    cubit.selectNeed(NeedKind.chocolate);

    expect(cubit.state.need, isNull);
  });

  test('a chosen need replaces the previous one', () {
    final cubit = build(mood: MoodKind.happy, need: NeedKind.chocolate);
    addTearDown(cubit.close);

    cubit.selectNeed(NeedKind.foreheadKiss);

    expect(cubit.state.need, NeedKind.foreheadKiss);
  });

  test('submitting without a mood hands back nothing', () {
    final cubit = build(need: NeedKind.hug);
    addTearDown(cubit.close);

    expect(cubit.state.canSave, isFalse);
    expect(cubit.submit(), isNull);
  });

  test('a mood and a need become the draft to save', () {
    final cubit = build(mood: MoodKind.tired);
    addTearDown(cubit.close);

    cubit.selectNeed(NeedKind.cuteMessage);
    final draft = cubit.submit();

    expect(draft?.mood, MoodKind.tired);
    expect(draft?.need, NeedKind.cuteMessage);
  });
}
