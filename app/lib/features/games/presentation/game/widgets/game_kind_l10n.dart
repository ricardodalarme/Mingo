import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

extension GameKindL10n on GameKind {
  /// The name of the game in the current language.
  String title(BuildContext context) {
    final kinds = context.l10n.games.kinds;

    return switch (this) {
      GameKind.meOrYou => kinds.meOrYou.title,
      GameKind.howWell => kinds.howWell.title,
      GameKind.twentyQuestions => kinds.twentyQuestions.title,
      GameKind.neverHaveWe => kinds.neverHaveWe.title,
      GameKind.mission => kinds.mission.title,
    };
  }

  /// A short description of how the game is played.
  String intro(BuildContext context) {
    final kinds = context.l10n.games.kinds;

    return switch (this) {
      GameKind.meOrYou => kinds.meOrYou.intro,
      GameKind.howWell => kinds.howWell.intro,
      GameKind.twentyQuestions => kinds.twentyQuestions.intro,
      GameKind.neverHaveWe => kinds.neverHaveWe.intro,
      GameKind.mission => kinds.mission.intro,
    };
  }

  IconData get icon => switch (this) {
    GameKind.meOrYou => AppIcons.users,
    GameKind.howWell => AppIcons.star,
    GameKind.twentyQuestions => AppIcons.message,
    GameKind.neverHaveWe => AppIcons.heart,
    GameKind.mission => AppIcons.calendar,
  };
}

/// The partner's name, or [fallback] when it is unknown.
String gamePartnerName(String? name, String fallback) =>
    name == null || name.trim().isEmpty ? fallback : name;

/// The round size and duration, such as "8 perguntas · 3 min".
String gameKindMeta(BuildContext context, GameKind kind) {
  final l10n = context.l10n.games.hub;
  final minutes = l10n.minutes(minutes: kind.minutes);
  final count = switch (kind) {
    GameKind.meOrYou => l10n.questionCount(count: kind.itemCount),
    GameKind.howWell => l10n.guessCount(count: kind.itemCount),
    GameKind.twentyQuestions => l10n.questionCount(count: kind.itemCount),
    GameKind.neverHaveWe || GameKind.mission => null,
  };

  return count == null ? minutes : '$count · $minutes';
}
