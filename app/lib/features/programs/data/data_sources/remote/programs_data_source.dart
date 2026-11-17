import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/CompleteProgramEnrollment.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/DeleteJournalEntry.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/DeleteLessonProgress.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/InsertJournalEntry.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/InsertLessonProgress.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/InsertProgramEnrollment.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/RestartProgramEnrollment.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/UpdateJournalEntry.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/UpdateLessonProgress.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/mutations/generated/UpdateProgramEnrollment.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/queries/generated/JournalEntries.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/queries/generated/ProgramDetail.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/queries/generated/ProgramProgress.graphql.dart';
import 'package:app/features/programs/data/data_sources/remote/queries/generated/Programs.graphql.dart';
import 'package:network/network.dart';

typedef ContentItemRecord = ({
  String slug,
  String title,
  String? body,
  String? parentSlug,
  int position,
  bool plusOnly,
});

/// Programs and lessons for one locale, already ordered by position.
typedef ProgramsRecord = ({List<ContentItemRecord> programs, List<ContentItemRecord> lessons});

/// One program and the lessons under it.
typedef ProgramRecord = ({ContentItemRecord? program, List<ContentItemRecord> lessons});

typedef EnrollmentRecord = ({String programSlug, int currentDay, DateTime? completedAt});

typedef LessonProgressRecord = ({String programSlug, int lessonDay, EnumLessonStatus_enum status});

typedef JournalEntryRecord = ({String id, DateTime entryDate, String body, String? mood});

class ProgramsDataSource({required final GQLClient _client}) {
  Future<ProgramsRecord> getPrograms(String locale) async {
    final response = await _client.query(
      OptionsQueryPrograms(
        variables: VariablesQueryPrograms(locale: locale),
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );
    final data = validateResponseData<QueryPrograms, QueryPrograms>(response);

    return (
      programs: [
        for (final node in data.programs)
          _content(
            slug: node.slug,
            title: node.title,
            body: node.body,
            parentSlug: null,
            position: node.position,
            plusOnly: node.plusOnly,
          ),
      ],
      lessons: [
        for (final node in data.lessons)
          _content(
            slug: node.slug,
            title: node.title,
            body: node.body,
            parentSlug: node.parentSlug,
            position: node.position,
            plusOnly: node.plusOnly,
          ),
      ],
    );
  }

  Future<ProgramRecord> getProgram({required String slug, required String locale}) async {
    final response = await _client.query(
      OptionsQueryProgramDetail(
        variables: VariablesQueryProgramDetail(slug: slug, locale: locale),
        fetchPolicy: FetchPolicy.cacheFirst,
      ),
    );
    final data = validateResponseData<QueryProgramDetail, QueryProgramDetail>(response);

    final program = data.program.firstOrNull;

    return (
      program: program == null
          ? null
          : _content(
              slug: program.slug,
              title: program.title,
              body: program.body,
              parentSlug: null,
              position: program.position,
              plusOnly: program.plusOnly,
            ),
      lessons: [
        for (final node in data.lessons)
          _content(
            slug: node.slug,
            title: node.title,
            body: node.body,
            parentSlug: node.parentSlug,
            position: node.position,
            plusOnly: node.plusOnly,
          ),
      ],
    );
  }

  Future<EnrollmentRecord?> getEnrollment(String programSlug) async {
    final (enrollment, _) = await _getProgress(programSlug);

    return enrollment;
  }

  Future<List<LessonProgressRecord>> getLessonProgress(String programSlug) async {
    final (_, progress) = await _getProgress(programSlug);

    return progress;
  }

  Future<void> insertEnrollment({
    required String programSlug,
    required int currentDay,
    DateTime? completedAt,
  }) async {
    final response = await _client.mutate(
      OptionsMutationInsertProgramEnrollment(
        variables: VariablesMutationInsertProgramEnrollment(
          programSlug: programSlug,
          currentDay: currentDay,
          completedAt: completedAt,
        ),
      ),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.insertProgramEnrollments?.affected_rows ?? 0,
    );
    if (affected == 0) throw const NoDataException();
  }

  /// Whether an enrollment existed to update.
  Future<bool> updateEnrollment({required String programSlug, required int currentDay}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateProgramEnrollment(
        variables: VariablesMutationUpdateProgramEnrollment(
          programSlug: programSlug,
          currentDay: currentDay,
        ),
      ),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.updateProgramEnrollments?.affected_rows ?? 0,
    );

    return affected > 0;
  }

  /// Whether an enrollment existed to complete.
  Future<bool> completeEnrollment({
    required String programSlug,
    required int currentDay,
    required DateTime completedAt,
  }) async {
    final response = await _client.mutate(
      OptionsMutationCompleteProgramEnrollment(
        variables: VariablesMutationCompleteProgramEnrollment(
          programSlug: programSlug,
          currentDay: currentDay,
          completedAt: completedAt,
        ),
      ),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.updateProgramEnrollments?.affected_rows ?? 0,
    );

    return affected > 0;
  }

  Future<void> restartEnrollment(String programSlug) async {
    final response = await _client.mutate(
      OptionsMutationRestartProgramEnrollment(
        variables: VariablesMutationRestartProgramEnrollment(programSlug: programSlug),
      ),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.updateProgramEnrollments?.affected_rows ?? 0,
    );
    if (affected == 0) throw const NoDataException();
  }

  Future<void> clearLessonProgress(String programSlug) async {
    final response = await _client.mutate(
      OptionsMutationDeleteLessonProgress(
        variables: VariablesMutationDeleteLessonProgress(programSlug: programSlug),
      ),
    );

    validateResponse(response);
  }

  /// Updates the lesson when the row exists, otherwise inserts the first one.
  Future<void> setLessonStatus({
    required String programSlug,
    required int lessonDay,
    required EnumLessonStatus_enum status,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateLessonProgress(
        variables: VariablesMutationUpdateLessonProgress(
          programSlug: programSlug,
          lessonDay: lessonDay,
          status: status,
        ),
      ),
    );
    final affected = validateResponseData<MutationUpdateLessonProgress, int>(
      response,
      getData: (data) => data.updateLessonProgress?.affected_rows ?? 0,
    );
    if (affected > 0) return;

    final insert = await _client.mutate(
      OptionsMutationInsertLessonProgress(
        variables: VariablesMutationInsertLessonProgress(
          programSlug: programSlug,
          lessonDay: lessonDay,
          status: status,
        ),
      ),
    );
    validateResponse(insert);
  }

  Future<List<JournalEntryRecord>> getJournalEntries() async {
    final response = await _client.query(
      OptionsQueryJournalEntries(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryJournalEntries, QueryJournalEntries>(response);

    return [
      for (final node in data.journalEntries)
        (id: node.id, entryDate: node.entryDate, body: node.body, mood: node.mood),
    ];
  }

  Future<JournalEntryRecord> insertJournalEntry({
    required DateTime entryDate,
    required String body,
    String? mood,
  }) async {
    final response = await _client.mutate(
      OptionsMutationInsertJournalEntry(
        variables: VariablesMutationInsertJournalEntry(
          entryDate: entryDate,
          body: body,
          mood: mood,
        ),
      ),
    );
    final node = validateResponseData(response, getData: (data) => data.insertJournalEntriesOne);

    return (id: node.id, entryDate: node.entryDate, body: node.body, mood: node.mood);
  }

  Future<void> updateJournalEntry({required String id, required String body, String? mood}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateJournalEntry(
        variables: VariablesMutationUpdateJournalEntry(id: id, body: body, mood: mood),
      ),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.updateJournalEntries?.affected_rows ?? 0,
    );
    if (affected == 0) throw const NoDataException();
  }

  Future<void> deleteJournalEntry(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteJournalEntry(variables: VariablesMutationDeleteJournalEntry(id: id)),
    );
    final affected = validateResponseData(
      response,
      getData: (data) => data.deleteJournalEntries?.affected_rows ?? 0,
    );
    if (affected == 0) throw const NoDataException();
  }

  Future<(EnrollmentRecord?, List<LessonProgressRecord>)> _getProgress(String programSlug) async {
    final response = await _client.query(
      OptionsQueryProgramProgress(
        variables: VariablesQueryProgramProgress(slug: programSlug),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final data = validateResponseData<QueryProgramProgress, QueryProgramProgress>(response);
    final enrollment = data.programEnrollments.firstOrNull;

    return (
      enrollment == null
          ? null
          : (
              programSlug: enrollment.programSlug,
              currentDay: enrollment.currentDay,
              completedAt: enrollment.completedAt,
            ),
      [
        for (final node in data.lessonProgress)
          (programSlug: node.programSlug, lessonDay: node.lessonDay, status: node.status),
      ],
    );
  }

  ContentItemRecord _content({
    required String slug,
    required String title,
    required String? body,
    required String? parentSlug,
    required int position,
    required bool plusOnly,
  }) => (
    slug: slug,
    title: title,
    body: body,
    parentSlug: parentSlug,
    position: position,
    plusOnly: plusOnly,
  );
}
