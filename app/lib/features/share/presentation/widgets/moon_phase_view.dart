import 'dart:math' as math;

import 'package:app/features/share/data/models/moon_phase.dart';
import 'package:design_system/design_system.dart';

/// The moon as it was on a date, drawn once and reused by the preview and the PNG.
class const MoonPhaseView({
  required final MoonPhase phase,
  required final double diameter,
  required final Color lit,
  required final Color unlit,
  required final Color glow,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: diameter,
      child: CustomPaint(
        painter: MoonPhasePainter(phase: phase, lit: lit, unlit: unlit, glow: glow),
        isComplex: true,
      ),
    );
  }
}

/// Paints the halo, the shadowed disc and the lit part of [phase].
class const MoonPhasePainter({
  required final MoonPhase phase,
  required final Color lit,
  required final Color unlit,
  required final Color glow,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final haloRadius = radius * 1.3;

    canvas
      ..drawCircle(
        center,
        haloRadius,
        Paint()
          ..shader = RadialGradient(
            colors: [glow, glow.withValues(alpha: 0)],
            stops: const [0, 1],
          ).createShader(Rect.fromCircle(center: center, radius: haloRadius)),
      )
      ..drawCircle(center, radius, Paint()..color = unlit);

    final litPath = _litPath(center, radius);
    if (litPath != null) {
      canvas.drawPath(
        litPath,
        Paint()
          ..shader = RadialGradient(
            center: const Alignment(-.3, -.3),
            colors: [lit, lit.withValues(alpha: .84)],
            stops: const [.25, 1],
          ).createShader(Rect.fromCircle(center: center, radius: radius)),
      );
    }

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = AppBorder.hair
        ..color = lit.withValues(alpha: .22),
    );
  }

  Path? _litPath(Offset center, double radius) {
    final circle = Rect.fromCircle(center: center, radius: radius);
    final fraction = phase.litFraction;
    if (fraction <= 0) return null;
    if (fraction >= 1) return Path()..addOval(circle);

    final half = Path()..addArc(circle, phase.isWaxing ? -math.pi / 2 : math.pi / 2, math.pi);
    if (fraction == .5) return half;

    final terminatorWidth = 2 * radius * (1 - 2 * fraction).abs();
    final terminator = Path()
      ..addOval(Rect.fromCenter(center: center, width: terminatorWidth, height: 2 * radius));

    return Path.combine(
      fraction < .5 ? PathOperation.difference : PathOperation.union,
      half,
      terminator,
    );
  }

  @override
  bool shouldRepaint(MoonPhasePainter oldDelegate) =>
      oldDelegate.phase != phase ||
      oldDelegate.lit != lit ||
      oldDelegate.unlit != unlit ||
      oldDelegate.glow != glow;
}
