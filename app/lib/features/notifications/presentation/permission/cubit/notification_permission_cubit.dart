import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_permission_state.dart';

/// Asks for notification access after the explainer; refusing leaves the app fully usable.
class NotificationPermissionCubit({
  required final NotificationsRepository _repository,
  final Duration _registrationTimeout = NotificationsRepository.registrationTimeout,
}) extends Cubit<NotificationPermissionState> {
  this : super(const NotificationPermissionState());

  /// Shows the system prompt and reports the answer before registering the device.
  Future<void> allow() async {
    if (state.isBusy) return;

    emit(const NotificationPermissionState(requestAction: Loading()));
    final NotificationAccess access;
    try {
      access = await _repository.requestAccess();
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(requestAction: Failure.fromObject(exception)));
      return;
    }
    emit(state.copyWith(requestAction: Success(access)));
    if (access == NotificationAccess.granted) await register();
  }

  /// Registers this device for push after an attempt failed or timed out.
  Future<void> register() async {
    if (state.registrationAction.isLoading) return;

    emit(state.copyWith(registrationAction: const Loading()));
    try {
      await _repository.registerDevice().timeout(_registrationTimeout);
      emit(
        state.copyWith(registrationAction: const Success<void>(null), hasRegistrationFailed: false),
      );
    } catch (exception, stack) {
      addError(exception, stack);
      emit(
        state.copyWith(
          registrationAction: Failure.fromObject(exception),
          hasRegistrationFailed: true,
        ),
      );
    }
  }
}
