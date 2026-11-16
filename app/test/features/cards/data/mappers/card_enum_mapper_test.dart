import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/mappers/card_enum_mapper.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every remote card status maps to its model', () {
    expect(EnumCardStatus_enum.draft.toModel(), CardStatus.draft);
    expect(EnumCardStatus_enum.held.toModel(), CardStatus.held);
    expect(EnumCardStatus_enum.sent.toModel(), CardStatus.sent);
  });

  test('an unknown card status is left out', () {
    expect(EnumCardStatus_enum.$unknown.toModel(), isNull);
  });
}
