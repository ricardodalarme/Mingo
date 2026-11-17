part of 'partner_note_widget_cubit.dart';

final class const PartnerNoteWidgetState({
  final Resource<WidgetOverview> overview = const Loading(),
}) with Equatable {
  PartnerNoteWidgetState copyWith({Resource<WidgetOverview>? overview}) =>
      PartnerNoteWidgetState(overview: overview ?? this.overview);

  @override
  List<Object?> get props => [overview];
}
