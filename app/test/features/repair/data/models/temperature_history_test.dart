import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:app/features/repair/data/models/temperature_history.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final now = DateTime(2026, 11, 18, 10);

  test('the history covers eight weeks, oldest first, ending with this one', () {
    final weeks = temperatureWeeks(const [], now: now);

    expect(weeks, hasLength(temperatureHistoryWeeks));
    expect(weeks.last.start, DateTime(2026, 11, 16));
    expect(weeks.first.start, DateTime(2026, 9, 28));
    expect(weeks.every((week) => week.level == null), isTrue);
  });

  test('a week shows the last answer given in it', () {
    final weeks = temperatureWeeks([
      TemperatureCheck(level: Temperature.fight, at: DateTime(2026, 11, 16, 9)),
      TemperatureCheck(level: Temperature.good, at: DateTime(2026, 11, 17, 9)),
      TemperatureCheck(level: Temperature.turbulent, at: DateTime(2026, 11, 10, 9)),
    ], now: now);

    expect(weeks.last.level, Temperature.good);
    expect(weeks[weeks.length - 2].level, Temperature.turbulent);
  });

  test('an answer older than eight weeks is left out', () {
    final weeks = temperatureWeeks([
      TemperatureCheck(level: Temperature.fight, at: DateTime(2026, 9, 1)),
    ], now: now);

    expect(weeks.every((week) => week.level == null), isTrue);
  });
}
