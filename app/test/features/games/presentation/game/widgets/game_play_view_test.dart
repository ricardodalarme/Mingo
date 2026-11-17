import 'package:app/features/games/data/models/game_item.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_play_view.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockGamesRepository() extends Mock implements GamesRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

class const _Harness() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final play = context.select((GameCubit cubit) => cubit.state.play);

    return switch (play) {
      Success(:final value) => GamePlayView(play: value),
      _ => const SizedBox.shrink(),
    };
  }
}

void main() {
  late GamesRepository repository;
  late ProfileRepository profileRepository;

  final fixedNow = DateTime(2026, 3, 10, 12);
  final created = fixedNow.subtract(const Duration(hours: 1));

  void testWithClock(String description, WidgetTesterCallback body) =>
      testWidgets(description, (tester) => withClock(Clock.fixed(fixedNow), () => body(tester)));

  const a = GameItem(slug: 'a', title: 'Pergunta A');
  const b = GameItem(slug: 'b', title: 'Pergunta B');
  const mission = GameItem(slug: 'm', title: 'Missão do encontro', body: 'Vejam fotos antigas.');
  const drink = GameItem(slug: 'h', title: 'Qual é a bebida favorita dele?');

  GameSession session({
    GameKind game = GameKind.meOrYou,
    GameStatus status = GameStatus.active,
    List<String> slugs = const ['a', 'b'],
    DateTime? at,
  }) => GameSession(
    id: 's1',
    game: game,
    status: status,
    invitedBy: 'me',
    itemSlugs: slugs,
    createdAt: at ?? created,
  );

  GamePlay gamePlay({
    GameKind kind = GameKind.meOrYou,
    GameSession? sessionOverride,
    List<GameItem> items = const [a, b],
    Map<int, String> own = const {},
    Map<int, String> partner = const {},
    List<GameItem> available = const [],
  }) => GamePlay(
    kind: kind,
    selfId: 'me',
    partnerName: 'Marina',
    session: sessionOverride ?? session(),
    items: items,
    own: own,
    partner: partner,
    available: available,
  );

  setUpAll(() {
    registerFallbackValue(GameKind.meOrYou);
    registerFallbackValue(session());
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  setUp(() {
    repository = _MockGamesRepository();
    when(() => repository.watchSessions()).thenAnswer((_) => const Stream.empty());
    profileRepository = _MockProfileRepository();
    when(() => profileRepository.getMySettings())
        .thenAnswer((_) async => const AccountSettings(theme: AppThemeVariant.rose));
    when(() => repository.finishIfComplete(any())).thenAnswer((_) async => null);
    when(
      () => repository.answer(
        session: any(named: 'session'),
        step: any(named: 'step'),
        answer: any(named: 'answer'),
      ),
    ).thenAnswer((_) async {
      return;
    });
  });

  Future<GameCubit> loaded(GamePlay play) async {
    when(
      () => repository.getPlay(
        kind: any(named: 'kind'),
        locale: any(named: 'locale'),
        now: any(named: 'now'),
      ),
    ).thenAnswer((_) async => play);
    final cubit = GameCubit(repository: repository, profileRepository: profileRepository);
    addTearDown(cubit.close);
    await cubit.load(play.kind);

    return cubit;
  }

  Future<void> pumpPlay(WidgetTester tester, GameCubit cubit) async {
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const _Harness()));
    await tester.pump();
  }

  Future<void> settle(WidgetTester tester) async {
    await tester.pump();
    await tester.pump();
  }

  Future<void> startRound(WidgetTester tester) async {
    await tester.tap(find.text('Começar'));
    await tester.pump();
  }

  testWithClock('pick shows the intro and the three answers of each phrase', (tester) async {
    final cubit = await loaded(gamePlay());

    await pumpPlay(tester, cubit);

    expect(find.text('Eu ou ele'), findsOneWidget);
    expect(find.text('8 perguntas · 3 min'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);

    await startRound(tester);

    expect(find.text('Pergunta 1 de 2'), findsOneWidget);
    expect(find.text('Pergunta A'), findsOneWidget);
    expect(find.text('Eu'), findsOneWidget);
    expect(find.text('Marina'), findsOneWidget);
    expect(find.text('Os dois'), findsOneWidget);
    expect(find.text('Cada um responde em privado. Pular é sempre permitido.'), findsOneWidget);
  });

  testWithClock('pick saves each answer as the person moves on', (tester) async {
    final cubit = await loaded(gamePlay());

    await pumpPlay(tester, cubit);
    await startRound(tester);

    await tester.tap(find.text('Marina'));
    await tester.pump();
    verifyNever(
      () => repository.answer(
        session: any(named: 'session'),
        step: any(named: 'step'),
        answer: any(named: 'answer'),
      ),
    );

    await tester.tap(find.text('Próxima'));
    await settle(tester);

    verify(
      () => repository.answer(
        session: any(named: 'session'),
        step: 0,
        answer: pickPartner,
      ),
    ).called(1);
    expect(find.text('Pergunta B'), findsOneWidget);

    await tester.tap(find.text('Os dois'));
    await tester.pump();
    await tester.tap(find.text('Próxima'));
    await settle(tester);

    verify(
      () => repository.answer(
        session: any(named: 'session'),
        step: 1,
        answer: pickBoth,
      ),
    ).called(1);
    expect(find.text('Terminei'), findsOneWidget);
  });

  testWithClock('going back after an answer shows the saved choice and the change note', (
    tester,
  ) async {
    final cubit = await loaded(gamePlay(own: const {0: pickSelf, 1: pickBoth}));

    await pumpPlay(tester, cubit);
    expect(find.text('Terminei'), findsOneWidget);

    cubit.previous();
    await settle(tester);

    expect(find.text('Pergunta B'), findsOneWidget);
    expect(
      find.text('Você pode mudar sua resposta até Marina responder esta pergunta.'),
      findsOneWidget,
    );
  });

  testWithClock('talk saves a written answer without a review screen', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.neverHaveWe,
        sessionOverride: session(game: GameKind.neverHaveWe),
      ),
    );

    await pumpPlay(tester, cubit);
    await startRound(tester);

    expect(find.text('Responder em privado, revelar juntos.'), findsOneWidget);
    await tester.enterText(find.byType(BaseTextArea), 'nunca fomos');
    await tester.pump();
    await tester.tap(find.text('Próxima'));
    await settle(tester);

    verify(
      () => repository.answer(
        session: any(named: 'session'),
        step: 0,
        answer: 'nunca fomos',
      ),
    ).called(1);
    expect(find.text('Pergunta B'), findsOneWidget);
  });

  testWithClock('talk can skip a question without an answer', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.neverHaveWe,
        sessionOverride: session(game: GameKind.neverHaveWe),
      ),
    );

    await pumpPlay(tester, cubit);
    await startRound(tester);

    await tester.tap(find.text('Pular'));
    await settle(tester);

    verify(
      () => repository.answer(
        session: any(named: 'session'),
        step: 0,
        answer: gameSkippedAnswer,
      ),
    ).called(1);
    expect(find.text('Pergunta B'), findsOneWidget);
  });

  testWithClock('guess answers about the person and then counts the guesses', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.howWell,
        sessionOverride: session(game: GameKind.howWell, slugs: const ['h', 'h']),
        items: const [drink, drink],
      ),
    );

    await pumpPlay(tester, cubit);
    await startRound(tester);

    expect(find.text('SOBRE VOCÊ'), findsOneWidget);
    expect(find.text('Pergunta 1 de 1'), findsOneWidget);

    await tester.enterText(find.byType(BaseTextArea), 'Café');
    await tester.pump();
    await tester.tap(find.text('Próxima'));
    await settle(tester);

    expect(find.text('SOBRE MARINA'), findsOneWidget);
    expect(find.text('Palpite 1 de 1'), findsOneWidget);
    expect(find.text('O que Marina respondeu?'), findsOneWidget);

    await tester.enterText(find.byType(BaseTextArea), 'Chá');
    await tester.pump();
    await tester.tap(find.text('Próximo'));
    await settle(tester);

    verify(
      () => repository.answer(
        session: any(named: 'session'),
        step: 0,
        answer: 'Café',
      ),
    ).called(1);
    verify(
      () => repository.answer(
        session: any(named: 'session'),
        step: 1,
        answer: 'Chá',
      ),
    ).called(1);
    expect(find.text('Terminei'), findsOneWidget);
  });

  testWithClock('date accepts the mission and saves the reflection', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.mission,
        sessionOverride: session(game: GameKind.mission, slugs: const ['m']),
        items: const [mission],
      ),
    );

    await pumpPlay(tester, cubit);
    await startRound(tester);

    expect(find.text('MISSÃO'), findsOneWidget);
    expect(find.text('Missão do encontro'), findsOneWidget);
    expect(find.text('Aceitar'), findsOneWidget);

    await tester.tap(find.text('Aceitar'));
    await tester.pump();

    expect(find.text('Como foi?'), findsOneWidget);
    expect(find.text('Foi ótimo'), findsOneWidget);

    await tester.tap(find.text('Foi ótimo'));
    await tester.pump();
    await tester.tap(find.text('Salvar'));
    await settle(tester);

    verify(
      () => repository.answer(
        session: any(named: 'session'),
        step: 0,
        answer: 'great',
      ),
    ).called(1);
    expect(find.text('Terminei'), findsOneWidget);
  });

  testWithClock('waiting closes and checks again', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.neverHaveWe,
        sessionOverride: session(game: GameKind.neverHaveWe),
        own: const {0: 'nunca fomos', 1: gameSkippedAnswer},
      ),
    );

    await pumpPlay(tester, cubit);

    expect(find.text('Terminei'), findsOneWidget);
    expect(
      find.text('Agora é a vez de Marina. Você vê o resultado quando os dois terminarem.'),
      findsOneWidget,
    );
    expect(find.text('Fechar'), findsOneWidget);

    await tester.tap(find.text('Ver se já terminou'));
    await settle(tester);

    verify(
      () => repository.getPlay(
        kind: any(named: 'kind'),
        locale: any(named: 'locale'),
        now: any(named: 'now'),
      ),
    ).called(2);
  });

  testWithClock('a locked answer shows the honest reason instead of an editor', (tester) async {
    const locked = LocalizedException(l10nKey: gameAnswerLockedCode);
    when(
      () => repository.answer(
        session: any(named: 'session'),
        step: 0,
        answer: any(named: 'answer'),
      ),
    ).thenThrow(locked);
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.neverHaveWe,
        sessionOverride: session(game: GameKind.neverHaveWe),
        own: const {0: 'nunca fomos'},
      ),
    );
    cubit.previous();
    await tester.pump();

    await pumpPlay(tester, cubit);
    cubit.onDraftChanged('outra resposta');
    await cubit.submit();
    await tester.pump();

    expect(
      find.text('Este jogo já foi fechado. Esta resposta não pode mais ser editada.'),
      findsOneWidget,
    );
    expect(find.text('outra resposta'), findsNothing);
  });

  testWithClock('finished pick reveals the agreement count and both choices', (tester) async {
    final cubit = await loaded(
      gamePlay(
        sessionOverride: session(status: GameStatus.finished),
        own: const {0: pickSelf, 1: pickBoth},
        partner: const {0: pickPartner, 1: pickBoth},
      ),
    );

    await pumpPlay(tester, cubit);

    expect(find.textContaining('Vocês concordaram em'), findsOneWidget);
    expect(find.text('2 de 2'), findsOneWidget);
    expect(find.text('As diferenças viram assunto, não placar.'), findsOneWidget);
    expect(find.text('Pergunta A'), findsOneWidget);
    expect(find.text('Os dois disseram: Você'), findsOneWidget);
    expect(find.text('Encerrar o jogo'), findsNothing);
  });

  testWithClock('finished guess shows the discoveries of each side', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.howWell,
        sessionOverride: session(
          game: GameKind.howWell,
          status: GameStatus.finished,
          slugs: const ['h', 'h'],
        ),
        items: const [drink, drink],
        own: const {0: 'Café', 1: 'Café'},
        partner: const {0: 'Chá', 1: 'Café'},
      ),
    );

    await pumpPlay(tester, cubit);

    expect(find.text('Descobertas'), findsWidgets);
    expect(find.text('VOCÊ NÃO SABIA'), findsOneWidget);
    expect(find.text('Marina respondeu: Chá'), findsOneWidget);
    expect(find.textContaining(RegExp(r'\d+ (pontos|%)|ranking|sequência')), findsNothing);
  });

  testWithClock('finished talk shows both answers side by side', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.neverHaveWe,
        sessionOverride: session(
          game: GameKind.neverHaveWe,
          status: GameStatus.finished,
          slugs: const ['a'],
        ),
        items: const [a],
        own: const {0: 'nunca fomos'},
        partner: const {0: 'já fomos'},
      ),
    );

    await pumpPlay(tester, cubit);

    expect(find.text('Pronto'), findsWidgets);
    expect(find.text('Você respondeu 1 pergunta. Sem vencedor, sem pontuação.'), findsOneWidget);
    expect(find.text('nunca fomos'), findsOneWidget);
    expect(find.text('já fomos'), findsOneWidget);
  });

  testWithClock('finished date shows both reflections', (tester) async {
    final cubit = await loaded(
      gamePlay(
        kind: GameKind.mission,
        sessionOverride: session(
          game: GameKind.mission,
          status: GameStatus.finished,
          slugs: const ['m'],
        ),
        items: const [mission],
        own: const {0: 'great'},
        partner: const {0: 'ok'},
      ),
    );

    await pumpPlay(tester, cubit);

    expect(find.text('Foi ótimo'), findsOneWidget);
    expect(find.text('Foi ok'), findsOneWidget);
    expect(find.text('Encerrar o jogo'), findsNothing);
  });

  testWithClock('a cancelled session explains itself on the start screen', (tester) async {
    final cubit = await loaded(
      gamePlay(
        sessionOverride: session(status: GameStatus.cancelled),
        available: const [a],
      ),
    );

    await pumpPlay(tester, cubit);

    expect(find.textContaining('O último convite foi cancelado'), findsOneWidget);
  });

  testWithClock('an expired invitation explains itself on the start screen', (tester) async {
    final cubit = await loaded(
      gamePlay(
        sessionOverride: session(
          status: GameStatus.invited,
          at: fixedNow.subtract(const Duration(hours: 49)),
        ),
        available: const [a],
      ),
    );

    await pumpPlay(tester, cubit);

    expect(find.textContaining('O convite anterior expirou'), findsOneWidget);
  });
}
