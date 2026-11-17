/// The quizzes of the app, matching a `quiz_results.quiz_key`.
enum QuizKind(final String key) {
  loved('loved'),
  conflictStyle('conflict_style');

  /// The quiz for a server [key], or null when the app has no screens for it.
  static QuizKind? fromKey(String key) {
    for (final kind in values) {
      if (kind.key == key) return kind;
    }

    return null;
  }
}

/// The six questions each quiz asks.
const int quizQuestionCount = 6;

/// How long a quiz usually takes.
const int quizMinutes = 2;
