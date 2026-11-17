import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/queries/generated/MyLearnings.graphql.dart';
import 'package:app/features/repair/data/mappers/learning_mapper.dart';
import 'package:app/features/repair/data/models/guided_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a learning keeps its kind, note and day', () {
    final created = DateTime.utc(2026, 3, 8);

    final learning = QueryMyLearningsrepairLearnings(
      id: 'l1',
      kind: EnumRepairLearningKind_enum.good_fix,
      note: 'Pausar ajudou',
      createdAt: created,
    ).toModel();

    expect(learning.id, 'l1');
    expect(learning.kind, RepairLearningKind.goodFix);
    expect(learning.note, 'Pausar ajudou');
    expect(learning.createdAt, created);
  });
}
