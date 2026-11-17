import 'package:app/features/account/data/repositories/account_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'export_data_state.dart';

class ExportDataCubit({required final AccountRepository _repository})
    extends Cubit<ExportDataState> {
  this : super(const ExportDataState());

  /// Builds the file; the link in a success is short-lived, so it is opened at once.
  Future<void> export() async {
    if (state.exportAction.isLoading) return;

    emit(state.copyWith(exportAction: const Loading()));
    try {
      emit(state.copyWith(exportAction: Success(await _repository.exportData())));
    } catch (exception) {
      emit(state.copyWith(exportAction: Failure.fromObject(exception)));
    }
  }
}
