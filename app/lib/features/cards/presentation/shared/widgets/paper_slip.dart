import 'package:design_system/design_system.dart';

/// A small paper slip with a folded top-right corner.
class const PaperSlip({
  required final Color fill,
  required final Color ink,
  final double width = 30,
  final double height = 36,
  final Color foldColor = AppPalette.neutral0,
  final double rotation = 0,
  final Widget? child,
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  static const BorderRadius _radius = BorderRadius.only(
    topLeft: Radius.circular(AppRadius.sm),
    topRight: Radius.circular(12),
    bottomLeft: Radius.circular(AppRadius.sm),
    bottomRight: Radius.circular(AppRadius.sm),
  );

  @override
  Widget build(BuildContext context) {
    final slip = Transform.rotate(
      angle: rotation * 3.1415926535897932 / 180,
      child: SizedBox(
        width: width,
        height: height,
        child: ClipRRect(
          borderRadius: _radius,
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: fill,
                    borderRadius: _radius,
                    boxShadow: const [
                      BoxShadow(color: AppPalette.shadowFace, offset: Offset(0, 1)),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: CustomPaint(painter: _FoldPainter(color: foldColor)),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Center(
                    child: DefaultTextStyle.merge(
                      style: TextStyle(color: ink, fontWeight: FontWeight.w600),
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    final label = semanticLabel;
    if (label == null) return ExcludeSemantics(child: slip);
    return Semantics(label: label, child: slip);
  }
}

class const _FoldPainter({required final Color color}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const fold = 9.0;
    final path = Path()
      ..moveTo(size.width - fold, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, fold)
      ..close();

    canvas
      ..drawPath(path, Paint()..color = color)
      ..drawLine(
        Offset(size.width - fold, 0),
        Offset(size.width, fold),
        Paint()
          ..color = AppPalette.foldShadow
          ..strokeWidth = 1,
      );
  }

  @override
  bool shouldRepaint(_FoldPainter oldDelegate) => oldDelegate.color != color;
}

/// The strip of tape across the top of a paper note.
class const PaperTape({
  required final Color color,
  final double width = 44,
  final double height = 16,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -3 * 3.1415926535897932 / 180,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color.withValues(alpha: .85),
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
      ),
    );
  }
}
