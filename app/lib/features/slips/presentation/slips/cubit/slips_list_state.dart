part of 'slips_list_cubit.dart';

/// Which slips the list shows.
enum SlipsScope() {
  /// Slips written since Monday.
  week,

  /// Every slip.
  all,

  /// Slips kept out of the weekly card.
  private,

  /// The jar of good moments; it draws one slip instead of listing them.
  jar,
}

final class const SlipsListState({
  final Resource<List<SlipEntry>> slips = const Loading(),
  final SlipsScope scope = SlipsScope.week,
  final bool hasNext = false,
  final int offset = 0,
  final bool isLoadingMore = false,
}) with Equatable {
  SlipsListState copyWith({
    Resource<List<SlipEntry>>? slips,
    SlipsScope? scope,
    bool? hasNext,
    int? offset,
    bool? isLoadingMore,
  }) {
    return SlipsListState(
      slips: slips ?? this.slips,
      scope: scope ?? this.scope,
      hasNext: hasNext ?? this.hasNext,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [slips, scope, hasNext, offset, isLoadingMore];
}
