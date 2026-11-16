import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/mappers/pronoun_mapper.dart';
import 'package:app/features/profile/data/models/pronoun.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a pronoun survives a trip to the remote enum and back', () {
    for (final value in Pronoun.values) {
      expect(value.toRemote().toModel(), value);
    }
  });

  test('the name-only choice keeps its stored spelling', () {
    expect(Pronoun.nameOnly.toRemote(), EnumPronoun_enum.name_only);
  });

  test('a pronoun this version does not know is left out', () {
    expect(EnumPronoun_enum.$unknown.toModel(), isNull);
  });
}
