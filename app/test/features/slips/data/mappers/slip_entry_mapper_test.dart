import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/fragments/generated/SlipSummaryFragment.graphql.dart';
import 'package:app/features/slips/data/mappers/slip_entry_mapper.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final createdAt = DateTime.utc(2026, 3, 10, 12);

  FragmentSlipSummaryFragment row(
    String id, {
    EnumSlipKind_enum kind = EnumSlipKind_enum.quick,
    EnumSlipCategory_enum? category,
  }) => FragmentSlipSummaryFragment(
    id: id,
    body: 'texto $id',
    kind: kind,
    category: category,
    forCard: true,
    createdAt: createdAt,
  );

  test('a slip keeps its text, card choice and day', () {
    final entry = row('a', category: EnumSlipCategory_enum.did).toModel();

    expect(entry.id, 'a');
    expect(entry.body, 'texto a');
    expect(entry.forCard, isTrue);
    expect(entry.createdAt, createdAt);
    expect(entry.kind, SlipKind.quick);
    expect(entry.category, SlipCategory.did);
  });

  test('a slip with no category has none', () {
    expect(row('a').toModel().category, isNull);
  });

  test('a kind this version does not know reads as a quick slip', () {
    expect(row('a', kind: EnumSlipKind_enum.$unknown).toModel().kind, SlipKind.quick);
  });

  group('page', () {
    test('holds the first rows and says another page follows when the read had more', () {
      final page = [row('a'), row('b'), row('c')].toPage(offset: 0, pageSize: 2);

      expect(page.items.map((slip) => slip.id), ['a', 'b']);
      expect(page.hasNext, isTrue);
      expect(page.offset, 2);
    });

    test('the last page has no next one', () {
      final page = [row('a'), row('b')].toPage(offset: 20, pageSize: 2);

      expect(page.hasNext, isFalse);
      expect(page.offset, 22);
    });

    test('an empty read is an empty page', () {
      final page = <FragmentSlipSummaryFragment>[].toPage(offset: 0, pageSize: 20);

      expect(page.items, isEmpty);
      expect(page.hasNext, isFalse);
      expect(page.offset, 0);
    });
  });
}
