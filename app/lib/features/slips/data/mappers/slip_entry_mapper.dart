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
