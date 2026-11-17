import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/queries/generated/SlipDetail.graphql.dart';
import 'package:app/features/slips/data/data_sources/remote/slip_data_source.dart';
import 'package:app/features/slips/data/mappers/slip_detail_mapper.dart';
import 'package:app/features/slips/data/models/slip_category.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/features/slips/data/models/slip_work_area.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final createdAt = DateTime.utc(2026, 3, 10, 12);

  SlipRow row({
    DateTime? archivedAt,
    bool inJar = false,
    bool wasInCard = false,
    EnumSlipKind_enum kind = EnumSlipKind_enum.specific,
  }) => (
    slip: QuerySlipDetailslipsByPk(
      id: 's1',
      body: 'Fez café',
      kind: kind,
      feeling: 'feliz',
      planNote: 'repetir',
      forCard: true,
      category: EnumSlipCategory_enum.helped,
      workArea: EnumWorkArea_enum.kitchen,
      createdAt: createdAt,
      archivedAt: archivedAt,
      inJar: inJar,
    ),
    wasInCard: wasInCard,
  );

  test('copies the text, the notes and the card choice', () {
    final slip = row().toModel();

    expect(slip.id, 's1');
    expect(slip.body, 'Fez café');
    expect(slip.feeling, 'feliz');
    expect(slip.planNote, 'repetir');
    expect(slip.forCard, isTrue);
    expect(slip.createdAt, createdAt);
  });

  test('maps the kind, the category and the work area', () {
    final slip = row().toModel();

    expect(slip.kind, SlipKind.specific);
    expect(slip.category, SlipCategory.helped);
    expect(slip.workArea, SlipWorkArea.kitchen);
  });

  test('a kind this version does not know reads as a quick slip', () {
    expect(row(kind: EnumSlipKind_enum.$unknown).toModel().kind, SlipKind.quick);
  });

  test('a slip is archived once it has an archive time', () {
    expect(row().toModel().isArchived, isFalse);
    expect(row(archivedAt: createdAt).toModel().isArchived, isTrue);
  });

  test('the jar and the card flags come from the row', () {
    final slip = row(inJar: true, wasInCard: true).toModel();

    expect(slip.isInJar, isTrue);
    expect(slip.wasInCard, isTrue);
    expect(row().toModel().isInJar, isFalse);
    expect(row().toModel().wasInCard, isFalse);
  });
}
