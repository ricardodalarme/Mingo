import 'package:app/features/cycle/data/mappers/sensitive_day_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final today = DateTime(2026, 11, 15);

  test('the record becomes the marked days of the model', () {
    final model = (today: today, days: [today, DateTime(2026, 11, 2)]).toModel();

    expect(model.today, today);
    expect(model.isTodayMarked, isTrue);
    expect(model.markedDays, {today, DateTime(2026, 11, 2)});
  });

  test('a day without marks maps to an empty calendar', () {
    final model = (today: today, days: const <DateTime>[]).toModel();

    expect(model.days, isEmpty);
    expect(model.isTodayMarked, isFalse);
  });
}
