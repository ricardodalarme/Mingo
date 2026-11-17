import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('knownRanked drops keys this version does not know', () {
    const entry = LoveStyleEntry(id: 'q1', ranked: ['time', 'unknown', 'touch']);

    expect(entry.knownRanked, ['time', 'touch']);
    expect(entry.topPattern, 'time');
    expect(entry.isShared, isFalse);
  });

  test('a share time marks the entry as shared', () {
    final entry = LoveStyleEntry(id: 'q1', ranked: const ['time'], sharedAt: DateTime.utc(2026));

    expect(entry.isShared, isTrue);
  });

  test('the overview can compare only when both entries exist', () {
    const own = LoveStyleEntry(id: 'q1', ranked: ['time']);
    const partner = LoveStyleEntry(id: 'q2', ranked: ['touch']);

    expect(const LoveStyleOverview(own: own).canCompare, isFalse);
    expect(const LoveStyleOverview(own: own, partner: partner).canCompare, isTrue);
  });

  test('the common pattern is the one that ranks highest for both', () {
    const comparison = LoveStyleComparison(
      own: ['time', 'words', 'acts', 'gifts', 'touch'],
      partner: ['touch', 'time', 'words', 'acts', 'gifts'],
    );

    expect(comparison.commonPattern, 'time');
  });

  test('the comparison still finds a common pattern when the tops differ', () {
    const comparison = LoveStyleComparison(
      own: ['gifts', 'acts', 'words', 'time', 'touch'],
      partner: ['touch', 'words', 'acts', 'time', 'gifts'],
    );

    expect(comparison.commonPattern, 'words');
  });
}
