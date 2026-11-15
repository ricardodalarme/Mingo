import 'package:app/features/games/data/models/game_item.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_review_view.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockGamesRepository() extends Mock implements GamesRepository;

class _MockProfileRepository() extends Mock implements ProfileRepository;

void main() {
  late GamesRepository repository;
  late ProfileRepository profileRepository;

  final created = DateTime(2026, 3, 10, 12);
  const locked = LocalizedException(l10nKey: gameAnswerLockedCode);

  const a = GameItem(slug: 'a', title: 'Pergunta A');
  const b = GameItem(slug: 'b', title: 'Pergunta B');

  GamePlay gamePlay({Map<int, String> own = const {}}) => GamePlay(
    kind: GameKind.neverHaveWe,
    selfId: 'me',
    partnerName: 'Marina',
    session: GameSession(
      id: 's1',
      game: GameKind.neverHaveWe,
      status: GameStatus.active,
      invitedBy: 'me',
      itemSlugs: const ['a', 'b'],
      createdAt: created,
    ),
    items: const [a, b],
    own: own,
  );

  setUpAll(() {
    registerFallbackValue(GameKind.meOrYou);
    registerFallbackValue(
      GameSession(
        id: 's1',
        game: GameKind.neverHaveWe,
        status: GameStatus.active,
        invitedBy: 'me',
        createdAt: created,
      ),
    );
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  setUp(() {
    repository = _MockGamesRepository();
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

  Future<void> pumpReview(WidgetTester tester, GameCubit cubit, GamePlay play) async {
    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: GameReviewView(play: play),
      ),
    );
    await tester.pump();
  }

  testWidgets('lists every answer of the round and opens one to edit', (tester) async {
    final cubit = await loaded(gamePlay(own: const {0: 'nunca fomos', 1: 'já fomos'}));
    cubit.review();
    final play = cubit.state.current!;

    await pumpReview(tester, cubit, play);

    expect(find.text('Revisar respostas'), findsOneWidget);
    expect(find.text('Pergunta A'), findsOneWidget);
    expect(find.text('nunca fomos'), findsOneWidget);
    expect(find.text('Pergunta B'), findsOneWidget);
    expect(find.text('já fomos'), findsOneWidget);
    expect(find.text('Enviar respostas'), findsOneWidget);

    await tester.tap(find.text('Pergunta A'));
    await tester.pump();

    expect(cubit.state.step, 0);
    expect(cubit.state.isReviewing, isFalse);
    expect(cubit.state.draft, 'nunca fomos');
  });

  testWidgets('a skipped answer reads as no answer', (tester) async {
    final cubit = await loaded(gamePlay(own: const {0: gameSkippedAnswer, 1: 'já fomos'}));
    cubit.review();

    await pumpReview(tester, cubit, cubit.state.current!);

    expect(find.text('Sem resposta'), findsOneWidget);
    expect(find.text(gameSkippedAnswer), findsNothing);
  });

  testWidgets('a locked answer renders read-only with the reason', (tester) async {
    when(
      () => repository.answer(
        session: any(named: 'session'),
        step: 0,
        answer: any(named: 'answer'),
      ),
    ).thenThrow(locked);
    final cubit = await loaded(gamePlay(own: const {0: 'nunca fomos', 1: 'já fomos'}));
    cubit
      ..editStep(0)
      ..onDraftChanged('outra resposta')
      ..submit();
    await cubit.send();
    final play = cubit.state.current!;

    await pumpReview(tester, cubit, play);

    expect(find.text('Fechado'), findsOneWidget);
    expect(
      find.text('Este jogo já foi fechado. Esta resposta não pode mais ser editada.'),
      findsOneWidget,
    );
    expect(find.text('nunca fomos'), findsOneWidget);
    expect(find.text('outra resposta'), findsNothing);

    await tester.tap(find.text('Pergunta A'));
    await tester.pump();

    expect(cubit.state.isReviewing, isTrue);
    expect(cubit.state.step, 1);
  });
}
