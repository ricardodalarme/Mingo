import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/games/data/data_sources/remote/games_data_source.dart';
import 'package:app/features/games/data/mappers/game_session_mapper.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final createdAt = DateTime.utc(2026, 3, 10, 12);

  GameSessionRecord record({
    EnumGameKind_enum game = EnumGameKind_enum.me_or_you,
    EnumGameStatus_enum status = EnumGameStatus_enum.active,
  }) => (
    id: 's1',
    game: game,
    status: status,
    invitedBy: 'partner',
    itemSlugs: const ['a', 'b'],
    createdAt: createdAt,
  );

  test('copies the people, the items and the day', () {
    final session = record().toModel()!;

    expect(session.id, 's1');
    expect(session.invitedBy, 'partner');
    expect(session.itemSlugs, ['a', 'b']);
    expect(session.createdAt, createdAt);
  });

  test('maps the game and its status', () {
    final session = record(
      game: EnumGameKind_enum.how_well,
      status: EnumGameStatus_enum.invited,
    ).toModel()!;

    expect(session.game, GameKind.howWell);
    expect(session.status, GameStatus.invited);
  });

  test('a game the app has no screens for has no session', () {
    expect(record(game: EnumGameKind_enum.compliments).toModel(), isNull);
    expect(record(game: EnumGameKind_enum.$unknown).toModel(), isNull);
  });

  test('an unknown status counts as cancelled', () {
    expect(record(status: EnumGameStatus_enum.$unknown).toModel()!.status, GameStatus.cancelled);
  });
}
