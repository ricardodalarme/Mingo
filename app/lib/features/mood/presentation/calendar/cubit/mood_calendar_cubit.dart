import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_calendar_state.dart';

class MoodCalendarCubit({required final MoodRepository _moodRepository})
    extends Cubit<MoodCalendarState> {
  this : super(const MoodCalendarState());

  /// Reads the current month of the person's own moods.
  Future<void> load() async {
    if (isClosed) return;
    final now = clock.now();
    emit(state.copyWith(month: DateTime(now.year, now.month), entries: const Loading()));
    try {
      final entries = await _moodRepository.getMonthMoods(month: now);
      if (isClosed) return;
      emit(state.copyWith(entries: Success(entries)));
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed) return;
      emit(state.copyWith(entries: Failure.fromObject(exception)));
    }
  }
}
