import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceDesires.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_desire_mapper.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a desire keeps its level and the answer the person gave', () {
    final desire = QuerySpiceDesirescontentItems(
      slug: 'd',
      title: 'Massagem',
      level: 2,
    ).toModel(answer: SpiceAnswer.want);

    expect(desire.slug, 'd');
    expect(desire.title, 'Massagem');
    expect(desire.level, SpiceLevel.warm);
    expect(desire.answer, SpiceAnswer.want);
  });

  test('a desire nobody answered has no answer, and a missing level is soft', () {
    final desire = QuerySpiceDesirescontentItems(slug: 'd', title: 'Massagem').toModel();

    expect(desire.answer, isNull);
    expect(desire.level, SpiceLevel.soft);
  });
}
