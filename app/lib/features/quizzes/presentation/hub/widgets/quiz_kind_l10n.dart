import 'package:app/features/quizzes/data/models/quiz_kind.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

extension QuizKindL10n on QuizKind {
  /// The name of the quiz in the current language.
  String title(BuildContext context) => switch (this) {
    QuizKind.loved => context.l10n.quizzes.lovedTitle,
    QuizKind.conflictStyle => context.l10n.quizzes.fightTitle,
  };

  IconData get icon => switch (this) {
    QuizKind.loved => AppIcons.heart,
    QuizKind.conflictStyle => AppIcons.twinkle,
  };
}

/// The round size and duration, such as "6 perguntas · 2 min".
String quizMeta(BuildContext context) {
  final l10n = context.l10n.quizzes;

  return l10n.meta(
    questions: l10n.questionCount(count: quizQuestionCount),
    minutes: l10n.minutes(minutes: quizMinutes),
  );
}

/// When the quiz was finished, such as "Feito em 3 nov".
String quizDoneLabel(BuildContext context, DateTime date) {
  final l10n = context.l10n.quizzes;
  final local = date.toLocal();
  final month = l10n.monthsShort[(local.month - 1).clamp(0, 11)];

  return l10n.lastDone(date: '${local.day} $month');
}
