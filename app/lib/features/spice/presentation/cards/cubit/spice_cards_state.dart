part of 'spice_cards_cubit.dart';

final class const SpiceCardsState({
  final Resource<SpiceCard?> card = const Loading(),
  final bool isAnswered = false,
  final Resource<void> respondAction = const Initial(),
}) with Equatable {
  SpiceCardsState copyWith({
    Resource<SpiceCard?>? card,
    bool? isAnswered,
    Resource<void>? respondAction,
  }) {
    return SpiceCardsState(
      card: card ?? this.card,
      isAnswered: isAnswered ?? this.isAnswered,
      respondAction: respondAction ?? this.respondAction,
    );
  }

  @override
  List<Object?> get props => [card, isAnswered, respondAction];
}
