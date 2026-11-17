part of 'mood_longing_widget_cubit.dart';

final class const MoodLongingWidgetState({
  final Resource<WidgetOverview> overview = const Loading(),
}) with Equatable {
  MoodLongingWidgetState copyWith({Resource<WidgetOverview>? overview}) =>
      MoodLongingWidgetState(overview: overview ?? this.overview);

  @override
  List<Object?> get props => [overview];
}
