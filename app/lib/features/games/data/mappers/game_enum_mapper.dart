import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_session.dart';

extension EnumGameKindMapper on EnumGameKind_enum {
  /// Null for a game this version has no screens for.
  GameKind? toModel() => switch (this) {
    EnumGameKind_enum.me_or_you => GameKind.meOrYou,
    EnumGameKind_enum.how_well => GameKind.howWell,
    EnumGameKind_enum.twenty_questions => GameKind.twentyQuestions,
    EnumGameKind_enum.never_have_we => GameKind.neverHaveWe,
    EnumGameKind_enum.mission => GameKind.mission,
    EnumGameKind_enum.compliments || EnumGameKind_enum.$unknown => null,
  };
}

extension GameKindRemoteMapper on GameKind {
  EnumGameKind_enum toRemote() => switch (this) {
    GameKind.meOrYou => EnumGameKind_enum.me_or_you,
    GameKind.howWell => EnumGameKind_enum.how_well,
    GameKind.twentyQuestions => EnumGameKind_enum.twenty_questions,
    GameKind.neverHaveWe => EnumGameKind_enum.never_have_we,
    GameKind.mission => EnumGameKind_enum.mission,
  };
}

extension EnumGameStatusMapper on EnumGameStatus_enum {
  /// An unknown status counts as cancelled, so it never blocks a new session.
  GameStatus toModel() => switch (this) {
    EnumGameStatus_enum.invited => GameStatus.invited,
    EnumGameStatus_enum.active => GameStatus.active,
    EnumGameStatus_enum.finished => GameStatus.finished,
    EnumGameStatus_enum.cancelled || EnumGameStatus_enum.$unknown => GameStatus.cancelled,
  };
}
