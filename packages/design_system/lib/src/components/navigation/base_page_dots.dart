import 'package:design_system/design_system.dart';

const double _dotSize = 6;
const double _activeDotWidth = 18;
const double _dotGap = 6;

/// A row of page indicators with the active page stretched.
///
/// Indicators only: they are hidden from screen readers and are not buttons.
class const BasePageDots({required final int count, required final int index, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int dot = 0; dot < count; dot++) ...[
            if (dot > 0) const SizedBox(width: _dotGap),
            AnimatedContainer(
              duration: context.motionDuration(AppMotion.base),
              curve: AppMotion.baseCurve,
              width: dot == index ? _activeDotWidth : _dotSize,
              height: _dotSize,
              decoration: BoxDecoration(
                color: dot == index ? colors.actionPrimary : AppPalette.neutral200,
                borderRadius: BorderRadius.circular(_dotSize / 2),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
