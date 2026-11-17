import 'package:app/features/quizzes/data/models/quizzes_progress.dart';
import 'package:app/features/quizzes/data/repositories/quizzes_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quizzes_state.dart';

class QuizzesCubit({required final QuizzesRepository _repository}) extends Cubit<QuizzesState> {
  this : super(const QuizzesState());

  /// Reads when each quiz was finished, again on pull to refresh.
  Future<void> load() async {
    if (isClosed) return;
    if (state.progress is! Success) emit(state.copyWith(progress: const Loading()));
    try {
      final progress = await _repository.getProgress();
      if (isClosed) return;
      emit(state.copyWith(progress: Success(progress)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed || state.progress is Success) return;
      emit(state.copyWith(progress: Failure.fromObject(exception)));
    }
  }
}
