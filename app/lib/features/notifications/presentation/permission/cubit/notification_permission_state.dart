part of 'notification_permission_cubit.dart';

final class const NotificationPermissionState({
  final Resource<NotificationAccess> requestAction = const Initial(),
  final Resource<void> registrationAction = const Initial(),
  final bool hasRegistrationFailed = false,
}) with Equatable {
  /// Whether the system prompt or the push registration is still in flight.
  bool get isBusy => requestAction.isLoading || registrationAction.isLoading;

  NotificationPermissionState copyWith({
    Resource<NotificationAccess>? requestAction,
    Resource<void>? registrationAction,
    bool? hasRegistrationFailed,
  }) => NotificationPermissionState(
    requestAction: requestAction ?? this.requestAction,
    registrationAction: registrationAction ?? this.registrationAction,
    hasRegistrationFailed: hasRegistrationFailed ?? this.hasRegistrationFailed,
  );

  @override
  List<Object?> get props => [requestAction, registrationAction, hasRegistrationFailed];
}
