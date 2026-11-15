import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/models/need_kind.dart';
import 'package:app/features/mood/data/models/partner_mood.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mood_state.dart';

class MoodCubit({
  required final MoodRepository _moodRepository,
  required final SlipRepository _slipRepository,
}) extends Cubit<MoodState> {
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

  /// Saves [mood] as today's mood from a single tap, painting it before the write returns.
  ///
  /// A tap on the mood already saved writes nothing; a failed write puts back what was on
  /// screen so the strip never shows a mood the server does not have.
  Future<void> saveTodayMood(MoodKind mood) async {
    if (isClosed || state.saveAction.isLoading) return;
    final savedMood = switch (state.entry) {
      Success(:final value) => value?.mood,
      _ => null,
    };
    if (savedMood == mood) return;

    final previous = state;
    emit(state.copyWith(mood: mood, saveAction: const Loading()));
    try {
      final entry = await _moodRepository.saveMood(
        mood: mood,
        need: state.need,
        share: state.share,
      );
      if (isClosed) return;
      emit(_fromEntry(entry).copyWith(saveAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(previous.copyWith(saveAction: Failure.fromObject(exception)));
      emit(previous.copyWith(saveAction: const Initial()));
    }
  }

  /// Saves what the person needs today, keeping the mood and audience already chosen.
  ///
  /// A need cleared while the audience shared it falls back to sharing the mood only.
  Future<void> saveNeed({required MoodKind mood, required NeedKind? need}) async {
    if (isClosed || state.needAction.isLoading) return;

    final share = need == null && state.share == MoodShare.moodNeed ? MoodShare.mood : state.share;
    emit(state.copyWith(needAction: const Loading()));
    try {
      final entry = await _moodRepository.saveMood(mood: mood, need: need, share: share);
      if (isClosed) return;
      emit(_fromEntry(entry).copyWith(needAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(needAction: Failure.fromObject(exception)));
      emit(state.copyWith(needAction: const Initial()));
    }
  }

  /// Sends the partner a one-tap hug when their shared mood is a good one or asks for one.
  Future<void> reactToPartner() async {
    if (isClosed || state.reactAction.isLoading) return;

    emit(state.copyWith(reactAction: const Loading()));
    try {
      await _slipRepository.sendHug();
      if (isClosed) return;
      emit(state.copyWith(reactAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(reactAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(reactAction: const Initial()));
  }

  /// Asks the partner if they want to talk, as a need they can answer.
  Future<void> askToTalk() async {
    if (isClosed || state.talkAction.isLoading) return;

    emit(state.copyWith(talkAction: const Loading()));
    try {
      await _slipRepository.askToTalk();
      if (isClosed) return;
      emit(state.copyWith(talkAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(talkAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(talkAction: const Initial()));
  }

  /// Sends the partner a hug with [body], a short message of a line or two.
  Future<void> sendSweetMessage(String body) async {
    if (isClosed || state.messageAction.isLoading) return;

    emit(state.copyWith(messageAction: const Loading()));
    try {
      await _slipRepository.sendSweetMessage(body);
      if (isClosed) return;
      emit(state.copyWith(messageAction: const Success(null)));
    } catch (exception) {
      if (isClosed) return;
      emit(state.copyWith(messageAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(messageAction: const Initial()));
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
