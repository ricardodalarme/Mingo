import 'package:app/features/weekly_review/data/data_sources/remote/queries/generated/WeeklyReview.graphql.dart';
import 'package:network/network.dart';

class WeeklyReviewDataSource({required final GQLClient _client}) {
  Future<QueryWeeklyReviewweeklyReview> get() async {
    final response = await _client.query(
      OptionsQueryWeeklyReview(fetchPolicy: FetchPolicy.networkOnly),
    );

    return validateResponseData(response, getData: (data) => data.weeklyReview.firstOrNull);
  }
}
