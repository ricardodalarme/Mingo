part of 'slips_search_cubit.dart';

/// The narrowing choices on the search page.
enum SlipsSearchFilter() {
  thisMonth,
  private,
  inCard,
  invisible,
}

final class const SlipsSearchState({
  final Resource<List<SlipEntry>> results = const Loading(),
  final String query = '',
  final Set<SlipsSearchFilter> filters = const {},
  final bool hasNext = false,
  final bool isLoadingMore = false,
}) with Equatable {
  SlipsSearchState copyWith({
    Resource<List<SlipEntry>>? results,
    String? query,
    Set<SlipsSearchFilter>? filters,
    bool? hasNext,
    bool? isLoadingMore,
  }) {
    return SlipsSearchState(
      results: results ?? this.results,
      query: query ?? this.query,
      filters: filters ?? this.filters,
      hasNext: hasNext ?? this.hasNext,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [results, query, filters, hasNext, isLoadingMore];
}
