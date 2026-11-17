part of 'card_encounter_widget_cubit.dart';

final class const CardEncounterWidgetState({
  final Resource<WidgetOverview> overview = const Loading(),
}) with Equatable {
  CardEncounterWidgetState copyWith({Resource<WidgetOverview>? overview}) =>
      CardEncounterWidgetState(overview: overview ?? this.overview);

  @override
  List<Object?> get props => [overview];
}
