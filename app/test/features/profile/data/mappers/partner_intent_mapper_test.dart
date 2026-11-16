import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/profile/data/mappers/partner_intent_mapper.dart';
import 'package:app/features/profile/data/models/partner_intent.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an intent survives a trip to the remote enum and back', () {
    for (final value in PartnerIntent.values) {
      expect(value.toRemote().toModel(), value);
    }
  });

  test('the solo-only choice keeps its stored spelling', () {
    expect(PartnerIntent.soloOnly.toRemote(), EnumPartnerIntent_enum.solo_only);
  });

  test('an intent this version does not know is left out', () {
    expect(EnumPartnerIntent_enum.$unknown.toModel(), isNull);
  });
}
