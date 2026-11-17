import 'package:app/features/programs/data/data_sources/remote/programs_data_source.dart';
import 'package:app/features/programs/data/mappers/lesson_status_mapper.dart';
import 'package:app/features/programs/data/models/program.dart';

extension LessonProgressMapper on LessonProgressRecord {
  LessonProgress toModel() =>
      LessonProgress(programSlug: programSlug, lessonDay: lessonDay, status: status.toModel());
}
