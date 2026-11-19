part of 'couple_cubit.dart';

final class const CoupleState({final DateTime? togetherSince}) with Equatable {
  CoupleState copyWith({DateTime? togetherSince}) {
    return CoupleState(togetherSince: togetherSince ?? this.togetherSince);
  }

  @override
  List<Object?> get props => [togetherSince];
}
