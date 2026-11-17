import 'package:app/features/quizzes/data/models/quiz_kind.dart';
import 'package:equatable/equatable.dart';

/// When each quiz was finished, from the person's own results.
final class const QuizzesProgress({final Map<QuizKind, DateTime> doneAt = const {}})
    with Equatable {
  factory fake() => QuizzesProgress(doneAt: {QuizKind.loved: DateTime.utc(2026)});

  /// The moment [kind] was last finished, or null when it was never answered.
  DateTime? doneFor(QuizKind kind) => doneAt[kind];

  @override
  List<Object?> get props => [doneAt];
}
