import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/annoyances/data/mappers/gentle_response_mapper.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every response survives a trip to the remote enum and back', () {
    for (final response in GentleResponse.values) {
      expect(response.toRemote().toModel(), response);
    }
  });

  test('each response has its own remote value', () {
    final remote = {for (final response in GentleResponse.values) response.toRemote()};

    expect(remote, hasLength(GentleResponse.values.length));
  });

  test('an answer this version does not know reads as no response', () {
    expect(EnumGentleResponse_enum.$unknown.toModel(), isNull);
  });
}
