import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/quizzes/data/data_sources/remote/queries/generated/QuizResultsOverview.graphql.dart';
import 'package:network/network.dart';

/// One saved quiz result before the domain mapping.
typedef QuizResultRecord = ({String authorId, EnumQuizKey_enum quizKey, DateTime updatedAt});

/// The person and their own results.
typedef QuizResultsRecord = ({String selfId, List<QuizResultRecord> results});

class QuizzesDataSource({required final GQLClient _client}) {
  Future<QuizResultsRecord> getResults() async {
    final response = await _client.query(
      OptionsQueryQuizResultsOverview(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryQuizResultsOverview, QueryQuizResultsOverview>(response);
    final selfId = data.today.firstOrNull?.userId;
    if (selfId == null) throw const NoDataException();

    return (
      selfId: selfId,
      results: [
        for (final row in data.quizResults)
          (authorId: row.authorId, quizKey: row.quizKey, updatedAt: row.updatedAt),
      ],
    );
  }
}
