import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/quizzes/data/mappers/quiz_enum_mapper.dart';
import 'package:app/features/quizzes/data/models/quiz_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps the quiz keys the app has screens for', () {
    expect(EnumQuizKey_enum.loved.toModel(), QuizKind.loved);
    expect(EnumQuizKey_enum.conflict_style.toModel(), QuizKind.conflictStyle);
    expect(EnumQuizKey_enum.$unknown.toModel(), isNull);
  });
}
