import 'package:app/features/questions/data/data_sources/remote/mutations/generated/DeleteQuestionAnswer.graphql.dart';
import 'package:app/features/questions/data/data_sources/remote/mutations/generated/InsertQuestionAnswer.graphql.dart';
import 'package:app/features/questions/data/data_sources/remote/queries/generated/QuestionAnswers.graphql.dart';
import 'package:app/features/questions/data/data_sources/remote/queries/generated/QuestionOfTheWeek.graphql.dart';
import 'package:network/network.dart';

typedef QuestionPromptRecord = ({
  String slug,
  String title,
  String? body,
  List<String> tags,
  bool isPaired,
  String? partnerName,
  String? coupleId,
  String selfId,
});

typedef QuestionAnswerRecord = ({String id, bool isMine, String? coupleId, String body});

typedef QuestionAnswerWriteRecord = ({String id, String? coupleId, String body});

/// The visible answer rows for one question and whether the partner answered.
typedef QuestionAnswersRecord = ({List<QuestionAnswerRecord> rows, bool partnerAnswered});

class QuestionsDataSource({required final GQLClient _client}) {
  Future<QuestionPromptRecord> getPrompt() async {
    final response = await _client.query(
      OptionsQueryQuestionOfTheWeek(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryQuestionOfTheWeek, QueryQuestionOfTheWeek>(response);
    final question = data.question.firstOrNull;
    final today = data.today.firstOrNull;
    final selfId = today?.userId;
    if (question == null || today == null || selfId == null) throw const NoDataException();

    return (
      slug: question.slug,
      title: question.title,
      body: question.body,
      tags: question.tags.whereType<String>().toList(),
      isPaired: today.coupleId != null,
      partnerName: today.partnerName,
      coupleId: today.coupleId,
      selfId: selfId,
    );
  }

  Future<QuestionAnswersRecord> getAnswers({
    required String questionSlug,
    required String selfId,
  }) async {
    final response = await _client.query(
      OptionsQueryQuestionAnswers(
        variables: VariablesQueryQuestionAnswers(questionSlug: questionSlug),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.questionAnswers);

    return (
      rows: [
        for (final row in rows)
          (id: row.id, isMine: row.authorId == selfId, coupleId: row.coupleId, body: row.body),
      ],
      partnerAnswered: rows.any((row) => row.authorId != selfId),
    );
  }

  Future<QuestionAnswerWriteRecord> insertAnswer({
    required String questionSlug,
    required String body,
  }) async {
    final response = await _client.mutate(
      OptionsMutationInsertQuestionAnswer(
        variables: VariablesMutationInsertQuestionAnswer(questionSlug: questionSlug, body: body),
      ),
    );
    final node = validateResponseData(response, getData: (data) => data.insertQuestionAnswersOne);

    return (id: node.id, coupleId: node.coupleId, body: node.body);
  }

  Future<void> deleteAnswer(String id) async {
    final response = await _client.mutate(
      OptionsMutationDeleteQuestionAnswer(variables: VariablesMutationDeleteQuestionAnswer(id: id)),
    );

    validateResponse(response);
  }
}
