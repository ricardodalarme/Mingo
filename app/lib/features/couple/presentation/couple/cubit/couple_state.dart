part of 'couple_cubit.dart';

/// The two parts of Nós.
enum CoupleSection() {
  together,
  memories,
}

final class const CoupleState({final CoupleSection section = CoupleSection.together})
    with Equatable {
  @override
  List<Object?> get props => [section];
}
