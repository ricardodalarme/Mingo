import 'package:app/features/history/data/repositories/history_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'couple_state.dart';

class CoupleCubit({required final HistoryRepository _historyRepository})
    extends Cubit<CoupleState> {
  this : super(const CoupleState());

  /// Opens one of the two parts of Nós.
  void select(CoupleSection section) => emit(state.copyWith(section: section));

  /// Reads the relationship start; a failed read leaves the chip plain.
  Future<void> load() async {
    try {
      final overview = await _historyRepository.getOverview();
      emit(state.copyWith(togetherSince: overview.togetherSince));
    } on Object {
      return;
    }
  }
}
