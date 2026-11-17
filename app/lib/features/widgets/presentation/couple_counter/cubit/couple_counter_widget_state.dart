part of 'couple_counter_widget_cubit.dart';

final class const CoupleCounterWidgetState({
  final Resource<WidgetOverview> overview = const Loading(),
}) with Equatable {
  CoupleCounterWidgetState copyWith({Resource<WidgetOverview>? overview}) =>
      CoupleCounterWidgetState(overview: overview ?? this.overview);

  @override
  List<Object?> get props => [overview];
}
