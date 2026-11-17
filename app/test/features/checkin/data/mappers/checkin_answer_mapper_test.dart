import 'package:app/features/checkin/data/mappers/checkin_answer_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a row of the week becomes an answer to its question', () {
    final answer = (id: 'a1', isMine: true, question: 2, body: 'Uma boa semana').toModel();

    expect(answer.id, 'a1');
    expect(answer.question, 2);
    expect(answer.body, 'Uma boa semana');
  });

  test('a row just written becomes an answer to its question', () {
    final answer = (id: 'a1', question: 4, body: 'Obrigada').toModel();

    expect(answer.id, 'a1');
    expect(answer.question, 4);
    expect(answer.body, 'Obrigada');
  });
}
