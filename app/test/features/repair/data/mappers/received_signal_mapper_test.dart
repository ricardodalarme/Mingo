import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/queries/generated/ReceivedSignals.graphql.dart';
import 'package:app/features/repair/data/mappers/received_signal_mapper.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final created = DateTime.utc(2026, 3, 8);

  test('an unanswered message keeps its kind, value and text', () {
    final signal = QueryReceivedSignalssignals(
      id: 's1',
      kind: EnumSignalKind_enum.miss_us,
      value: 'hoje',
      body: 'Saudade',
      createdAt: created,
    ).toModel();

    expect(signal.id, 's1');
    expect(signal.kind, SignalKind.missUs);
    expect(signal.value, 'hoje');
    expect(signal.body, 'Saudade');
    expect(signal.createdAt, created);
    expect(signal.response, isNull);
    expect(signal.respondedAt, isNull);
    expect(signal.seenAt, isNull);
  });

  test('an answered message keeps the response and when it was answered and seen', () {
    final answered = DateTime.utc(2026, 3, 9);
    final seen = DateTime.utc(2026, 3, 8, 12);

    final signal = QueryReceivedSignalssignals(
      id: 's1',
      kind: EnumSignalKind_enum.need,
      response: EnumSignalResponse_enum.here,
      respondedAt: answered,
      seenAt: seen,
      createdAt: created,
    ).toModel();

    expect(signal.response, RepairResponse.here);
    expect(signal.respondedAt, answered);
    expect(signal.seenAt, seen);
  });
}
