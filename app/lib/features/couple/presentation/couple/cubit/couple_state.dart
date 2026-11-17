part of 'couple_cubit.dart';

/// The two parts of Nós.
enum CoupleSection() {
  together,
  memories,
}

final class const CoupleState({
  final CoupleSection section = CoupleSection.together,
  final DateTime? togetherSince,
  final bool hasPartner = false,
}) with Equatable {
  CoupleState copyWith({CoupleSection? section, DateTime? togetherSince, bool? hasPartner}) {
    return CoupleState(
      section: section ?? this.section,
      togetherSince: togetherSince ?? this.togetherSince,
      hasPartner: hasPartner ?? this.hasPartner,
    );
  }

  @override
  List<Object?> get props => [section, togetherSince, hasPartner];
}
