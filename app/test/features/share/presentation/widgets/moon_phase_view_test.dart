import 'package:app/features/share/data/models/moon_phase.dart';
import 'package:app/features/share/presentation/widgets/moon_phase_view.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_helpers/pump_app.dart';

const Color _lit = AppPalette.neutral25;
const Color _unlit = AppPalette.neutral800;
const Color _glow = AppPalette.neutral400;

MoonPhasePainter _painterOf(WidgetTester tester) {
  final paint = tester.widget<CustomPaint>(
    find.descendant(of: find.byType(MoonPhaseView), matching: find.byType(CustomPaint)),
  );

  return paint.painter! as MoonPhasePainter;
}

void main() {
  testWidgets('draws the requested phase at the requested size', (tester) async {
    await tester.pumpApp(
      const Center(
        child: MoonPhaseView(
          phase: MoonPhase.fullMoon,
          diameter: 100,
          lit: _lit,
          unlit: _unlit,
          glow: _glow,
        ),
      ),
    );

    expect(_painterOf(tester).phase, MoonPhase.fullMoon);
    expect(tester.getSize(find.byType(MoonPhaseView)), const Size.square(100));
  });

  testWidgets('repaints only when the phase or a colour changes', (tester) async {
    await tester.pumpApp(
      const Center(
        child: MoonPhaseView(
          phase: MoonPhase.waningCrescent,
          diameter: 100,
          lit: _lit,
          unlit: _unlit,
          glow: _glow,
        ),
      ),
    );

    final painter = _painterOf(tester);

    expect(
      painter.shouldRepaint(
        const MoonPhasePainter(
          phase: MoonPhase.waningCrescent,
          lit: _lit,
          unlit: _unlit,
          glow: _glow,
        ),
      ),
      isFalse,
    );
    expect(
      painter.shouldRepaint(
        const MoonPhasePainter(phase: MoonPhase.fullMoon, lit: _lit, unlit: _unlit, glow: _glow),
      ),
      isTrue,
    );
  });
}
