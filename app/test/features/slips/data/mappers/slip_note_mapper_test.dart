import 'package:app/features/slips/data/mappers/slip_note_mapper.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps every category to its note type', () {
    expect(SlipCategory.did.toNoteType(), SlipNoteType.good);
    expect(SlipCategory.helped.toNoteType(), SlipNoteType.help);
    expect(SlipCategory.noticed.toNoteType(), SlipNoteType.notice);
    expect(SlipCategory.said.toNoteType(), SlipNoteType.said);
  });

  test('a slip without a category is a good note', () {
    const SlipCategory? none = null;

    expect(none.toNoteType(), SlipNoteType.good);
  });
}
