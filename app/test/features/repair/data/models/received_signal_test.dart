import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a need asks to talk, allows a not now and takes a heart', () {
    expect(SignalKind.need.answers, [
      RepairResponse.talk,
      RepairResponse.notNow,
      RepairResponse.heart,
    ]);
  });

  test('missing us asks to plan something, to talk and takes a heart', () {
    expect(SignalKind.missUs.answers, [
      RepairResponse.plan,
      RepairResponse.talk,
      RepairResponse.heart,
    ]);
  });

  test('a hug only takes a heart', () {
    expect(SignalKind.hug.answers, [RepairResponse.heart]);
  });

  test('distance says I am here and answers later', () {
    expect(SignalKind.distance.answers, [RepairResponse.here, RepairResponse.later]);
  });

  test('a repair card offers the answers it always offered', () {
    expect(SignalKind.repair.answers, [
      RepairResponse.talk,
      RepairResponse.moreTime,
      RepairResponse.later,
    ]);
  });

  test('good news takes a heart', () {
    expect(SignalKind.goodNews.answers, [RepairResponse.heart]);
  });

  test('only missing us and good news can be acknowledged without an answer', () {
    for (final kind in SignalKind.values) {
      expect(
        kind.acceptsAcknowledgement,
        kind == SignalKind.missUs || kind == SignalKind.goodNews,
        reason: kind.name,
      );
    }
  });

  test('a message with a stored answer or a seen mark is already answered', () {
    final signal = ReceivedSignal(
      id: 's1',
      kind: SignalKind.hug,
      createdAt: DateTime(2026, 11, 10),
    );

    expect(signal.isAnswered, isFalse);
    expect(signal.copyWith(response: RepairResponse.heart).isAnswered, isFalse);
    expect(signal.copyWith(seenAt: DateTime(2026, 11, 10)).isAnswered, isTrue);
    expect(signal.copyWith(respondedAt: DateTime(2026, 11, 10)).isAnswered, isTrue);
  });
}
