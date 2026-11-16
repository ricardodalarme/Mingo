part of 'weekly_review_cubit.dart';

final class const WeeklyReviewState({final Resource<WeeklyReview> review = const Loading()})
    with Equatable {
  @override
  List<Object?> get props => [review];
}
