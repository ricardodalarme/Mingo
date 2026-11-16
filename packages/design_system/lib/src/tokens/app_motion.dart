import 'package:flutter/widgets.dart';

/// Motion tokens; durations collapse to a 150 ms fade under reduced motion.
abstract final class AppMotion() {
  static const Duration fast = Duration(milliseconds: 120);
  static const Duration base = Duration(milliseconds: 220);
  static const Duration slow = Duration(milliseconds: 360);
  static const Duration reduced = Duration(milliseconds: 150);
  static const Duration stagger = Duration(milliseconds: 80);

  static const Curve baseCurve = Cubic(.2, 0, 0, 1);
  static const Curve fastCurve = Cubic(.16, 1, .3, 1);

  /// A sheet rising from the bottom edge: unhurried at the start, settled late.
  static const Curve sheetCurve = Cubic(.32, .72, 0, 1);

  /// Spring for landing and arrival motion.
  static const double springStiffness = 300;
  static const double springDamping = 24;

  /// The press scale used by every tappable surface.
  static const double pressedScale = .97;

  /// The press scale of the primary capture action.
  static const double pressedActionScale = .9;

  /// Rows past this count arrive together with the last staggered row.
  static const int staggerRows = 3;
}

extension AppMotionContext on BuildContext {
  /// Whether the platform asks for reduced motion.
  bool get reduceMotion => MediaQuery.maybeDisableAnimationsOf(this) ?? false;

  /// [duration], or the standard fade when reduced motion is on.
  Duration motionDuration(Duration duration) => reduceMotion ? AppMotion.reduced : duration;

  /// Scale for a pressed surface, or 1 when animation should be skipped.
  double pressScale([double? scale]) => reduceMotion ? 1 : (scale ?? AppMotion.pressedScale);
}
