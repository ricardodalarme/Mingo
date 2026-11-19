import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/widgets.dart';

const double _radius = 6;
const double _tapeWidth = 42;
const double _tapeHeight = 15;
const double _tapeOverhang = 8;
const double _tapeTurns = -3 * 3.141592653589793 / 180;
const Color _tapeColor = Color(0x99FFFFFF);
const Color _tapeEdge = Color(0x14000000);
const Color _foldLight = Color(0xBFFFFFFF);
const Color _foldDark = Color(0x14000000);

/// Space the tape needs above the paper so it does not overlap the item above.
const double slipNoteTapeOverhang = _tapeOverhang;

/// Fold size of [size].
double slipNoteFold(SlipNoteSize size) => size == .large ? 26 : 18;

/// Paper edge inset of [size].
EdgeInsetsDirectional slipNotePadding(SlipNoteSize size) => switch (size) {
  .wall => const EdgeInsetsDirectional.fromSTEB(14, 20, 14, 14),
  .large => const EdgeInsetsDirectional.fromSTEB(22, 30, 22, 20),
};

double _minHeight(SlipNoteSize size) => size == .large ? 190 : 132;

/// The taped, folded paper every slip note is drawn on.
class const SlipNotePaper({
  required final Color background,
  required final SlipNoteSize size,
  required final Widget child,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fold = slipNoteFold(size);

    return Padding(
      padding: const EdgeInsets.only(top: _tapeOverhang),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(_radius),
              boxShadow: AppShadows.slipNote,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: _minHeight(size)),
              child: Padding(padding: slipNotePadding(size), child: child),
            ),
          ),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            width: fold,
            height: fold,
            child: const ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(_radius)),
              child: CustomPaint(painter: _FoldPainter()),
            ),
          ),
          const Positioned(
            top: -_tapeOverhang,
            left: 0,
            right: 0,
            child: Center(child: _Tape()),
          ),
        ],
      ),
    );
  }
}

class const _Tape() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _tapeTurns,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _tapeColor,
          borderRadius: BorderRadius.circular(AppRadius.xs),
          border: Border.all(color: _tapeEdge),
        ),
        child: const SizedBox(width: _tapeWidth, height: _tapeHeight),
      ),
    );
  }
}

class const _FoldPainter() extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final flap = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(0, size.height)
      ..close();
    final back = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas
      ..drawPath(back, Paint()..color = _foldDark)
      ..drawPath(flap, Paint()..color = _foldLight);
  }

  @override
  bool shouldRepaint(_FoldPainter oldDelegate) => false;
}
