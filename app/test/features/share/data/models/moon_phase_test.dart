import 'package:app/features/share/data/models/moon_phase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MoonPhase.forDate', () {
    final reference = DateTime.utc(2000, 1, 6, 18, 14);

    MoonPhase afterFraction(double fraction) => MoonPhase.forDate(
      reference.add(
        Duration(seconds: (MoonPhase.synodicDays * fraction * Duration.secondsPerDay).round()),
      ),
    );

    test('the reference new moon starts the cycle', () {
      expect(MoonPhase.forDate(reference), MoonPhase.newMoon);
    });

    test('the cycle walks through the eight named phases', () {
      expect(afterFraction(.12), MoonPhase.waxingCrescent);
      expect(afterFraction(.25), MoonPhase.firstQuarter);
      expect(afterFraction(.37), MoonPhase.waxingGibbous);
      expect(afterFraction(.5), MoonPhase.fullMoon);
      expect(afterFraction(.62), MoonPhase.waningGibbous);
      expect(afterFraction(.75), MoonPhase.lastQuarter);
      expect(afterFraction(.87), MoonPhase.waningCrescent);
      expect(afterFraction(.99), MoonPhase.newMoon);
    });

    test('a real full moon lands on the full moon phase', () {
      expect(MoonPhase.forDate(DateTime.utc(2024, 4, 23, 23, 49)), MoonPhase.fullMoon);
    });

    test('the same instant in another time zone keeps the phase', () {
      final instant = DateTime.utc(2024, 4, 23, 23, 49);

      expect(MoonPhase.forDate(instant.toLocal()), MoonPhase.forDate(instant));
    });
  });
}
