import 'package:design_system/src/components/faces/face_drawing.dart';
import 'package:design_system/src/components/faces/face_motion_policy.dart';
import 'package:design_system/src/components/faces/face_motion_scope.dart';
import 'package:design_system/src/components/faces/face_svg.dart';
import 'package:design_system/src/theme/app_theme.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The seven face moods.
enum FaceKind() {
  good,
  affectionate,
  tired,
  tense,
  sad,
  thinking,
  smile,
}

/// How a face moves; leave it unset on [BaseFace] for the automatic choice.
enum FaceMotion() {
  /// The static drawing; no animation engine is involved.
  still,

  /// A quiet loop that starts at a random point.
  idle,

  /// Draws itself once, then loops like [idle].
  enter,
}

/// Face circle and drawing diameters per size token.
enum FaceSize() {
  small,
  medium,
  large,
  reaction,
  showcase,
}

extension FaceSizeGeometry on FaceSize {
  /// Diameter of the white circle.
  double get circle => switch (this) {
    .small => 42,
    .medium => 46,
    .large => 52,
    .reaction => 56,
    .showcase => 64,
  };

  /// Diameter of the line drawing inside the circle.
  double get drawing => switch (this) {
    .small => 28,
    .medium => 30,
    .large => 34,
    .reaction => 32,
    .showcase => 40,
  };
}

/// A hand-drawn face in a white circle; pass [semanticLabel] when it carries meaning.
///
/// [motion] is chosen automatically when `null`: a selected face idles and pops when it becomes
/// selected, a showcase face draws itself, any other face stays still. Changing [popToken] plays a
/// pop. Faces stay still under reduced motion or a disabled [FaceMotionScope].
class const BaseFace({
  required final FaceKind kind,
  final FaceSize size = .medium,
  final bool selected = false,
  final String? semanticLabel,
  final Color? tint,
  final FaceMotion? motion,
  final int popToken = 0,
  super.key,
}) extends StatefulWidget {
  @override
  State<BaseFace> createState() => _BaseFaceState();
}

class _BaseFaceState() extends State<BaseFace> {
  int _pops = 0;

  @override
  void didUpdateWidget(BaseFace oldWidget) {
    super.didUpdateWidget(oldWidget);
    final becameSelected = widget.motion == null && widget.selected && !oldWidget.selected;
    if (becameSelected || widget.popToken != oldWidget.popToken) {
      _pops++;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ink = widget.tint ?? colors.textPrimary;
    final isMarked = widget.selected;
    final size = widget.size;

    final resolved = resolveFaceMotion(
      motion: widget.motion,
      selected: widget.selected,
      size: size,
    );
    final isAnimated =
        resolved != .still &&
        !context.reduceMotion &&
        !isInListItem(context) &&
        (FaceMotionScope.maybeOf(context)?.enabled ?? true);

    final Widget drawing;
    if (isAnimated) {
      drawing = FaceDrawing(
        kind: widget.kind,
        dimension: size.drawing,
        tint: ink,
        motion: resolved,
        popToken: _pops,
      );
    } else {
      drawing = SvgPicture.string(
        faceSvgFor(widget.kind, ink),
        width: size.drawing,
        height: size.drawing,
      );
    }

    final circle = Container(
      width: size.circle,
      height: size.circle,
      clipBehavior: isAnimated ? Clip.antiAlias : Clip.none,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isMarked ? colors.accentSoft : colors.bgSurface,
        border: isMarked ? null : Border.all(color: AppPalette.faceBorder),
        boxShadow: isMarked ? null : AppShadows.face,
      ),
      alignment: Alignment.center,
      child: drawing,
    );

    final label = widget.semanticLabel;
    if (label == null) return ExcludeSemantics(child: circle);
    return Semantics(label: label, image: true, child: circle);
  }
}
