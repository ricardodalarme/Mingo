import 'package:app/features/quizzes/data/data_sources/remote/quizzes_data_source.dart';
import 'package:app/features/quizzes/data/mappers/quiz_enum_mapper.dart';
import 'package:app/features/quizzes/data/models/quiz_kind.dart';
import 'package:app/features/quizzes/data/models/quizzes_progress.dart';
import 'package:logger/logger.dart';

class QuizzesRepository({required final QuizzesDataSource _dataSource}) {
  final Logger _logger = Logger('QuizzesRepository');

  /// The couple's quiz results, keeping only the person's own.
  Future<QuizzesProgress> getProgress() async {
    try {
      final record = await _dataSource.getResults();
      final doneAt = <QuizKind, DateTime>{};
      for (final row in record.results) {
        if (row.authorId != record.selfId) continue;
        final kind = row.quizKey.toModel();
        if (kind != null) doneAt[kind] = row.updatedAt;
      }

      return QuizzesProgress(doneAt: doneAt);
    } catch (e, stack) {
      _logger.error('Failed to read the quizzes', error: e, stackTrace: stack);
      rethrow;
    }
  }
}
