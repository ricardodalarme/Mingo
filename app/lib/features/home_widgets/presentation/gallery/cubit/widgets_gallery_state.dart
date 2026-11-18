part of 'widgets_gallery_cubit.dart';

final class const WidgetsGalleryState({
  final Resource<WidgetOverview> overview = const Loading(),
  final Resource<void> saveAction = const Initial(),
}) with Equatable {
  WidgetsGalleryState copyWith({Resource<WidgetOverview>? overview, Resource<void>? saveAction}) =>
      WidgetsGalleryState(
        overview: overview ?? this.overview,
        saveAction: saveAction ?? this.saveAction,
      );

  @override
  List<Object?> get props => [overview, saveAction];
}
