import 'package:app/features/weekly_review/data/data_sources/remote/queries/generated/WeeklyReview.graphql.dart';
import 'package:app/features/weekly_review/data/data_sources/remote/weekly_review_data_source.dart';
import 'package:app/features/weekly_review/data/repositories/weekly_review_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockWeeklyReviewDataSource() extends Mock implements WeeklyReviewDataSource;

void main() {
  test('maps the counts the backend made and marks a quiet week', () async {
    final remote = _MockWeeklyReviewDataSource();
    when(remote.get).thenAnswer(
      (_) async => QueryWeeklyReviewweeklyReview(
        weekStart: DateTime(2026, 11, 2),
        slips: 1,
        moodsLogged: 0,
        ritualsDone: 0,
        activeDays: 1,
        lowData: true,
      ),
    );

    final review = await WeeklyReviewRepository(dataSource: remote).get();

    expect(review.slips, 1);
    expect(review.moodDays, 0);
    expect(review.isQuiet, isTrue);
    expect(review.weekEnd, DateTime(2026, 11, 8));
  });
}
