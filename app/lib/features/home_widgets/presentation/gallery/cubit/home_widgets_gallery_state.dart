part of 'home_widgets_gallery_cubit.dart';

final class const HomeWidgetsGalleryState({
  final Resource<HomeWidgetPayload> payload = const Loading(),
}) with Equatable {
  HomeWidgetsGalleryState copyWith({Resource<HomeWidgetPayload>? payload}) =>
      HomeWidgetsGalleryState(payload: payload ?? this.payload);

  @override
  List<Object?> get props => [payload];
}
