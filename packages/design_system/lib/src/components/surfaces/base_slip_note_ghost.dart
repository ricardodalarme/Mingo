import 'package:design_system/src/drawings/dashed_rounded_painter.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/widgets.dart';

const double _width = 64;
const double _height = 76;
const double _overlap = 14;
const double _drop = 8;
const double _radius = 6;

/// Three empty, overlapping note outlines that decorate an empty wall.
///
/// Hidden from screen readers.
class const BaseSlipNoteGhost({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const step = _width - _overlap;

    return const ExcludeSemantics(
      child: SizedBox(
        width: _width + step * 2,
        height: _height + _drop,
        child: Stack(
          children: [
            Positioned(left: 0, top: 0, child: _Ghost()),
            Positioned(left: step, top: _drop, child: _Ghost()),
            Positioned(left: step * 2, top: 0, child: _Ghost()),
          ],
        ),
      ),
    );
  }
}

class const _Ghost() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: _width,
      height: _height,
      child: CustomPaint(
        painter: DashedRoundedPainter(color: AppSlipNoteColors.ghostBorder, radius: _radius),
      ),
    );
  }
}
