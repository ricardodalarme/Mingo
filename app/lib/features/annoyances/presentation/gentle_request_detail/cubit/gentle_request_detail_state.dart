part of 'gentle_request_detail_cubit.dart';

final class const GentleRequestDetailState({
  final Resource<GentleRequest?> request = const Loading(),
  final String? userId,
  final Resource<void> action = const Initial(),
}) with Equatable {
  /// Whether the person sent the request, as opposed to receiving it.
  bool get isSender => switch (request) {
    Success<GentleRequest?>(:final value?) => userId != null && value.isFrom(userId!),
    _ => false,
  };

  GentleRequestDetailState copyWith({
    Resource<GentleRequest?>? request,
    String? userId,
    Resource<void>? action,
  }) {
    return GentleRequestDetailState(
      request: request ?? this.request,
      userId: userId ?? this.userId,
      action: action ?? this.action,
    );
  }

  @override
  List<Object?> get props => [request, userId, action];
}
