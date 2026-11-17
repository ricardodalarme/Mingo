import 'package:app/features/checkin/data/data_sources/remote/mutations/generated/InsertCheckinAnswer.graphql.dart';
import 'package:app/features/checkin/data/data_sources/remote/mutations/generated/UpdateCheckinAnswer.graphql.dart';
import 'package:app/features/checkin/data/data_sources/remote/queries/generated/CheckinAnswers.graphql.dart';
import 'package:app/features/checkin/data/data_sources/remote/queries/generated/CheckinToday.graphql.dart';
import 'package:app/features/checkin/data/data_sources/remote/subscriptions/generated/WatchCheckinRows.graphql.dart';
import 'package:network/network.dart';

typedef CheckinAnswerRecord = ({String id, bool isMine, int question, String body});

typedef CheckinAnswerWriteRecord = ({String id, int question, String body});

/// The person's own check-in row and the answers both people can see.
typedef CheckinAnswersRecord = ({String? ownRowId, List<CheckinAnswerRecord> answers});

/// The server's local day, the person, their couple and the partner's display name.
typedef CheckinTodayRecord = ({
  DateTime localDate,
  String? partnerName,
  String selfId,
  String? coupleId,
  bool isPaired,
});

class CheckinDataSource({required final GQLClient _client}) {
  Future<CheckinTodayRecord> getToday() async {
    final response = await _client.query(
      OptionsQueryCheckinToday(fetchPolicy: FetchPolicy.networkOnly),
    );
    final data = validateResponseData<QueryCheckinToday, QueryCheckinToday>(response);
    final today = data.today.firstOrNull;
    final localDate = today?.localDate;
    final selfId = today?.userId;
    if (today == null || localDate == null || selfId == null) {
      throw const NoDataException();
    }

    return (
      localDate: localDate,
      partnerName: today.partnerName,
      selfId: selfId,
      coupleId: today.coupleId,
      isPaired: today.coupleId != null,
    );
  }

  Future<CheckinAnswersRecord> getAnswers({
    required DateTime weekStart,
    required String coupleId,
    required String selfId,
  }) async {
    final response = await _client.query(
      OptionsQueryCheckinAnswers(
        variables: VariablesQueryCheckinAnswers(weekStart: weekStart, coupleId: coupleId),
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );
    final rows = validateResponseData(response, getData: (data) => data.checkins);

    return (
      ownRowId: rows.where((row) => row.authorId == selfId).firstOrNull?.id,
      answers: [
        for (final row in rows)
          for (final question in const [1, 2, 3, 4])
            if (row.answerFor(question) case final body?)
              (id: row.id, isMine: row.authorId == selfId, question: question, body: body),
      ],
    );
  }

  /// Emits how many check-in rows of the week the person can read, now and on each change.
  ///
  /// The partner's row only becomes readable once both people finished all four answers. The
  /// permission already limits the rows to the person's couple, so the subscription is shared by
  /// everyone in the same week.
  Stream<int> watchRowCount({required DateTime weekStart}) {
    return _client
        .subscribe(
          OptionsSubscriptionWatchCheckinRows(
            variables: VariablesSubscriptionWatchCheckinRows(weekStart: weekStart),
          ),
        )
        .mapResponseData((data) => data.checkins.length);
  }

  Future<CheckinAnswerWriteRecord> saveAnswer({
    required String? id,
    required int question,
    required String body,
  }) {
    if (id == null) return _insert(question: question, body: body);

    return _update(id: id, question: question, body: body);
  }

  Future<CheckinAnswerWriteRecord> _insert({required int question, required String body}) async {
    final response = await _client.mutate(
      OptionsMutationInsertCheckinAnswer(
        variables: VariablesMutationInsertCheckinAnswer.fromJson({
          'answers': {'answer$question': body},
        }),
      ),
    );
    final node = validateResponseData(response, getData: (data) => data.insertCheckinsOne);

    return (id: node.id, question: question, body: body);
  }

  Future<CheckinAnswerWriteRecord> _update({
    required String id,
    required int question,
    required String body,
  }) async {
    final response = await _client.mutate(
      OptionsMutationUpdateCheckinAnswer(
        variables: VariablesMutationUpdateCheckinAnswer.fromJson({
          'id': id,
          'answers': {'answer$question': body},
        }),
      ),
    );
    final node = validateResponseData(response, getData: (data) => data.updateCheckinsByPk);

    return (id: node.id, question: question, body: body);
  }

  Future<void> deleteAnswer({required String id, required int question}) async {
    final response = await _client.mutate(
      OptionsMutationUpdateCheckinAnswer(
        variables: VariablesMutationUpdateCheckinAnswer.fromJson({
          'id': id,
          'answers': {'answer$question': null},
        }),
      ),
    );

    validateResponse(response);
  }
}

extension on QueryCheckinAnswerscheckins {
  String? answerFor(int question) => switch (question) {
    1 => answer1,
    2 => answer2,
    3 => answer3,
    4 => answer4,
    _ => null,
  };
}
