import 'package:app/features/_shared/data/data_sources/remote/generated/schema.graphql.dart';
import 'package:app/features/repair/data/data_sources/remote/mutations/generated/RespondToSignal.graphql.dart';
import 'package:app/features/repair/data/mappers/signal_answer_mapper.dart';
import 'package:app/features/repair/data/models/received_signal.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('an answer keeps the response and its times', () {
    final answered = DateTime.utc(2026, 3, 9);
    final seen = DateTime.utc(2026, 3, 8);

    final answer = MutationRespondToSignalupdateSignalsByPk(
      id: 's1',
      response: EnumSignalResponse_enum.talk,
      respondedAt: answered,
      seenAt: seen,
    ).toModel();

    expect(answer.response, RepairResponse.talk);
    expect(answer.respondedAt, answered);
    expect(answer.seenAt, seen);
  });

  test('marking a message seen answers nothing', () {
    final answer = MutationRespondToSignalupdateSignalsByPk(
      id: 's1',
      seenAt: DateTime.utc(2026, 3, 8),
    ).toModel();

    expect(answer.response, isNull);
    expect(answer.respondedAt, isNull);
    expect(answer.seenAt, DateTime.utc(2026, 3, 8));
  });
}
