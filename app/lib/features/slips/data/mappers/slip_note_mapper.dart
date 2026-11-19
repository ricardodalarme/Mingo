import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:design_system/design_system.dart';

extension SlipCategoryNoteMapper on SlipCategory? {
  /// The note tint of a liked slip; one without a category reads as something done.
  SlipNoteType toNoteType() => switch (this) {
    SlipCategory.did || null => SlipNoteType.good,
    SlipCategory.helped => SlipNoteType.help,
    SlipCategory.noticed => SlipNoteType.notice,
    SlipCategory.said => SlipNoteType.said,
  };
}
