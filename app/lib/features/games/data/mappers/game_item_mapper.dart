import 'package:app/features/games/data/data_sources/remote/games_data_source.dart';
import 'package:app/features/games/data/models/game_item.dart';

extension GameItemMapper on GameItemRecord {
  GameItem toModel() => GameItem(slug: slug, title: title, body: body);
}
