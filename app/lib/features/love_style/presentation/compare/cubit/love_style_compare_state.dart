part of 'love_style_compare_cubit.dart';

final class const LoveStyleCompareState({
  final Resource<LoveStyleComparison?> comparison = const Loading(),
  final String? partnerName,
}) with Equatable {
  LoveStyleCompareState copyWith({
    Resource<LoveStyleComparison?>? comparison,
    String? partnerName,
    bool clearPartnerName = false,
  }) {
    return LoveStyleCompareState(
      comparison: comparison ?? this.comparison,
      partnerName: partnerName ?? (clearPartnerName ? null : this.partnerName),
    );
  }

  @override
  List<Object?> get props => [comparison, partnerName];
}
