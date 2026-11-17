import 'package:app/features/weekly_review/data/data_sources/remote/queries/generated/WeeklyReview.graphql.dart';
import 'package:app/features/weekly_review/data/mappers/weekly_review_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  QueryWeeklyReviewweeklyReview row({bool lowData = false}) => QueryWeeklyReviewweeklyReview(
    weekStart: DateTime.utc(2026, 3, 2),
    slips: 5,
    moodsLogged: 4,
    ritualsDone: 2,
    activeDays: 6,
    lowData: lowData,
  );

  test('the week keeps its counts under the names the screen uses', () {
    final review = row().toModel();

    expect(review.weekStart, DateTime.utc(2026, 3, 2));
    expect(review.slips, 5);
    expect(review.moodDays, 4);
    expect(review.rituals, 2);
  });

  test('a week with little data is a quiet week', () {
    expect(row().toModel().isQuiet, isFalse);
    expect(row(lowData: true).toModel().isQuiet, isTrue);
  });
}
