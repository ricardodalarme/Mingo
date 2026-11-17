import 'package:app/features/questions/data/data_sources/remote/questions_data_source.dart';
import 'package:app/features/questions/data/mappers/question_answer_mapper.dart';
import 'package:app/features/questions/data/mappers/question_prompt_mapper.dart';
import 'package:app/features/questions/data/models/question_thread.dart';
import 'package:core/core.dart';
import 'package:logger/logger.dart';

class QuestionsRepository({required final QuestionsDataSource _dataSource}) {
  final Logger _logger = Logger('QuestionsRepository');

  /// The current question and couple context, without reading any answers.
  Future<QuestionPrompt> getPrompt() async {
    final record = await _dataSource.getPrompt();

    return record.toModel();
  }

  /// Reads the question and the answer rows the server allows this person to see.
  Future<QuestionThread> getThread() async {
    final prompt = await getPrompt();
    final answers = await _dataSource.getAnswers(questionSlug: prompt.slug, selfId: prompt.selfId);
    QuestionAnswer? own;
    QuestionAnswer? partner;

    for (final row in answers.rows) {
      if (row.coupleId != prompt.coupleId) continue;
      final answer = row.toModel();
      if (row.isMine) {
        own = answer;
      } else {
        partner = answer;
      }
    }

    return QuestionThread(
      prompt: prompt,
      ownAnswer: own,
      partnerAnswer: partner,
      partnerHasAnswered: answers.partnerAnswered,
    );
  }

  /// Inserts the first answer or replaces the person's own row when editing.
  ///
  /// The backend grants insert and delete only, so an edit removes the row and
  /// inserts the new text.
  Future<QuestionAnswer> saveAnswer({required QuestionThread thread, required String body}) async {
    final text = body.trim();
    final existing = thread.ownAnswer;
    if (existing == null) return _insert(thread.prompt, text);

    await _dataSource.deleteAnswer(existing.id);
    try {
      return await _insert(thread.prompt, text);
    } catch (_) {
      await _restore(thread.prompt, existing.body);
      rethrow;
    }
  }

  Future<void> _restore(QuestionPrompt prompt, String body) async {
    try {
      await _dataSource.insertAnswer(questionSlug: prompt.slug, body: body);
    } catch (exception) {
      _logger.error('Failed to restore the previous weekly answer (${exception.runtimeType})');
    }
  }

  Future<QuestionAnswer> _insert(QuestionPrompt prompt, String text) async {
    try {
      final record = await _dataSource.insertAnswer(questionSlug: prompt.slug, body: text);

      return record.toModel();
    } on LocalizedException catch (exception) {
      if (!_isUniqueViolation(exception)) rethrow;
      final fresh = await getThread();
      final row = fresh.ownAnswer;
      if (row == null) rethrow;
      await _dataSource.deleteAnswer(row.id);
      final record = await _dataSource.insertAnswer(questionSlug: prompt.slug, body: text);

      return record.toModel();
    }
  }

  bool _isUniqueViolation(LocalizedException exception) =>
      exception.l10nKey == '23505' || exception.l10nKey.toLowerCase().contains('duplicate key');
}
