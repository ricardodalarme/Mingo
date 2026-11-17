import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:app/features/love_style/data/repositories/love_style_repository.dart';
import 'package:app/features/pairing/data/repositories/pairing_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'love_style_compare_state.dart';

class LoveStyleCompareCubit({
  required final LoveStyleRepository _repository,
  required final PairingRepository _pairingRepository,
}) extends Cubit<LoveStyleCompareState> {
  this : super(const LoveStyleCompareState());

  /// Reads both results; the comparison only exists when the two people showed theirs.
  Future<void> load() async {
    emit(state.copyWith(comparison: const Loading()));
    try {
      final (overview, partner) = await (_repository.getOverview(), _readPartnerName()).wait;
      final own = overview.own;
      final theirs = overview.partner;
      final comparison = own != null && own.isShared && theirs != null
          ? LoveStyleComparison(own: own.knownRanked, partner: theirs.knownRanked)
          : null;
      if (isClosed) return;
      emit(
        state.copyWith(
          comparison: Success<LoveStyleComparison?>(comparison),
          partnerName: partner,
          clearPartnerName: partner == null,
        ),
      );
    } catch (exception, stack) {
      addError(exception, stack);
      if (isClosed) return;
      emit(state.copyWith(comparison: Failure.fromObject(exception)));
    }
  }

  Future<String?> _readPartnerName() async {
    try {
      return (await _pairingRepository.getPartner())?.displayName;
    } on Object {
      return null;
    }
  }
}
