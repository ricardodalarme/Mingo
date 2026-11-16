import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/programs/data/models/program.dart';

extension EnumLessonStatusMapper on EnumLessonStatus_enum {
  LessonStatus toModel() => switch (this) {
    EnumLessonStatus_enum.done => LessonStatus.done,
    EnumLessonStatus_enum.saved => LessonStatus.saved,
    EnumLessonStatus_enum.$unknown => throw const FormatException('Unknown lesson status'),
  };
}

extension LessonStatusMapper on LessonStatus {
  EnumLessonStatus_enum toRemote() => switch (this) {
    LessonStatus.done => EnumLessonStatus_enum.done,
    LessonStatus.saved => EnumLessonStatus_enum.saved,
  };
}
