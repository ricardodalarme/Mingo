import 'package:app/features/slips/data/mappers/slip_note_mapper.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// One slip on the wall; opens its detail.
class const SlipNoteCard({
  required final SlipEntry slip,
  final bool animatesEntrance = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final day = l10n.weekdaysShort[slip.createdAt.toLocal().weekday - 1];
    final typeLabel = _typeLabel(context);

    return BaseSlipNote(
      text: slip.body,
      type: slip.category.toNoteType(),
      typeLabel: typeLabel,
      dayLabel: day,
      tilt: slipNoteTilt(slip.id),
      animatesEntrance: animatesEntrance,
      semanticLabel: l10n.noteLabel(body: slip.body, type: typeLabel, day: day),
      onTap: () => context.pushRoute(SlipDetailRoute(id: slip.id)),
    );
  }

  String _typeLabel(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final category = slip.category;
    if (category != null) return l10n.categories.selectOrFallback(category.name);
    if (slip.kind == SlipKind.quick) return context.l10n.quickSlip.polarityLiked;

    return l10n.kinds.selectOrFallback(slip.kind.name);
  }
}
