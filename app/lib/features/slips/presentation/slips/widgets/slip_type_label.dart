import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The name of the type a slip note shows: its category, else its kind, else "liked".
String slipTypeLabel(
  BuildContext context, {
  required SlipCategory? category,
  required SlipKind kind,
}) {
  final l10n = context.l10n.slipsList;
  if (category != null) return l10n.categories.selectOrFallback(category.name);
  if (kind == SlipKind.quick) return context.l10n.quickSlip.polarityLiked;

  return l10n.kinds.selectOrFallback(kind.name);
}
