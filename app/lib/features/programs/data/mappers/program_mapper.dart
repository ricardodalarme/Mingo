import 'package:app/features/programs/data/data_sources/remote/programs_data_source.dart';
import 'package:app/features/programs/data/models/program.dart';

extension ProgramsMapper on ProgramsRecord {
  /// The programs in position order, each with its lessons in day order.
  List<Program> toModel() {
    final lessonsByParent = <String, List<ContentItemRecord>>{};
    for (final lesson in lessons) {
      final parent = lesson.parentSlug;
      if (parent == null) continue;
      lessonsByParent.putIfAbsent(parent, () => []).add(lesson);
    }
    final ordered = [...programs]..sort((a, b) => a.position.compareTo(b.position));

    return [
      for (final program in ordered)
        program.toProgram(lessons: lessonsByParent[program.slug] ?? const []),
    ];
  }
}

extension ProgramRecordMapper on ProgramRecord {
  /// The program with its lessons, or null when the server returned no such program.
  Program? toModel() => program?.toProgram(lessons: lessons);
}

extension ContentItemProgramMapper on ContentItemRecord {
  /// This item as a program, with [lessons] in day order.
  Program toProgram({required List<ContentItemRecord> lessons}) {
    final ordered = [...lessons]..sort((a, b) => a.position.compareTo(b.position));

    return Program(
      slug: slug,
      title: title,
      body: body,
      plusOnly: plusOnly,
      lessons: [for (final lesson in ordered) lesson.toLesson()],
    );
  }

  /// This item as a lesson; its position is the day.
  Lesson toLesson() =>
      Lesson(slug: slug, title: title, day: position, body: body, plusOnly: plusOnly);
}
