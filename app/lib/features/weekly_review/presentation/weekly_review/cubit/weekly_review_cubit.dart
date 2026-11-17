import 'package:app/features/weekly_review/data/models/weekly_review.dart';
import 'package:app/features/weekly_review/data/repositories/weekly_review_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'weekly_review_state.dart';

class WeeklyReviewCubit({required final WeeklyReviewRepository _repository})
    extends Cubit<WeeklyReviewState> {
  this : super(const WeeklyReviewState());

  Future<void> load() async {
    if (state.review is! Success) emit(const WeeklyReviewState());
    try {
      final review = await _repository.get();
      if (!isClosed) emit(WeeklyReviewState(review: Success(review)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (!isClosed && state.review is! Success) {
        emit(WeeklyReviewState(review: Failure.fromObject(exception)));
      }
    }
  }
}
