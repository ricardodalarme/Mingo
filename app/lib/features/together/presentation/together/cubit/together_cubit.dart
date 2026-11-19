import 'dart:async';

import 'package:app/features/checkin/data/repositories/checkin_repository.dart';
import 'package:app/features/gifts/data/repositories/gifts_repository.dart';
import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/lists/data/repositories/lists_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/profile/data/models/relationship_phase.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/questions/data/repositories/questions_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'together_state.dart';

class TogetherCubit({
  required final PairingRepository _pairingRepository,
  required final CheckinRepository _checkinRepository,
  required final ListsRepository _listsRepository,
  required final QuestionsRepository _questionsRepository,
  required final ProfileRepository _profileRepository,
  required final GiftsRepository _giftsRepository,
  required final HistoryRepository _historyRepository,
}) extends Cubit<TogetherState> {
  this : super(const TogetherState()) {
    _phaseChanges = _profileRepository
        .watchMySettings()
        .map((settings) => settings.phase)
        .distinct()
        .skip(1)
        // A failed phase watcher keeps the hub as it is; a person's own action reads it again.
        .listen((_) => load(), onError: (Object _) {});
  }

  StreamSubscription<void>? _phaseChanges;

  /// Finds the partner, the check-in entry, the list count and the other hub details, all at once.
  ///
  /// Each detail has its own fallback, so one failing read never hides the hub.
  Future<void> load() async {
    final hasPartner = _orElse(() async => (await _pairingRepository.getPartner()) != null, true);
    final showCheckin = _orElse(
      () async => !(await _checkinRepository.isCurrentWeekDismissed()),
      true,
    );
    final listCount = _orElse(() async => (await _listsRepository.getLists()).length, 0);
    final phase = _orElse<RelationshipPhase?>(
      () async => (await _profileRepository.getMySettings()).phase,
      null,
    );
    final questionTitle = _orElse<String?>(
      () async => (await _questionsRepository.getPrompt()).title,
      null,
    );
    final sharedGiftCount = _orElse(() async => (await _giftsRepository.getGiftIdeas()).length, 0);
    final togetherSince = _orElse<DateTime?>(
      () async => (await _historyRepository.getOverview()).togetherSince,
      null,
    );

    final results = await Future.wait<Object?>([
      hasPartner,
      showCheckin,
      listCount,
      phase,
      questionTitle,
      sharedGiftCount,
      togetherSince,
    ]);

    if (isClosed) return;
    emit(
      state.copyWith(
        hasPartner: results[0]! as bool,
        showCheckin: results[1]! as bool,
        listCount: results[2]! as int,
        phase: results[3] as RelationshipPhase?,
        questionTitle: results[4] as String?,
        sharedGiftCount: results[5]! as int,
        togetherSince: results[6] as DateTime?,
      ),
    );
  }

  /// Runs one read and falls back to [fallback] when it fails, so the hub still opens.
  Future<T> _orElse<T>(Future<T> Function() read, T fallback) async {
    try {
      return await read();
    } on Object {
      return fallback;
    }
  }

  @override
  Future<void> close() async {
    await _phaseChanges?.cancel();

    return super.close();
  }
}
