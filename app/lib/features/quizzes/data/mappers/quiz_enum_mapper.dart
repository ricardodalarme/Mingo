import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/quizzes/data/models/quiz_kind.dart';

extension EnumQuizKeyMapper on EnumQuizKey_enum {
  /// Null for a quiz this version has no screens for.
  QuizKind? toModel() => switch (this) {
    EnumQuizKey_enum.loved => QuizKind.loved,
    EnumQuizKey_enum.conflict_style => QuizKind.conflictStyle,
    EnumQuizKey_enum.$unknown => null,
  };
}
