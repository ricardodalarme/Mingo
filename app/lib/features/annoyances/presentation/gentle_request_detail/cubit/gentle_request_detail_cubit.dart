import 'package:app/features/annoyances/data/models/gentle_request.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'gentle_request_detail_state.dart';

class GentleRequestDetailCubit({
  required final AnnoyanceRepository _annoyanceRepository,
  required final AuthenticationRepository _authenticationRepository,
}) extends Cubit<GentleRequestDetailState> {
  this : super(const GentleRequestDetailState());

  /// Reads the request; opening it as the recipient notes that it was seen.
  Future<void> load(String id) async {
    final userId = _authenticationRepository.currentUserId;
    emit(state.copyWith(request: const Loading(), userId: userId));
    try {
      final request = await _annoyanceRepository.getGentleRequest(id);
      if (isClosed) return;
      emit(state.copyWith(request: Success(request)));
      if (request != null && userId == request.recipientId && request.seenAt == null) {
        await _annoyanceRepository.markSeen(id);
      }
    } catch (exception) {
      if (!isClosed) emit(state.copyWith(request: Failure.fromObject(exception)));
    }
  }

  /// Answers the request the person received.
  Future<void> respond(GentleResponse response) async {
    final request = _request;
    if (request == null || state.action.isLoading) return;

    await _run(() => _annoyanceRepository.respond(id: request.id, response: response), request.id);
  }

  /// Thanks for a promise that was kept; [body] becomes a good slip of the sender.
  Future<void> thank(String body) async {
    final request = _request;
    if (request == null || state.action.isLoading) return;

    await _run(() => _annoyanceRepository.thank(requestId: request.id, body: body), request.id);
  }

  GentleRequest? get _request => switch (state.request) {
    Success<GentleRequest?>(:final value) => value,
    _ => null,
  };

  Future<void> _run(Future<void> Function() action, String id) async {
    emit(state.copyWith(action: const Loading()));
    try {
      await action();
      emit(state.copyWith(action: const Success(null)));
      emit(state.copyWith(action: const Initial()));
      await load(id);
    } catch (exception) {
      emit(state.copyWith(action: Failure.fromObject(exception)));
      emit(state.copyWith(action: const Initial()));
    }
  }
}
