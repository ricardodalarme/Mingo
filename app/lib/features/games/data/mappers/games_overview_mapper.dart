import 'package:app/features/games/data/data_sources/remote/games_data_source.dart';
import 'package:app/features/games/data/mappers/game_session_mapper.dart';
import 'package:app/features/games/data/models/games_overview.dart';

extension GamesOverviewMapper on GameSessionsRecord {
  /// The couple's sessions, leaving out the games the app has no screens for.
  GamesOverview toModel() => GamesOverview(
    selfId: selfId,
    hasPartner: hasCouple,
    partnerName: partnerName,
    sessions: [for (final session in sessions) ?session.toModel()],
  );
}
