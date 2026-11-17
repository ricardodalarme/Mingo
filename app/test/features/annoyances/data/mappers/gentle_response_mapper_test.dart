import 'package:app/features/annoyances/data/mappers/gentle_response_mapper.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('every response survives a trip to the stored spelling and back', () {
    for (final response in GentleResponse.values) {
      expect(response.toRemote().toGentleResponse(), response);
    }
  });

  test('each response has its own stored spelling', () {
    final spellings = {for (final response in GentleResponse.values) response.toRemote()};

    expect(spellings, hasLength(GentleResponse.values.length));
  });

  test('an unknown spelling reads as no response', () {
    expect('from_the_future'.toGentleResponse(), isNull);
  });
}
