import 'package:app/features/questions/data/data_sources/remote/questions_data_source.dart';
import 'package:app/features/questions/data/mappers/question_prompt_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  QuestionPromptRecord record({bool isPaired = true, String? partnerName = 'Rui'}) => (
    slug: 'q1',
    title: 'O que te fez sorrir?',
    body: 'Conte um momento.',
    tags: const ['gratidão'],
    isPaired: isPaired,
    partnerName: partnerName,
    coupleId: 'c1',
    selfId: 'me',
  );

  test('copies the question and the couple context', () {
    final prompt = record().toModel();

    expect(prompt.slug, 'q1');
    expect(prompt.title, 'O que te fez sorrir?');
    expect(prompt.body, 'Conte um momento.');
    expect(prompt.tags, ['gratidão']);
    expect(prompt.coupleId, 'c1');
    expect(prompt.selfId, 'me');
  });

  test('a person without a partner is not paired and the partner has no name', () {
    final prompt = record(isPaired: false, partnerName: null).toModel();

    expect(prompt.isPaired, isFalse);
    expect(prompt.partnerName, isNull);
  });
}
