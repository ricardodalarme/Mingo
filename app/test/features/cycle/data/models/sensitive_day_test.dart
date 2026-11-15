import 'package:app/features/cycle/data/models/sensitive_day.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final today = DateTime(2026, 11, 15);
  SensitiveDays build(List<DateTime> days) => SensitiveDays(
    today: today,
    days: [for (final day in days) SensitiveDay(day: day)],
  );

  test('a day with the same date at another time still matches', () {
    final days = build([DateTime(2026, 11, 15, 9, 30)]);

    expect(days.isMarked(today), isTrue);
    expect(days.isTodayMarked, isTrue);
  });

  test('an unmarked day is not today', () {
    final days = build([DateTime(2026, 11, 2)]);

    expect(days.isMarked(today), isFalse);
    expect(days.isTodayMarked, isFalse);
    expect(days.markedDays, {DateTime(2026, 11, 2)});
  });

  test('toggling an unmarked day adds it', () {
    final days = build([DateTime(2026, 11, 2)]).withToggled(today);

    expect(days.isTodayMarked, isTrue);
    expect(days.days, hasLength(2));
  });

  test('toggling a marked day drops it and keeps the others', () {
    final days = build([DateTime(2026, 11, 2), today]).withToggled(today);

    expect(days.isTodayMarked, isFalse);
    expect(days.days.map((day) => day.day), [DateTime(2026, 11, 2)]);
  });
}
