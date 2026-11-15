import 'dart:async';

import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/mood/presentation/mood/widgets/today_mood_block.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  late MoodRepository repository;
  late SlipRepository slips;

  final day = DateTime(2026, 11, 10);
  final entry = MoodEntry(
    id: 'm1',
    day: day,
    mood: MoodKind.tired,
    need: NeedKind.hug,
    share: MoodShare.mood,
  );
  MoodToday today({MoodEntry? value, PartnerMood? partner, String? partnerName = 'Marina'}) =>
      (entry: value, partnerMood: partner, partnerName: partnerName);

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockMoodRepository();
    slips = _MockSlipRepository();
    when(() => repository.readCachedTodayMood()).thenReturn(null);
    when(() => repository.getTodayMood()).thenAnswer((_) async => today(value: entry));
    when(() => slips.sendHug()).thenAnswer((_) async {});
  });

  MoodCubit build() {
    final cubit = MoodCubit(moodRepository: repository, slipRepository: slips);
    addTearDown(cubit.close);

    return cubit;
  }

  Future<void> pumpBlock(
    WidgetTester tester,
    MoodCubit cubit, {
    bool isDiscreet = false,
    bool isFirstDay = false,
    bool isPaused = false,
  }) async {
    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: TodayMoodBlock(isDiscreet: isDiscreet, isFirstDay: isFirstDay, isPaused: isPaused),
      ),
    );
    await tester.pump();
  }

  testWidgets('paints the mood strip without waiting for the home query', (tester) async {
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);

    expect(find.text('Como você está?'), findsOneWidget);
    expect(find.text('Tenso'), findsOneWidget);
  });

  testWidgets('shows the mood cached on the device while the read is in flight', (tester) async {
    final pending = Completer<MoodToday>();
    when(() => repository.readCachedTodayMood()).thenReturn(entry);
    when(() => repository.getTodayMood()).thenAnswer((_) => pending.future);
    final cubit = build();

    unawaited(cubit.load());
    await pumpBlock(tester, cubit);

    expect(find.text('Como você está?'), findsOneWidget);
    expect(
      find.byWidgetPredicate((widget) => widget is Skeletonizer && widget.enabled),
      findsNothing,
    );

    pending.complete(today(value: entry));
  });

  testWidgets('with nothing cached the strip starts as a skeleton', (tester) async {
    final pending = Completer<MoodToday>();
    when(() => repository.getTodayMood()).thenAnswer((_) => pending.future);
    final cubit = build();

    unawaited(cubit.load());
    await pumpBlock(tester, cubit);

    expect(
      find.byWidgetPredicate((widget) => widget is Skeletonizer && widget.enabled),
      findsOneWidget,
    );

    pending.complete(today(value: entry));
  });

  testWidgets("shows the partner's shared mood from the same read", (tester) async {
    when(() => repository.getTodayMood()).thenAnswer(
      (_) async => today(
        partner: PartnerMood(day: day, mood: MoodKind.stressed),
      ),
    );
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);

    expect(find.textContaining('Marina está com a cabeça cheia'), findsOneWidget);
  });

  testWidgets('the heart sends a hug back for a good mood', (tester) async {
    when(() => repository.getTodayMood()).thenAnswer(
      (_) async => today(
        partner: PartnerMood(day: day, mood: MoodKind.happy),
      ),
    );
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);
    await tester.tap(find.byIcon(AppIcons.heart_filled));
    await tester.pump();
    await tester.pump();

    verify(() => slips.sendHug()).called(1);
    expect(find.text('Coração enviado'), findsOneWidget);
  });

  testWidgets('discreet mode hides the partner mood', (tester) async {
    when(() => repository.getTodayMood()).thenAnswer(
      (_) async => today(
        partner: PartnerMood(day: day, mood: MoodKind.stressed),
      ),
    );
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit, isDiscreet: true);

    expect(find.textContaining('Marina'), findsNothing);
  });

  testWidgets('a paused day keeps the strip off the screen', (tester) async {
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit, isPaused: true);

    expect(find.text('Como você está?'), findsNothing);
  });

  testWidgets('the first day keeps the strip off the screen', (tester) async {
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit, isFirstDay: true);

    expect(find.text('Como você está?'), findsNothing);
  });
}
