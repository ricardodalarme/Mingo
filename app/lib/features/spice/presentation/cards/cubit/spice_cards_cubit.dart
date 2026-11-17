import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/data/repositories/spice_repository.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'spice_cards_state.dart';

class SpiceCardsCubit({required final SpiceRepository _spiceRepository})
    extends Cubit<SpiceCardsState> {
  this : super(const SpiceCardsState());

  /// Reads the open card, or draws a new one; a card left unanswered stays the same.
  Future<void> load() async {
    emit(state.copyWith(card: const Loading(), isAnswered: false));
    try {
      emit(state.copyWith(card: Success(await _spiceRepository.getNextCard())));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(card: Failure.fromObject(exception)));
    }
  }

  /// Answers the partner's card; a "not today" is never explained to them.
  Future<void> respond({required bool accept}) async {
    final card = state.card;
    if (card is! Success<SpiceCard?> || card.value == null || state.respondAction.isLoading) return;

    emit(state.copyWith(respondAction: const Loading()));
    try {
      await _spiceRepository.respondToCard(id: card.value!.id, accept: accept);
      emit(state.copyWith(respondAction: const Success(null), isAnswered: true));
    } catch (exception, stack) {
      addError(exception, stack);
      emit(state.copyWith(respondAction: Failure.fromObject(exception)));
    }
    emit(state.copyWith(respondAction: const Initial()));
  }
}
