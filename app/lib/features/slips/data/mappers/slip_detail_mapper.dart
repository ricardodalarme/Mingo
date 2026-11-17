import 'package:app/features/slips/data/data_sources/remote/slip_data_source.dart';
import 'package:app/features/slips/data/mappers/slip_enum_mapper.dart';
import 'package:app/features/slips/data/models/slip_detail.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';

extension SlipDetailMapper on SlipRow {
  /// The slip with everything needed to read, edit and decide on it.
  SlipDetail toModel() => SlipDetail(
    id: slip.id,
    body: slip.body,
    kind: slip.kind.toModel() ?? SlipKind.quick,
    createdAt: slip.createdAt,
    forCard: slip.forCard,
    feeling: slip.feeling,
    planNote: slip.planNote,
    category: slip.category?.toModel(),
    workArea: slip.workArea?.toModel(),
    isArchived: slip.archivedAt != null,
    isInJar: slip.inJar,
    wasInCard: wasInCard,
  );
}
