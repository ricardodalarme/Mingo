import 'package:app/features/love_style/presentation/exercise/cubit/love_style_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('clearEntry drops the saved row', () {
    const state = LoveStyleState(entryId: 'q1', isShared: true);

    final cleared = state.copyWith(clearEntry: true);

    expect(cleared.entryId, isNull);
    expect(cleared.isShared, isTrue);
  });

  test('clearPartnerName drops the partner name', () {
    const state = LoveStyleState(partnerName: 'Bia');

    expect(state.copyWith(clearPartnerName: true).partnerName, isNull);
  });

  test('clearPartnerRanked drops the comparison', () {
    const state = LoveStyleState(partnerRanked: ['time'], isShared: true);

    expect(state.canCompare, isTrue);
    expect(state.copyWith(clearPartnerRanked: true).partnerRanked, isNull);
    expect(state.copyWith(clearPartnerRanked: true).canCompare, isFalse);
  });

  test('changing the question keeps the saved row and partner name', () {
    const state = LoveStyleState(entryId: 'q1', isShared: true, partnerName: 'Bia');

    final updated = state.copyWith(questionIndex: 2);

    expect(updated.entryId, 'q1');
    expect(updated.isShared, isTrue);
    expect(updated.partnerName, 'Bia');
  });

  test('currentAnswer reads the answer at the current index', () {
    const state = LoveStyleState(answers: ['first', '']);

    expect(state.currentAnswer, 'first');
    expect(state.copyWith(questionIndex: 1).currentAnswer, isNull);
    expect(state.copyWith(questionIndex: 8).currentAnswer, isNull);
  });

  test('isComplete needs a non-empty answer for every question', () {
    const complete = LoveStyleState(answers: ['a', 'b', 'c', 'd', 'e', 'f']);

    expect(complete.isComplete, isTrue);
    expect(complete.copyWith(answers: ['a', 'b', 'c', 'd', 'e', '']).isComplete, isFalse);
  });
}
