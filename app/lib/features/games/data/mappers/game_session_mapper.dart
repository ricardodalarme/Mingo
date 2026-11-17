import 'package:app/features/games/data/data_sources/remote/games_data_source.dart';
import 'package:app/features/games/data/mappers/game_enum_mapper.dart';
import 'package:app/features/games/data/models/game_session.dart';

extension GameSessionMapper on GameSessionRecord {
  /// The session, or null when the app has no screens for its game.
  GameSession? toModel() {
    final kind = game.toModel();
    if (kind == null) return null;

    return GameSession(
      id: id,
      game: kind,
      status: status.toModel(),
      invitedBy: invitedBy,
      itemSlugs: itemSlugs,
      createdAt: createdAt,
    );
  }
}
