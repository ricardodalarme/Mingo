import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:app/features/annoyances/data/repositories/annoyance_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'annoyance_check_state.dart';

class AnnoyanceCheckCubit({required final AnnoyanceRepository _annoyanceRepository})
    extends Cubit<AnnoyanceCheckState> {
  this : super(const AnnoyanceCheckState());

  /// Reads the annoyance; it is null when it already expired, was let go or became a request.
  Future<void> load(String id) async {
    emit(state.copyWith(annoyance: const Loading()));
    try {
      final annoyance = await _annoyanceRepository.get(id);
      if (!isClosed) emit(state.copyWith(annoyance: Success(annoyance)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (!isClosed) emit(state.copyWith(annoyance: Failure.fromObject(exception)));
    }
  }

  /// Deletes the annoyance for good, without telling anyone.
  Future<void> letGo(String id) async {
    if (state.letGoAction.isLoading) return;

    emit(state.copyWith(letGoAction: const Loading()));
    try {
      await _annoyanceRepository.delete(id);
      emit(state.copyWith(letGoAction: const Success(null)));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(letGoAction: Failure.fromObject(exception)));
      emit(state.copyWith(letGoAction: const Initial()));
    }
  }
}
