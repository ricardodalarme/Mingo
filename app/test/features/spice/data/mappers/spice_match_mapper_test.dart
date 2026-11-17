import 'package:app/features/spice/data/data_sources/remote/queries/generated/SpiceMatches.graphql.dart';
import 'package:app/features/spice/data/mappers/spice_match_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a match keeps its slug and title', () {
    final match = QuerySpiceMatchesspiceMatches(slug: 'm', title: 'Dançar').toModel();

    expect(match.slug, 'm');
    expect(match.title, 'Dançar');
  });
}
