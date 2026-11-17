import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/programs/data/data_sources/remote/programs_data_source.dart';
import 'package:app/features/programs/data/mappers/diary_entry_mapper.dart';
import 'package:app/features/programs/data/mappers/lesson_progress_mapper.dart';
import 'package:app/features/programs/data/mappers/lesson_status_mapper.dart';
import 'package:app/features/programs/data/mappers/program_enrollment_mapper.dart';
import 'package:app/features/programs/data/mappers/program_mapper.dart';
import 'package:app/features/programs/data/models/diary_entry.dart';
import 'package:app/features/programs/data/models/program.dart';
import 'package:clock/clock.dart';
import 'package:logger/logger.dart';

class ProgramsRepository({
  required final ProgramsDataSource _dataSource,
  required final ProfileRepository _profileRepository,
}) {
  final Logger _logger = Logger('ProgramsRepository');

  /// The programs and lessons that exist for the account language, in position order.
  Future<List<Program>> getPrograms() => _run('read the programs', () async {
    final record = await _dataSource.getPrograms(await _locale());

    return record.toModel();
  });

  Future<Program> getProgram(String slug) => _run('read one program', () async {
    final record = await _dataSource.getProgram(slug: slug, locale: await _locale());
    final program = record.toModel();
    if (program == null) throw StateError('Program $slug is missing');

    return program;
  });

  Future<ProgramEnrollment?> getEnrollment(String slug) => _run(
    'read the program enrollment',
    () async => (await _dataSource.getEnrollment(slug))?.toModel(),
  );

  Future<List<LessonProgress>> getLessonProgress(String slug) => _run(
    'read the lesson progress',
    () async => [for (final row in await _dataSource.getLessonProgress(slug)) row.toModel()],
  );

  Future<void> startProgram({required String slug, required int day}) => _run(
    'start the program',
    () => _dataSource.insertEnrollment(programSlug: slug, currentDay: day),
  );

  /// Moves the enrollment forward, creating it when the person started from a lesson.
  ///
  /// Marks the enrollment complete on the final lesson.
  Future<void> advanceProgram({
    required String slug,
    required int currentDay,
    required bool completed,
  }) => _run('advance the program', () async {
    final completedAt = completed ? clock.now() : null;
    final advanced = completed
        ? await _dataSource.completeEnrollment(
            programSlug: slug,
            currentDay: currentDay,
            completedAt: completedAt!,
          )
        : await _dataSource.updateEnrollment(programSlug: slug, currentDay: currentDay);
    if (advanced) return;

    await _dataSource.insertEnrollment(
      programSlug: slug,
      currentDay: currentDay,
      completedAt: completedAt,
    );
  });

  /// Clears the lesson marks and returns the enrollment to the first lesson.
  Future<void> restartProgram(String slug) => _run('restart the program', () async {
    await _dataSource.clearLessonProgress(slug);
    await _dataSource.restartEnrollment(slug);
  });

  Future<void> completeLesson({required String slug, required int day}) => _run(
    'mark the lesson done',
    () => _dataSource.setLessonStatus(
      programSlug: slug,
      lessonDay: day,
      status: LessonStatus.done.toRemote(),
    ),
  );

  Future<void> saveLesson({required String slug, required int day}) => _run(
    'save the lesson',
    () => _dataSource.setLessonStatus(
      programSlug: slug,
      lessonDay: day,
      status: LessonStatus.saved.toRemote(),
    ),
  );

  Future<List<DiaryEntry>> getDiaryEntries() => _run(
    'read the diary',
    () async => [for (final entry in await _dataSource.getJournalEntries()) entry.toModel()],
  );

  /// Inserts the first entry for a day, or replaces [id] when it already exists.
  Future<String> saveDiaryEntry({
    required DateTime entryDate,
    required String body,
    String? mood,
    String? id,
  }) => _run('save a diary entry', () async {
    if (id != null) {
      await _dataSource.updateJournalEntry(id: id, body: body, mood: mood);

      return id;
    }
    final entry = await _dataSource.insertJournalEntry(
      entryDate: entryDate,
      body: body,
      mood: mood,
    );

    return entry.id;
  });

  Future<void> deleteDiaryEntry(String id) =>
      _run('delete a diary entry', () => _dataSource.deleteJournalEntry(id));

  Future<String> _locale() async => (await _profileRepository.getMySettings()).locale;

  Future<T> _run<T>(String what, Future<T> Function() action) async {
    try {
      return await action();
    } catch (e, stack) {
      _logger.error('Failed to $what', error: e, stackTrace: stack);
      rethrow;
    }
  }
}

typedef ProgramLessonDraft = ({ContentItemRecord lesson, int day});
