import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/annoyances/data/data_sources/remote/fragments/generated/GentleRequestFragment.graphql.dart';
import 'package:app/features/annoyances/data/mappers/gentle_request_mapper.dart';
import 'package:app/features/annoyances/data/models/gentle_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FragmentGentleRequestFragment node({
    EnumGentleResponse_enum? response,
    DateTime? seenAt,
    DateTime? thankedAt,
  }) => FragmentGentleRequestFragment(
    id: 'r1',
    whenText: 'quando',
    feelText: 'sinto',
    wishText: 'queria',
    senderId: 's',
    recipientId: 'r',
    response: response,
    seenAt: seenAt,
    thankedAt: thankedAt,
    createdAt: DateTime.utc(2026),
    sender: FragmentGentleRequestFragmentsender(displayName: 'Ana'),
    recipient: FragmentGentleRequestFragmentrecipient(displayName: 'Rui'),
  );

  test('copies the three sentences, the people and their names', () {
    final request = node().toModel();

    expect(request.id, 'r1');
    expect(request.whenText, 'quando');
    expect(request.feelText, 'sinto');
    expect(request.wishText, 'queria');
    expect(request.senderId, 's');
    expect(request.recipientId, 'r');
    expect(request.senderName, 'Ana');
    expect(request.recipientName, 'Rui');
    expect(request.createdAt, DateTime.utc(2026));
  });

  test('an unanswered request has no response', () {
    expect(node().toModel().response, isNull);
  });

  test('a stored answer becomes the matching response', () {
    expect(
      node(response: EnumGentleResponse_enum.will_do).toModel().response,
      GentleResponse.willDo,
    );
  });

  test('an answer this version does not know reads as none', () {
    expect(node(response: EnumGentleResponse_enum.$unknown).toModel().response, isNull);
  });

  test('seen and thanked times are kept', () {
    final seen = DateTime.utc(2026, 1, 2);
    final thanked = DateTime.utc(2026, 1, 3);
    final request = node(seenAt: seen, thankedAt: thanked).toModel();

    expect(request.seenAt, seen);
    expect(request.thankedAt, thanked);
  });
}
