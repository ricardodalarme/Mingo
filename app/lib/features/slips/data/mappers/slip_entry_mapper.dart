import 'package:app/features/slips/data/data_sources/remote/fragments/generated/SlipSummaryFragment.graphql.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';

extension SlipEntryMapper on FragmentSlipSummaryFragment {
  /// The slip as the list shows it; a kind this version does not know reads as a quick slip.
  SlipEntry toModel() => SlipEntry(
    id: id,
    body: body,
    kind: kind.toModel() ?? SlipKind.quick,
    category: category?.toModel(),
    forCard: forCard,
    createdAt: createdAt,
  );
}

extension SlipPageMapper on List<FragmentSlipSummaryFragment> {
  /// The first [pageSize] slips; the page has a next one when the read held more than that.
  SlipPage toPage({required int offset, required int pageSize}) {
    final pageRows = take(pageSize).toList();

    return SlipPage(
      items: [for (final row in pageRows) row.toModel()],
      hasNext: length > pageSize,
      offset: offset + pageRows.length,
    );
  }
}
