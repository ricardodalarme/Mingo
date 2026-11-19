import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/gifts/data/mappers/gift_enum_mapper.dart';
import 'package:app/features/gifts/data/models/gift_idea_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a gift idea status survives a trip to the remote enum and back', () {
    for (final value in GiftIdeaStatus.values) {
      expect(value.toRemote().toModel(), value);
    }
  });

  test('an unknown status is an idea', () {
    expect(EnumGiftIdeaStatus_enum.$unknown.toModel(), GiftIdeaStatus.idea);
  });
}
