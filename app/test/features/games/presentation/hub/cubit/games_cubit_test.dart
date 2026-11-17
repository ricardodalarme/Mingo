import 'dart:async';

import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:app/features/games/data/models/games_overview.dart';
import 'package:app/features/games/data/repositories/games_repository.dart';
import 'package:app/features/games/presentation/hub/cubit/games_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGamesRepository() extends Mock implements GamesRepository;

void main() {
  late GamesRepository repository;
  late StreamController<List<GameSession>> sessions;

  GameSession session(String id, GameStatus status) => GameSession(
    id: id,
    game: GameKind.meOrYou,
    status: status,
    invitedBy: 'partner',
    createdAt: DateTime(2026, 3, 10),
  );

  setUp(() {
    repository = _MockGamesRepository();
    sessions = StreamController<List<GameSession>>.broadcast();
    addTearDown(sessions.close);
    when(() => repository.watchSessions()).thenAnswer((_) => sessions.stream);
    when(() => repository.getOverview())
        .thenAnswer((_) async => const GamesOverview(selfId: 'me', hasPartner: true));
  });

  test('reads the games again when the partner sends an invitation', () async {
    final cubit = GamesCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    sessions.add(const []);
    await pumpEventQueue();
    sessions.add([session('s1', GameStatus.invited)]);
    await pumpEventQueue();

    verify(() => repository.getOverview()).called(2);
    expect(cubit.state.overview, isA<Success<GamesOverview>>());
  });

  test('does not read again when the sessions did not change', () async {
    final cubit = GamesCubit(repository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    sessions.add([session('s1', GameStatus.invited)]);
    await pumpEventQueue();
    sessions.add([session('s1', GameStatus.invited)]);
    await pumpEventQueue();

    verify(() => repository.getOverview()).called(1);
  });

  test('stops listening when it closes', () async {
    final cubit = GamesCubit(repository: repository);
    await cubit.load();

    await cubit.close();

    expect(sessions.hasListener, isFalse);
  });
}
