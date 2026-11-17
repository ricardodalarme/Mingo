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
}
