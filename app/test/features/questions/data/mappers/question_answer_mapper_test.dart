import 'package:app/features/questions/data/mappers/question_answer_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a saved answer keeps its id and text', () {
    final answer = (id: 'a1', coupleId: 'c1', body: 'Um café juntos').toModel();

    expect(answer.id, 'a1');
    expect(answer.body, 'Um café juntos');
  });
}
