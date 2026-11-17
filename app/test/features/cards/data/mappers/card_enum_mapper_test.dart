import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/cards/data/mappers/card_enum_mapper.dart';
import 'package:app/features/cards/data/models/card_status.dart';
import 'package:app/features/cards/data/models/held_reason.dart';
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

  test('every held reason has its model, and an unknown one has none', () {
    expect(EnumHeldReason_enum.absolute.toModel(), HeldReason.absolute);
    expect(EnumHeldReason_enum.insult.toModel(), HeldReason.insult);
    expect(EnumHeldReason_enum.blame.toModel(), HeldReason.blame);
    expect(EnumHeldReason_enum.contempt.toModel(), HeldReason.contempt);
    expect(EnumHeldReason_enum.$unknown.toModel(), isNull);
  });
}
