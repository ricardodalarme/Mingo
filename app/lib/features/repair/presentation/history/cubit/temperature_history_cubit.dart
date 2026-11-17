import 'package:app/features/repair/data/models/temperature_history.dart';
import 'package:app/features/repair/data/repositories/repair_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'temperature_history_state.dart';

class TemperatureHistoryCubit({required final RepairRepository _repairRepository})
    extends Cubit<TemperatureHistoryState> {
  this : super(const TemperatureHistoryState());

  Future<void> load() async {
    if (state.checks is! Success) emit(state.copyWith(checks: const Loading()));
    try {
      final checks = await _repairRepository.getTemperatureChecks();
      emit(state.copyWith(checks: Success(checks)));
    } catch (exception) {
      if (state.checks is Success) return;
      emit(state.copyWith(checks: Failure.fromObject(exception)));
    }
  }
}
