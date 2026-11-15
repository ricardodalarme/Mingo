import 'package:app/features/games/data/models/game_kind.dart';
import 'package:app/features/games/data/models/game_play.dart';
import 'package:app/features/games/presentation/game/widgets/game_kind_l10n.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// A pick from the reader's point of view, or the missing-answer label.
String gamePersonLabel(BuildContext context, GamePerson? person, {String? partnerName}) {
  final l10n = context.l10n.games;
  final name = gamePartnerName(partnerName, l10n.playing.partnerFallback);

  return switch (person) {
    GamePerson.self => l10n.finished.you,
    GamePerson.partner => name,
    GamePerson.both => l10n.finished.both,
    null => l10n.finished.noAnswer,
  };
}

/// A stored date reflection, or the missing-answer label.
String gameReflectionLabel(BuildContext context, String? reflection) =>
    context.l10n.games.reflections.selectOrFallback(reflection);

/// A stored answer, or the missing-answer label.
String gameAnswerLabel(BuildContext context, String? answer) {
  if (answer == null || answer.trim().isEmpty) return context.l10n.games.finished.noAnswer;

  return answer;
}

/// The answer of [step] as the review list shows it.
String gameReviewAnswer(BuildContext context, GamePlay play, int step, String? answer) {
  if (answer == null || answer.trim().isEmpty || answer == gameSkippedAnswer) {
    return context.l10n.games.finished.noAnswer;
  }

  return switch (play.kind.flow) {
    GameFlow.pick => _pickLabel(context, answer, partnerName: play.partnerName),
    GameFlow.guess when play.phaseAt(step) == GamePhase.guess =>
      '${context.l10n.games.playing.guessYourGuess}: ${gameAnswerLabel(context, answer)}',
    GameFlow.date => gameReflectionLabel(context, answer),
    _ => gameAnswerLabel(context, answer),
  };
}

String _pickLabel(BuildContext context, String pick, {String? partnerName}) {
  final l10n = context.l10n.games;

  return switch (pick) {
    pickSelf => l10n.finished.you,
    pickPartner => gamePartnerName(partnerName, l10n.playing.partnerFallback),
    pickBoth => l10n.finished.both,
    _ => l10n.finished.noAnswer,
  };
}
