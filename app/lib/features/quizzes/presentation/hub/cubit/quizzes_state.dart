part of 'quizzes_cubit.dart';

final class const QuizzesState({final Resource<QuizzesProgress> progress = const Loading()})
    with Equatable {
  QuizzesState copyWith({Resource<QuizzesProgress>? progress}) =>
      QuizzesState(progress: progress ?? this.progress);

  @override
  List<Object?> get props => [progress];
}
