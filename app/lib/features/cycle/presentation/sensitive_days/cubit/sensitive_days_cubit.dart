import 'package:app/features/cycle/data/models/sensitive_day.dart';
import 'package:app/features/cycle/data/repositories/cycle_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sensitive_days_state.dart';

class SensitiveDaysCubit({required final CycleRepository _cycleRepository})
    extends Cubit<SensitiveDaysState> {
  this : super(const SensitiveDaysState());

  Future<void> load() async {
    if (isClosed) return;
    if (state.days is! Success) emit(state.copyWith(days: const Loading()));
    try {
      final value = await _cycleRepository.getSensitiveDays();
      if (isClosed) return;
      emit(state.copyWith(days: Success(value)));
    } catch (exception) {
      if (isClosed || state.days is Success) return;
      emit(state.copyWith(days: Failure.fromObject(exception)));
    }
  }

  /// Marks or unmarks today, keeping the calendar as it was until the write lands.
  Future<void> toggleToday() async {
    final value = state.currentDays;
    if (value == null || state.toggleAction.isLoading) return;

    final wasMarked = value.isTodayMarked;
    emit(state.copyWith(toggleAction: const Loading()));
    try {
      if (wasMarked) {
        await _cycleRepository.unmarkDay(value.today);
      } else {
        await _cycleRepository.markDay(value.today);
      }
      if (isClosed) return;
      emit(
        state.copyWith(
          days: Success(value.withToggled(value.today)),
          toggleAction: const Success(null),
        ),
      );
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(toggleAction: Failure.fromObject(exception)));
      emit(state.copyWith(toggleAction: const Initial()));
    }
  }
}
