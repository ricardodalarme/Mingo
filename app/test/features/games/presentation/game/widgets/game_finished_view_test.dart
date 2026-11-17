import 'package:app/features/games/data/models/game_item.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:app/features/games/presentation/game/cubit/game_cubit.dart';
import 'package:app/features/games/presentation/game/widgets/game_finished_view.dart';
import 'package:app/features/profile/data/models/account_settings.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/l10n/translations.g.dart';
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

  const item = GameItem(slug: 'a', title: 'Quem é mais organizado?');
  const other = GameItem(slug: 'b', title: 'Quem é mais romântico?');

  GamePlay finished({
    Map<int, String> partner = const {0: pickPartner, 1: pickBoth},
    bool hasItems = false,
  }) {
    return GamePlay(
      kind: GameKind.meOrYou,
      selfId: 'me',
      partnerName: 'Bia',
      session: GameSession(
        id: 's1',
        game: GameKind.meOrYou,
        status: GameStatus.finished,
        invitedBy: 'me',
        itemSlugs: const ['a', 'b'],
        createdAt: created,
      ),
      items: const [item, other],
      own: const {0: pickSelf, 1: pickBoth},
      partner: partner,
      available: hasItems ? const [item, other] : const [],
    );
  }

  setUpAll(() {
    registerFallbackValue(GameKind.meOrYou);
    registerFallbackValue(
      GameSession(
        id: 's1',
        game: GameKind.meOrYou,
        status: GameStatus.finished,
        invitedBy: 'me',
        createdAt: created,
      ),
    );
    LocaleSettings.setLocaleSync(AppLocale.pt);
  });

  setUp(() {
    repository = _MockGamesRepository();
    when(() => repository.watchSessions()).thenAnswer((_) => const Stream.empty());
    profileRepository = _MockProfileRepository();
    when(() => profileRepository.getMySettings())
        .thenAnswer((_) async => const AccountSettings(theme: AppThemeVariant.rose));
    when(() => repository.finishIfComplete(any())).thenAnswer((_) async => null);
  });

  Future<GameCubit> seeded(GamePlay play) async {
    final cubit = GameCubit(repository: repository, profileRepository: profileRepository);
    addTearDown(cubit.close);
    when(
      () => repository.getPlay(
        kind: any(named: 'kind'),
        locale: any(named: 'locale'),
        now: any(named: 'now'),
      ),
    ).thenAnswer((_) async => play);
    await cubit.load(play.kind);

    return cubit;
  }

  testWidgets('a pick result reads as an agreement count and both choices', (tester) async {
    final cubit = await seeded(finished());

    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: GameFinishedView(play: cubit.state.current!),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Vocês concordaram em'), findsOneWidget);
    expect(find.text('2 de 2'), findsOneWidget);
    expect(find.text('Os dois disseram: Você'), findsOneWidget);
    expect(find.text('Os dois disseram: Os dois'), findsOneWidget);
    expect(find.text('As diferenças viram assunto, não placar.'), findsOneWidget);
    expect(find.text('Jogar de novo'), findsNothing);
    expect(find.text('Voltar'), findsOneWidget);
  });

  testWidgets('a round whose content changed says so instead of showing an empty reveal', (
    tester,
  ) async {
    final cubit = await seeded(
      GamePlay(
        kind: GameKind.meOrYou,
        selfId: 'me',
        partnerName: 'Bia',
        session: GameSession(
          id: 's1',
          game: GameKind.meOrYou,
          status: GameStatus.finished,
          invitedBy: 'me',
          itemSlugs: const ['a', 'b'],
          createdAt: created,
        ),
        own: const {0: pickSelf, 1: pickBoth},
        partner: const {0: pickPartner, 1: pickBoth},
      ),
    );

    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: GameFinishedView(play: cubit.state.current!),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Esta rodada não está mais disponível'), findsOneWidget);
    expect(find.textContaining('O conteúdo mudou'), findsOneWidget);
    expect(find.text('Escolher outro jogo'), findsOneWidget);
  });

  testWidgets('a finished round with content offers a new round', (tester) async {
    final cubit = await seeded(finished(hasItems: true));
    when(() => repository.invite(any())).thenAnswer(
      (_) async => GameSession(
        id: 's2',
        game: GameKind.meOrYou,
        status: GameStatus.invited,
        invitedBy: 'me',
        createdAt: created,
      ),
    );

    await tester.pumpApp(
      BlocProvider.value(
        value: cubit,
        child: GameFinishedView(play: cubit.state.current!),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NOVA RODADA'), findsOneWidget);
    expect(find.text('8 perguntas que vocês ainda não viram'), findsOneWidget);
    expect(find.text('Jogar de novo'), findsOneWidget);
    expect(find.text('Escolher outro jogo'), findsOneWidget);

    await tester.tap(find.text('Jogar de novo'));
    await tester.pump();

    verify(() => repository.invite(GameKind.meOrYou)).called(1);
  });
}
