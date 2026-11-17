import 'package:app/features/plus/data/models/plus_state.dart';
import 'package:app/features/plus/data/repositories/plus_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_plus_state.dart';

class ManagePlusCubit({required final PlusRepository _plusRepository})
    extends Cubit<ManagePlusState> {
  this : super(const ManagePlusState());

  Future<void> load() async {
    emit(const ManagePlusState());
    try {
      final plus = await _plusRepository.getPlus();
      if (isClosed) return;
      emit(state.copyWith(plus: Success(plus)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed) return;
      emit(state.copyWith(plus: Failure.fromObject(exception)));
    }
  }

  /// Reads the store page for the subscription.
  Future<void> openManagement() async {
    if (state.manageAction.isLoading) return;

    emit(state.copyWith(manageAction: const Loading()));
    try {
      final url = await _plusRepository.getManagementUrl();
      if (isClosed) return;
      emit(
        state.copyWith(
          manageAction: url == null
              ? const Failure(LocalizedException(l10nKey: 'manageUnavailable'))
              : Success(url),
        ),
      );
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed) return;
      emit(state.copyWith(manageAction: Failure.fromObject(exception)));
    }
  }

  void clearManagement() => emit(state.copyWith(manageAction: const Initial()));
}
