import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'couple_state.dart';

class CoupleCubit({
  required final HistoryRepository _historyRepository,
  required final PairingRepository _pairingRepository,
}) extends Cubit<CoupleState> {
  this : super(const CoupleState());

  /// Opens one of the two parts of Nós.
  void select(CoupleSection section) => emit(state.copyWith(section: section));

  /// Reads the relationship start and whether there is a partner; a failed read leaves the chip plain.
  Future<void> load() async {
    try {
      final (overview, partner) = await (
        _historyRepository.getOverview(),
        _pairingRepository.getPartner(),
      ).wait;
      emit(state.copyWith(togetherSince: overview.togetherSince, hasPartner: partner != null));
    } on Object {
      return;
    }
  }
}
