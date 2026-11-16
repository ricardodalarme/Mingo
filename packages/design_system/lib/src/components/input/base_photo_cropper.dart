import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';
import 'package:flutter/rendering.dart';

const double _viewport = 300;
const double _maxScale = 4;
const double _nudgeStep = 24;
const double _zoomStep = 1.25;
const double _ringWidth = 3;

/// A circular crop viewport over an image, with a hint, zoom and nudge buttons and an action bar.
///
/// Pan and pinch zoom run from the scale that covers the circle up to 4×; the image cannot leave the
/// circle and a double tap toggles fit and 2×. The result is a square PNG: the circle is only drawn on
/// top. Zoom and nudge buttons exist because dragging is not available to everyone. [onDone] receives
/// the bytes; [onChooseAnother] returns to the source sheet. While [isSaving] the primary action shows
/// loading dots.
class const BasePhotoCropper({
  required final ImageProvider image,
  required final ValueChanged<Uint8List> onDone,
  required final VoidCallback onChooseAnother,
  final bool isSaving = false,
  super.key,
}) extends StatefulWidget {
  @override
  State<BasePhotoCropper> createState() => _BasePhotoCropperState();
}

class _BasePhotoCropperState() extends State<BasePhotoCropper> {
  final TransformationController _transform = TransformationController();
  final GlobalKey _boundary = GlobalKey();

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  double get _scale => _transform.value.getMaxScaleOnAxis();

  void _apply(double scale, double dx, double dy) {
    final clamped = scale.clamp(1.0, _maxScale);
    final minOffset = _viewport - _viewport * clamped;
    final x = dx.clamp(minOffset, 0.0);
    final y = dy.clamp(minOffset, 0.0);
    _transform.value = Matrix4.identity()
      ..translateByDouble(x, y, 0, 1)
      ..scaleByDouble(clamped, clamped, 1, 1);
  }

  void _zoom(double factor) {
    final next = (_scale * factor).clamp(1.0, _maxScale);
    const center = _viewport / 2;
    final dx = _transform.value.getTranslation().x;
    final dy = _transform.value.getTranslation().y;
    final ratio = next / _scale;
    _apply(next, center - (center - dx) * ratio, center - (center - dy) * ratio);
  }

  void _nudge(double dx, double dy) {
    final translation = _transform.value.getTranslation();
    _apply(_scale, translation.x + dx, translation.y + dy);
  }

  void _toggleZoom() {
    if (_scale > 1.01) {
      _apply(1, 0, 0);
    } else {
      _zoom(2);
    }
  }

  Future<void> _done() async {
    final boundary = _boundary.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;
    final image = await boundary.toImage(pixelRatio: 3);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    if (data == null || !mounted) return;
    widget.onDone(data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase.media;

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: _viewport,
                height: _viewport,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    GestureDetector(
                      onDoubleTap: _toggleZoom,
                      child: RepaintBoundary(
                        key: _boundary,
                        child: InteractiveViewer(
                          transformationController: _transform,
                          maxScale: _maxScale,
                          child: Image(
                            image: widget.image,
                            fit: BoxFit.cover,
                            width: _viewport,
                            height: _viewport,
                          ),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: CustomPaint(
                        painter: _CirclePainter(scrim: colors.scrim, ring: AppPalette.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpace.s20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.screenMargin),
                child: Text(
                  l10n.cropHint,
                  textAlign: TextAlign.center,
                  style: context.text.caption.copyWith(color: colors.textSecondary),
                ),
              ),
              const SizedBox(height: AppSpace.s16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpace.s8,
                runSpacing: AppSpace.s8,
                children: [
                  BaseRoundButton(
                    icon: AppIcons.square_minus,
                    semanticLabel: l10n.zoomOut,
                    onPressed: () => _zoom(1 / _zoomStep),
                  ),
                  BaseRoundButton(
                    icon: AppIcons.plus,
                    semanticLabel: l10n.zoomIn,
                    onPressed: () => _zoom(_zoomStep),
                  ),
                  BaseRoundButton(
                    icon: AppIcons.chevron_left,
                    semanticLabel: l10n.moveLeft,
                    onPressed: () => _nudge(_nudgeStep, 0),
                  ),
                  BaseRoundButton(
                    icon: AppIcons.chevron_right,
                    semanticLabel: l10n.moveRight,
                    onPressed: () => _nudge(-_nudgeStep, 0),
                  ),
                  BaseRoundButton(
                    icon: AppIcons.chevron_up,
                    semanticLabel: l10n.moveUp,
                    onPressed: () => _nudge(0, _nudgeStep),
                  ),
                  BaseRoundButton(
                    icon: AppIcons.chevron_down,
                    semanticLabel: l10n.moveDown,
                    onPressed: () => _nudge(0, -_nudgeStep),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpace.screenMargin,
            0,
            AppSpace.screenMargin,
            AppSpace.footerBottom,
          ),
          child: Column(
            spacing: AppSpace.s10,
            children: [
              BaseButton.primary(text: l10n.usePhoto, isLoading: widget.isSaving, onPressed: _done),
              BaseButton.text(text: l10n.chooseAnother, onPressed: widget.onChooseAnother),
            ],
          ),
        ),
      ],
    );
  }
}

class const _CirclePainter({required final Color scrim, required final Color ring})
    extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2;
    final layer = Path()
      ..addRect(Offset.zero & size)
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..fillType = PathFillType.evenOdd;
    canvas
      ..drawPath(layer, Paint()..color = scrim.withValues(alpha: .6))
      ..drawCircle(
        center,
        radius - _ringWidth / 2,
        Paint()
          ..color = ring
          ..style = PaintingStyle.stroke
          ..strokeWidth = _ringWidth,
      );
  }

  @override
  bool shouldRepaint(_CirclePainter oldDelegate) =>
      oldDelegate.scrim != scrim || oldDelegate.ring != ring;
}
