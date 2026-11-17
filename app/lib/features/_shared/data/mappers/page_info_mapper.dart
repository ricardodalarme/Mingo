import 'package:app/features/_shared/data/models/page_info.dart';

extension PageInfoMapper<R> on List<R> {
  /// The first [pageSize] rows mapped with [map]; the page has a next one when the read held more.
  PageInfo<T> toPageInfo<T>({
    required int offset,
    required int pageSize,
    required T Function(R row) map,
  }) {
    final pageRows = take(pageSize).toList();

    return PageInfo(
      items: [for (final row in pageRows) map(row)],
      hasNext: length > pageSize,
      offset: offset + pageRows.length,
    );
  }
}
