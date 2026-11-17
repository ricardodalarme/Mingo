part of 'own_small_widgets_cubit.dart';

final class const OwnSmallWidgetsState({final Resource<WidgetOverview> overview = const Loading()})
    with Equatable {
  OwnSmallWidgetsState copyWith({Resource<WidgetOverview>? overview}) =>
      OwnSmallWidgetsState(overview: overview ?? this.overview);

  @override
  List<Object?> get props => [overview];
}
