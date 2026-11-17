import 'package:app/features/annoyances/data/data_sources/remote/fragments/generated/AnnoyanceFragment.graphql.dart';
import 'package:app/features/annoyances/data/mappers/annoyance_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an annoyance keeps its text, when it was written and when it fades', () {
    final created = DateTime.utc(2026, 3, 1);
    final expires = DateTime.utc(2026, 3, 15);

    final annoyance = FragmentAnnoyanceFragment(
      id: 'a1',
      body: 'Deixou a louça',
      createdAt: created,
      expiresAt: expires,
    ).toModel();

    expect(annoyance.id, 'a1');
    expect(annoyance.body, 'Deixou a louça');
    expect(annoyance.createdAt, created);
    expect(annoyance.expiresAt, expires);
  });
}
