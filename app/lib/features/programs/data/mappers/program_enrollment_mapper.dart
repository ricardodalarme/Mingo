import 'package:app/features/programs/data/data_sources/remote/programs_data_source.dart';
import 'package:app/features/programs/data/models/program.dart';

extension ProgramEnrollmentMapper on EnrollmentRecord {
  ProgramEnrollment toModel() =>
      ProgramEnrollment(programSlug: programSlug, currentDay: currentDay, completedAt: completedAt);
}
