import 'dart:async';

import 'package:app/features/games/data/models/game_item.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGamesRepository() extends Mock implements GamesRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

void main() {
  late GamesRepository repository;
  late ProfileRepository profileRepository;
  late StreamController<List<GameSession>> sessions;

  final created = DateTime(2026, 3, 10, 12);
  const failure = LocalizedException(l10nKey: 'other');
  const alreadyOpen = LocalizedException(l10nKey: 'GAME_ALREADY_OPEN');
  const locked = LocalizedException(l10nKey: gameAnswerLockedCode);

  GameSession session({GameStatus status = GameStatus.invited, String invitedBy = 'partner'}) =>
      GameSession(
        id: 's1',
        game: GameKind.meOrYou,
        status: status,
        invitedBy: invitedBy,
        itemSlugs: const ['a', 'b'],
        createdAt: created,
      );

  const items = [GameItem(slug: 'a', title: 'A?'), GameItem(slug: 'b', title: 'B?')];

  GamePlay fresh() => const GamePlay(kind: GameKind.meOrYou, selfId: 'me', available: items);

  GamePlay invited() =>
      GamePlay(kind: GameKind.meOrYou, selfId: 'me', session: session(), items: items);

  GamePlay active({Map<int, String> own = const {}, Map<int, String> partner = const {}}) =>
      GamePlay(
        kind: GameKind.meOrYou,
        selfId: 'me',
        session: session(status: GameStatus.active),
        items: items,
        own: own,
        partner: partner,
      );

  GameCubit build() {
    final cubit = GameCubit(repository: repository, profileRepository: profileRepository);
    addTearDown(cubit.close);

    return cubit;
  }

  setUpAll(() {
    registerFallbackValue(GameKind.meOrYou);
    registerFallbackValue(fresh());
    registerFallbackValue(session());
  });

  setUp(() {
    repository = _MockGamesRepository();
    profileRepository = _MockProfileRepository();
    when(() => profileRepository.getMySettings())
        .thenAnswer((_) async => const AccountSettings(theme: AppThemeVariant.rose));
    sessions = StreamController<List<GameSession>>.broadcast();
    addTearDown(sessions.close);
    when(() => repository.watchSessions()).thenAnswer((_) => sessions.stream);
    when(() => repository.finishIfComplete(any())).thenAnswer((_) async => null);
    when(
      () => repository.getPlay(
        kind: any(named: 'kind'),
        locale: any(named: 'locale'),
        now: any(named: 'now'),
      ),
    ).thenAnswer((_) async => fresh());
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

  group('live session', () {
    test('reads the game again when the partner accepts the invitation', () async {
      final plays = [invited(), active()];
      when(
        () => repository.getPlay(
          kind: any(named: 'kind'),
          locale: any(named: 'locale'),
          now: any(named: 'now'),
        ),
      ).thenAnswer((_) async => plays.removeAt(0));
      final cubit = build();
      await cubit.load(GameKind.meOrYou);

      sessions.add([session(status: GameStatus.active)]);
      await pumpEventQueue();

      expect(cubit.state.current?.session?.status, GameStatus.active);
    });

    test('does not read the game again when the session did not change', () async {
      when(
        () => repository.getPlay(
          kind: any(named: 'kind'),
          locale: any(named: 'locale'),
          now: any(named: 'now'),
        ),
      ).thenAnswer((_) async => invited());
      final cubit = build();
      await cubit.load(GameKind.meOrYou);

      sessions.add([session()]);
      await pumpEventQueue();

      verify(() => repository.getPlay(kind: GameKind.meOrYou, locale: 'pt-BR')).called(1);
    });

    test('stops listening when the cubit closes', () async {
      final cubit = build();
      await cubit.load(GameKind.meOrYou);

      await cubit.close();

      expect(sessions.hasListener, isFalse);
    });
  });

  test('starts loading', () {
    expect(build().state, const GameState());
    expect(const GameState().play, const Loading());
  });

  blocTest<GameCubit, GameState>(
    'loads the game in the person language',
    build: build,
    act: (cubit) => cubit.load(GameKind.meOrYou),
    expect: () => [const GameState(), GameState(play: Success(fresh()))],
    verify: (_) =>
        verify(() => repository.getPlay(kind: GameKind.meOrYou, locale: 'pt-BR')).called(1),
  );

  blocTest<GameCubit, GameState>(
    'a failed first read ends in a failure the page can retry',
    build: () {
      when(
        () => repository.getPlay(
          kind: any(named: 'kind'),
          locale: any(named: 'locale'),
          now: any(named: 'now'),
        ),
      ).thenThrow(failure);

      return build();
    },
    act: (cubit) => cubit.load(GameKind.meOrYou),
    expect: () => [const GameState(), const GameState(play: Failure(failure))],
  );

  blocTest<GameCubit, GameState>(
    'a failed refresh keeps the game that is already on screen',
    build: build,
    seed: () => GameState(play: Success(fresh())),
    act: (cubit) async {
      await cubit.load(GameKind.meOrYou);
      when(
        () => repository.getPlay(
          kind: any(named: 'kind'),
          locale: any(named: 'locale'),
          now: any(named: 'now'),
        ),
      ).thenThrow(failure);
      await cubit.refresh();
    },
    verify: (cubit) => expect(cubit.state.play, isA<Success<GamePlay>>()),
  );

  blocTest<GameCubit, GameState>(
    'invites the partner and then reads the waiting session',
    build: () {
      when(() => repository.invite(any())).thenAnswer((_) async => session(invitedBy: 'me'));

      return build();
    },
    seed: () => GameState(play: Success(fresh())),
    act: (cubit) async {
      await cubit.load(GameKind.meOrYou);
      when(
        () => repository.getPlay(
          kind: any(named: 'kind'),
          locale: any(named: 'locale'),
          now: any(named: 'now'),
        ),
      ).thenAnswer(
        (_) async => GamePlay(
          kind: GameKind.meOrYou,
          selfId: 'me',
          session: session(invitedBy: 'me'),
          items: items,
        ),
      );
      await cubit.invite();
    },
    verify: (cubit) {
      verify(() => repository.invite(any())).called(1);
      expect(cubit.state.current?.stage(created), GameStage.waiting);
      expect(cubit.state.action, const Initial());
    },
  );

  test('checking again shows a loading action while it reads', () async {
    final cubit = build();
    await cubit.load(GameKind.meOrYou);
    final states = <GameState>[];
    final subscription = cubit.stream.listen(states.add);

    await cubit.checkAgain();
    await subscription.cancel();

    expect(states.first.action, const Loading());
    expect(cubit.state.action, const Initial());
    verify(
      () => repository.getPlay(
        kind: GameKind.meOrYou,
        locale: any(named: 'locale'),
        now: any(named: 'now'),
      ),
    ).called(2);
  });

  blocTest<GameCubit, GameState>(
    'does not invite when the game has no content',
    build: build,
    seed: () => const GameState(
      play: Success(GamePlay(kind: GameKind.twentyQuestions, selfId: 'me')),
    ),
    act: (cubit) => cubit.invite(),
    expect: () => <GameState>[],
    verify: (_) => verifyNever(() => repository.invite(any())),
  );

  blocTest<GameCubit, GameState>(
    'accepting the invitation joins the session',
    build: () {
      when(() => repository.join(any()))
          .thenAnswer((_) async => session(status: GameStatus.active));

      return build();
    },
    seed: () => GameState(play: Success(invited())),
    act: (cubit) => cubit.join(),
    verify: (_) => verify(() => repository.join(any())).called(1),
  );

  blocTest<GameCubit, GameState>(
    'cancelling ends the open session',
    build: () {
      when(() => repository.cancel(any()))
          .thenAnswer((_) async => session(status: GameStatus.cancelled));

      return build();
    },
    seed: () => GameState(play: Success(invited())),
    act: (cubit) => cubit.cancel(),
    verify: (_) => verify(() => repository.cancel(any())).called(1),
  );

  blocTest<GameCubit, GameState>(
    'a failed cancel reports the failure once and keeps the game',
    build: () {
      when(() => repository.cancel(any())).thenThrow(failure);

      return build();
    },
    seed: () => GameState(play: Success(invited())),
    act: (cubit) => cubit.cancel(),
    expect: () => [
      GameState(play: Success(invited()), action: const Loading()),
      GameState(play: Success(invited()), action: const Failure(failure)),
      GameState(play: Success(invited())),
    ],
  );

  blocTest<GameCubit, GameState>(
    'ignores a second tap while an action is running',
    build: build,
    seed: () => GameState(play: Success(invited()), action: const Loading()),
    act: (cubit) => cubit.cancel(),
    expect: () => <GameState>[],
    verify: (_) => verifyNever(() => repository.cancel(any())),
  );

  blocTest<GameCubit, GameState>(
    'keeps the draft for the current step',
    build: build,
    seed: () => GameState(play: Success(active())),
    act: (cubit) => cubit.onDraftChanged('oi'),
    expect: () => [GameState(play: Success(active()), draft: 'oi')],
  );

  blocTest<GameCubit, GameState>(
    'ignores a draft while an action is running',
    build: build,
    seed: () => GameState(play: Success(active()), action: const Loading()),
    act: (cubit) => cubit.onDraftChanged('oi'),
    expect: () => <GameState>[],
  );

  blocTest<GameCubit, GameState>(
    'choosing an option keeps it as the draft until the person moves on',
    build: build,
    seed: () => GameState(play: Success(active()), step: 0),
    act: (cubit) => cubit.choose(pickSelf),
    expect: () => [GameState(play: Success(active()), step: 0, draft: pickSelf)],
    verify: (_) => verifyNever(
      () => repository.answer(
        session: any(named: 'session'),
        step: any(named: 'step'),
        answer: any(named: 'answer'),
      ),
    ),
  );

  blocTest<GameCubit, GameState>(
    'saves the draft as the answer and moves on',
    build: build,
    seed: () => GameState(play: Success(active()), step: 0, draft: pickSelf),
    act: (cubit) => cubit.submit(),
    verify: (cubit) {
      verify(
        () => repository.answer(
          session: any(named: 'session'),
          step: 0,
          answer: pickSelf,
        ),
      ).called(1);
      expect(cubit.state.step, 1);
      expect(cubit.state.answers, const {0: pickSelf});
      expect(cubit.state.action, const Initial());
    },
  );

  blocTest<GameCubit, GameState>(
    'does not submit an empty draft',
    build: build,
    seed: () => GameState(play: Success(active()), step: 0),
    act: (cubit) => cubit.submit(),
    expect: () => <GameState>[],
    verify: (_) => verifyNever(
      () => repository.answer(
        session: any(named: 'session'),
        step: any(named: 'step'),
        answer: any(named: 'answer'),
      ),
    ),
  );

  blocTest<GameCubit, GameState>(
    'skips the current step with the stored skip answer',
    build: build,
    seed: () => GameState(play: Success(active()), step: 0, draft: 'rascunho'),
    act: (cubit) => cubit.skip(),
    verify: (cubit) {
      verify(
        () => repository.answer(
          session: any(named: 'session'),
          step: 0,
          answer: gameSkippedAnswer,
        ),
      ).called(1);
      expect(cubit.state.answers, const {0: gameSkippedAnswer});
      expect(cubit.state.step, 1);
    },
  );

  blocTest<GameCubit, GameState>(
    'a failed answer reports the failure and keeps the draft',
    build: () {
      when(
        () => repository.answer(
          session: any(named: 'session'),
          step: 0,
          answer: any(named: 'answer'),
        ),
      ).thenThrow(failure);

      return build();
    },
    seed: () => GameState(play: Success(active()), step: 0, draft: pickSelf),
    act: (cubit) => cubit.submit(),
    verify: (cubit) {
      expect(cubit.state.step, 0);
      expect(cubit.state.draft, pickSelf);
      expect(cubit.state.answers.containsKey(0), isFalse);
      expect(cubit.state.action, const Initial());
    },
  );

  blocTest<GameCubit, GameState>(
    'a locked answer is reported and kept read-only with the stored answer',
    build: () {
      when(
        () => repository.answer(
          session: any(named: 'session'),
          step: 0,
          answer: any(named: 'answer'),
        ),
      ).thenThrow(locked);

      return build();
    },
    seed: () => GameState(
      play: Success(active(own: const {0: pickSelf})),
      answers: const {0: pickPartner},
      step: 0,
      draft: pickPartner,
    ),
    act: (cubit) => cubit.submit(),
    verify: (cubit) {
      expect(cubit.state.lockedSteps, const {0});
      expect(cubit.state.answers[0], pickSelf);
      expect(cubit.state.isLocked, isTrue);
      expect(cubit.state.action, const Initial());
    },
  );

  blocTest<GameCubit, GameState>(
    'going back opens the answer already saved',
    build: build,
    seed: () => GameState(
      play: Success(active(own: const {0: pickSelf})),
      answers: const {0: pickSelf},
      step: 1,
    ),
    act: (cubit) => cubit.previous(),
    expect: () => [
      GameState(
        play: Success(active(own: const {0: pickSelf})),
        answers: const {0: pickSelf},
        step: 0,
        draft: pickSelf,
      ),
    ],
  );

  blocTest<GameCubit, GameState>(
    'going back from the first question returns to the game intro',
    build: build,
    seed: () =>
        GameState(play: Success(active()), answers: const {0: pickSelf}, step: 0, draft: pickSelf),
    act: (cubit) => cubit.previous(),
    verify: (cubit) {
      expect(cubit.state.step, -1);
      expect(cubit.state.isIntro, isTrue);
      expect(cubit.state.answers, const {0: pickSelf});
    },
  );

  blocTest<GameCubit, GameState>(
    'going back while waiting opens the last answer',
    build: build,
    seed: () => GameState(
      play: Success(active(own: const {0: pickSelf, 1: pickPartner})),
      answers: const {0: pickSelf, 1: pickPartner},
      step: 2,
    ),
    act: (cubit) => cubit.previous(),
    verify: (cubit) {
      expect(cubit.state.step, 1);
      expect(cubit.state.draft, pickPartner);
    },
  );

  blocTest<GameCubit, GameState>(
    'the last answer opens the wait for the partner',
    build: build,
    seed: () => GameState(
      play: Success(active(own: const {0: pickSelf})),
      answers: const {0: pickSelf},
      step: 1,
      draft: pickPartner,
    ),
    act: (cubit) => cubit.submit(),
    verify: (cubit) {
      verify(
        () => repository.answer(
          session: any(named: 'session'),
          step: 1,
          answer: pickPartner,
        ),
      ).called(1);
      expect(cubit.state.current?.isOwnDone, isTrue);
      expect(cubit.state.step, 2);
      expect(cubit.state.draft, isEmpty);
    },
  );

  final ownDone = active(own: const {0: pickSelf, 1: pickPartner});
  final finished = GamePlay(
    kind: GameKind.meOrYou,
    selfId: 'me',
    session: session(status: GameStatus.finished),
    items: items,
    own: const {0: pickSelf, 1: pickPartner},
    partner: const {0: pickPartner, 1: pickSelf},
  );

  blocTest<GameCubit, GameState>(
    'finishes once both answered and reads the reveal',
    build: () {
      var reads = 0;
      when(
        () => repository.getPlay(
          kind: any(named: 'kind'),
          locale: any(named: 'locale'),
          now: any(named: 'now'),
        ),
      ).thenAnswer((_) async => reads++ == 0 ? ownDone : finished);
      when(() => repository.finishIfComplete(any()))
          .thenAnswer((_) async => session(status: GameStatus.finished));

      return build();
    },
    act: (cubit) => cubit.load(GameKind.meOrYou),
    expect: () => [
      const GameState(),
      GameState(play: Success(finished), answers: const {0: pickSelf, 1: pickPartner}, step: 2),
    ],
    verify: (cubit) {
      verify(() => repository.finishIfComplete(any())).called(1);
      expect(cubit.state.current?.stage(created), GameStage.finished);
    },
  );

  blocTest<GameCubit, GameState>(
    'stays waiting when the partner has not answered everything',
    build: () {
      when(
        () => repository.getPlay(
          kind: any(named: 'kind'),
          locale: any(named: 'locale'),
          now: any(named: 'now'),
        ),
      ).thenAnswer((_) async => ownDone);

      return build();
    },
    act: (cubit) => cubit.load(GameKind.meOrYou),
    expect: () => [
      const GameState(),
      GameState(play: Success(ownDone), answers: const {0: pickSelf, 1: pickPartner}, step: 2),
    ],
    verify: (cubit) {
      verify(() => repository.finishIfComplete(any())).called(1);
      expect(cubit.state.current?.stage(created), GameStage.waitingForPartner);
    },
  );

  blocTest<GameCubit, GameState>(
    'reports GAME_ALREADY_OPEN when an invite is blocked',
    build: () {
      when(() => repository.invite(any())).thenThrow(alreadyOpen);

      return build();
    },
    seed: () => GameState(play: Success(fresh())),
    act: (cubit) => cubit.invite(),
    expect: () => [
      GameState(play: Success(fresh()), action: const Loading()),
      GameState(play: Success(fresh()), action: const Failure(alreadyOpen)),
      GameState(play: Success(fresh())),
    ],
    verify: (_) => verify(() => repository.invite(any())).called(1),
  );
}
