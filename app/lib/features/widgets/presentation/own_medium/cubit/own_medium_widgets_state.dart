part of 'own_medium_widgets_cubit.dart';

final class const OwnMediumWidgetsState({final Resource<WidgetOverview> overview = const Loading()})
    with Equatable {
  OwnMediumWidgetsState copyWith({Resource<WidgetOverview>? overview}) =>
      OwnMediumWidgetsState(overview: overview ?? this.overview);

  @override
  List<Object?> get props => [overview];
}
