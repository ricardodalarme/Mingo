import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/programs/data/mappers/lesson_progress_mapper.dart';
import 'package:app/features/programs/data/models/program.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a progress row keeps its program, day and status', () {
    final progress = (programSlug: 'p', lessonDay: 2, status: EnumLessonStatus_enum.done).toModel();

    expect(progress.programSlug, 'p');
    expect(progress.lessonDay, 2);
    expect(progress.status, LessonStatus.done);
  });
}
