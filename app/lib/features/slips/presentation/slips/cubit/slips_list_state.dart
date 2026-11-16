part of 'slips_list_cubit.dart';

/// Which slips the list shows.
enum SlipsScope() {
  /// Slips written since Monday.
  week,

  /// Every slip.
  all,

  /// Slips taken out of the week and the timeline.
  archived,
}

final class const SlipsListState({
  final Resource<List<SlipEntry>> slips = const Loading(),
  final SlipsScope scope = SlipsScope.week,
  final bool hasNext = false,
  final int offset = 0,
  final bool isLoadingMore = false,
  final bool isSearching = false,
  final String query = '',
}) with Equatable {
  /// The loaded slips whose text contains [query], ignoring case.
  List<SlipEntry> matching(List<SlipEntry> items) {
    final needle = query.trim().toLowerCase();
    if (needle.isEmpty) return items;

    return [
      for (final item in items)
        if (item.body.toLowerCase().contains(needle)) item,
    ];
  }

  SlipsListState copyWith({
    Resource<List<SlipEntry>>? slips,
    SlipsScope? scope,
    bool? hasNext,
    int? offset,
    bool? isLoadingMore,
    bool? isSearching,
    String? query,
  }) {
    return SlipsListState(
      slips: slips ?? this.slips,
      scope: scope ?? this.scope,
      hasNext: hasNext ?? this.hasNext,
      offset: offset ?? this.offset,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [slips, scope, hasNext, offset, isLoadingMore, isSearching, query];
}
