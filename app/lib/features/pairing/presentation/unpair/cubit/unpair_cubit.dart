import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:app/features/today/data/repositories/today_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'unpair_state.dart';

class UnpairCubit({
  required final PairingRepository _pairingRepository,
  required final TodayRepository _todayRepository,
  required final MoodRepository _moodRepository,
}) extends Cubit<UnpairState> {
  this : super(const UnpairState());

  Future<void> loadPartner() async {
    try {
      final partner = await _pairingRepository.getPartner();
      emit(state.copyWith(partnerName: partner?.displayName));
    } on Object {
      return;
    }
  }

  Future<void> unpair() async {
    if (state.unpairAction.isLoading) return;

    emit(state.copyWith(unpairAction: const Loading()));
    try {
      await _pairingRepository.unpair();
      // The server already ended the couple; forgetting the caches is best effort.
      try {
        await _todayRepository.clearCache();
        await _moodRepository.clearCache();
      } on Object {
        // The caches are replaced by the next read.
      }
      emit(state.copyWith(unpairAction: const Success(null)));
    } catch (exception) {
      emit(state.copyWith(unpairAction: Failure.fromObject(exception)));
    }
  }
}
