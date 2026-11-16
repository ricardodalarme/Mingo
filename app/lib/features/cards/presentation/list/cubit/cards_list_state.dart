part of 'cards_list_cubit.dart';

final class const CardsListState({
  final Resource<List<CardSummary>> cards = const Loading(),
  final bool hasNext = false,
  final int offset = 0,
  final bool isLoadingMore = false,
}) with Equatable {
  CardsListState copyWith({
    Resource<List<CardSummary>>? cards,
    bool? hasNext,
    int? offset,
    bool? isLoadingMore,
  }) => CardsListState(
    cards: cards ?? this.cards,
    hasNext: hasNext ?? this.hasNext,
    offset: offset ?? this.offset,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );

  @override
  List<Object?> get props => [cards, hasNext, offset, isLoadingMore];
}
