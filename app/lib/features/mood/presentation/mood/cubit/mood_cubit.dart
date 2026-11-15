import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_state.dart';

class MoodCubit({required final MoodRepository _moodRepository}) extends Cubit<MoodState> {
  this : super(const MoodState());

  /// Reads today's row and starts the form from it; a missing row starts private.
  ///
  /// Today's mood cached on the device paints first and stays until the fresh read returns.
  Future<void> load() async {
    if (isClosed) return;
    if (state.entry is! Success) {
      final cached = _moodRepository.readCachedTodayMood();
      if (cached == null) {
        emit(state.copyWith(entry: const Loading()));
      } else {
        emit(_fromEntry(cached));
      }
    }
    try {
      final today = await _moodRepository.getTodayMood();
      if (isClosed) return;
      emit(
        _fromEntry(today.entry).copyWith(
          partnerMood: today.partnerMood,
          clearPartnerMood: today.partnerMood == null,
          partnerName: today.partnerName,
          clearPartnerName: true,
        ),
      );
    } catch (exception) {
      if (isClosed || state.entry is Success) return;
      emit(state.copyWith(entry: Failure.fromObject(exception)));
    }
  }

  void selectMood(MoodKind mood) {
    if (state.saveAction.isLoading) return;
    emit(state.copyWith(mood: mood));
  }

  /// Tapping the selected need clears it; a need-only share falls back to mood-only.
  void toggleNeed(NeedKind need) {
    if (state.saveAction.isLoading) return;

    final isSame = state.need == need;
    emit(
      state.copyWith(
        need: isSame ? null : need,
        clearNeed: isSame,
        share: isSame && state.share == MoodShare.moodNeed ? MoodShare.mood : state.share,
      ),
    );
  }

  void selectShare(MoodShare share) {
    if (state.saveAction.isLoading) return;
    if (share == MoodShare.moodNeed && state.need == null) return;
    emit(state.copyWith(share: share));
  }

  /// Saves today's row; a second save updates the same row instead of adding another.
  Future<void> save() async {
    if (isClosed || !state.canSave) return;

    emit(state.copyWith(saveAction: const Loading()));
    try {
      final entry = await _moodRepository.saveMood(
        mood: state.mood!,
        need: state.need,
        share: state.share,
      );
      if (isClosed) return;
      emit(_fromEntry(entry).copyWith(saveAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(saveAction: Failure.fromObject(exception)));
      emit(state.copyWith(saveAction: const Initial()));
    }
  }

  MoodState _fromEntry(MoodEntry? entry) => state.copyWith(
    entry: Success(entry),
    mood: entry?.mood,
    need: entry?.need,
    share: entry?.share ?? MoodShare.none,
    clearMood: entry?.mood == null,
    clearNeed: entry?.need == null,
  );
}
