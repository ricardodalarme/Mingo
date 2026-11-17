import 'package:app/features/weekly_review/data/data_sources/remote/queries/generated/WeeklyReview.graphql.dart';
import 'package:app/features/weekly_review/data/models/weekly_review.dart';

extension WeeklyReviewMapper on QueryWeeklyReviewweeklyReview {
  WeeklyReview toModel() => WeeklyReview(
    weekStart: weekStart,
    slips: slips,
    moodDays: moodsLogged,
    rituals: ritualsDone,
    isQuiet: lowData,
  );
}
