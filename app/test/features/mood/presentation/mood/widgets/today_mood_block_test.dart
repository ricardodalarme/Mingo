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
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockStackRouter() extends Mock implements StackRouter;

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

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(MoodKind.happy);
    registerFallbackValue(MoodShare.none);
    registerFallbackValue(NeedKind.hug);
    registerFallbackValue(MoodRoute());
  });

  setUp(() {
    repository = _MockMoodRepository();
    slips = _MockSlipRepository();
    when(() => repository.readCachedTodayMood()).thenReturn(null);
    when(() => repository.getTodayMood()).thenAnswer((_) async => today(value: entry));
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((invocation) async {
      final mood = invocation.namedArguments[#mood] as MoodKind;
      final need = invocation.namedArguments[#need] as NeedKind?;
      final share = invocation.namedArguments[#share] as MoodShare;

      return MoodEntry(id: 'm1', day: day, mood: mood, need: need, share: share);
    });
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

  testWidgets('the need entry shows the need already asked for', (tester) async {
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);

    expect(find.text('Preciso de: Um abraço'), findsOneWidget);
  });

  testWidgets('the need entry invites a need when the day has none', (tester) async {
    when(() => repository.getTodayMood()).thenAnswer((_) async => today());
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);

    expect(find.text('Preciso de…'), findsOneWidget);
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

  testWidgets('one tap on a face saves the mood and marks it', (tester) async {
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);
    await tester.tap(find.text('Bem'));
    await tester.pump();
    await tester.pump();

    verify(
      () => repository.saveMood(mood: MoodKind.happy, need: NeedKind.hug, share: MoodShare.mood),
    ).called(1);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is BaseFace && widget.selected && widget.kind == FaceKind.good,
      ),
      findsOneWidget,
    );
  });

  testWidgets('tapping the face already saved writes nothing', (tester) async {
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);
    await tester.tap(find.text('Cansado'));
    await tester.pump();

    verifyNever(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    );
  });

  testWidgets('a failed save puts the face back and says it failed', (tester) async {
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        need: any(named: 'need'),
        share: any(named: 'share'),
      ),
    ).thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);
    await tester.tap(find.text('Bem'));
    await tester.pump();
    await tester.pump();

    expect(cubit.state.mood, MoodKind.tired);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is BaseFace && widget.selected && widget.kind == FaceKind.tired,
      ),
      findsOneWidget,
    );
    expect(
      find.text('Não deu para salvar seu humor. Verifique a conexão e tente de novo.'),
      findsOneWidget,
    );
  });

  testWidgets('the block link opens the mood page for the share choice', (tester) async {
    final router = _MockStackRouter();
    when(() => router.push<Object?>(any(), onFailure: any(named: 'onFailure')))
        .thenAnswer((_) async => null);
    final cubit = build();
    await cubit.load();

    await tester.pumpApp(
      StackRouterScope(
        controller: router,
        stateHash: 0,
        child: BlocProvider.value(value: cubit, child: const TodayMoodBlock(isDiscreet: false)),
      ),
    );

    await tester.tap(find.text('O que seu par vê'));
    await tester.pump();

    final route = verify(
      () => router.push<Object?>(captureAny(), onFailure: any(named: 'onFailure')),
    ).captured.single;
    expect(route, isA<MoodRoute>());
  });

  testWidgets('asking to talk sends one ask and confirms it', (tester) async {
    when(() => repository.getTodayMood()).thenAnswer(
      (_) async => today(
        partner: PartnerMood(day: day, mood: MoodKind.sad),
      ),
    );
    when(() => slips.askToTalk()).thenAnswer((_) async {});
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);
    await tester.tap(find.textContaining('para baixo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Perguntar se quer conversar'));
    await tester.pumpAndSettle();

    verify(() => slips.askToTalk()).called(1);
    expect(find.text('Pergunta enviada'), findsOneWidget);
  });

  testWidgets('a failed ask reports it and stays honest', (tester) async {
    when(() => repository.getTodayMood()).thenAnswer(
      (_) async => today(
        partner: PartnerMood(day: day, mood: MoodKind.sad),
      ),
    );
    when(() => slips.askToTalk()).thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);
    await tester.tap(find.textContaining('para baixo'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Perguntar se quer conversar'));
    await tester.pumpAndSettle();

    expect(
      find.text('Não deu para enviar agora. Verifique a conexão e tente de novo.'),
      findsOneWidget,
    );
  });

  testWidgets('the help sheet sends the short message with its copy', (tester) async {
    when(() => repository.getTodayMood()).thenAnswer(
      (_) async => today(
        partner: PartnerMood(day: day, mood: MoodKind.tired),
      ),
    );
    when(() => slips.sendSweetMessage(any())).thenAnswer((_) async {});
    final cubit = build();
    await cubit.load();

    await pumpBlock(tester, cubit);
    await tester.tap(find.textContaining('sem energia'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mandar uma mensagem curta e carinhosa'));
    await tester.pumpAndSettle();

    verify(() => slips.sendSweetMessage('Sem pressa. Estou por aqui.')).called(1);
    expect(find.text('Mensagem enviada'), findsOneWidget);
  });
}
