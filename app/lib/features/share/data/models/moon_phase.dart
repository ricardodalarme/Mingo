/// One of the eight named lunar phases, with the disc it draws.
enum MoonPhase(final double litFraction, final bool isWaxing) {
  newMoon(0, true),
  waxingCrescent(.25, true),
  firstQuarter(.5, true),
  waxingGibbous(.75, true),
  fullMoon(1, true),
  waningGibbous(.75, false),
  lastQuarter(.5, false),
  waningCrescent(.25, false);

  /// The synodic month the app counts full moons with.
  static const double synodicDays = 29.530588;

  static final DateTime _referenceNewMoon = DateTime.utc(2000, 1, 6, 18, 14);

  /// The phase [date] falls in, from a new moon on 2000-01-06.
  static MoonPhase forDate(DateTime date) {
    final days = date.toUtc().difference(_referenceNewMoon).inSeconds / Duration.secondsPerDay;
    final cycle = (days / synodicDays) % 1;
    final index = (cycle * values.length + .5).floor() % values.length;

    return values[index];
  }
}
