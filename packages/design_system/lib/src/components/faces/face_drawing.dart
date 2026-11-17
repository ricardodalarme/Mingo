import 'package:design_system/src/components/faces/base_face.dart';
import 'package:design_system/src/components/faces/face_motion_policy.dart';
import 'package:design_system/src/components/faces/face_motion_scope.dart';
import 'package:design_system/src/components/faces/face_state_machine_player.dart';
import 'package:design_system/src/components/faces/face_svg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The animated line drawing of a face; shows the static drawing while the animation loads or if it
/// fails.
///
/// [motion] must be [FaceMotion.idle] or [FaceMotion.enter]. A pop plays when [popToken] changes and
/// when the face starts with a non-zero [popToken].
class const FaceDrawing({
  required final FaceKind kind,
  required final double dimension,
  required final Color tint,
  required final FaceMotion motion,
  required final int popToken,
  super.key,
}) extends StatefulWidget {
  @override
  State<FaceDrawing> createState() => _FaceDrawingState();
}

class _FaceDrawingState() extends State<FaceDrawing> with WidgetsBindingObserver {
  bool _isForeground = true;
  bool _hasBudget = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _hasBudget = FaceMotionBudget.tryAcquire();
    _isForeground = _isResumed(WidgetsBinding.instance.lifecycleState);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_hasBudget) FaceMotionBudget.release();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isForeground = _isResumed(state);
    if (isForeground != _isForeground) setState(() => _isForeground = isForeground);
  }

  static bool _isResumed(AppLifecycleState? state) =>
      state == null || state == AppLifecycleState.resumed;

  @override
  Widget build(BuildContext context) {
    final fallback = SvgPicture.string(
      faceSvgFor(widget.kind, widget.tint),
      width: widget.dimension,
      height: widget.dimension,
    );
    final isPaused = !_isForeground || !TickerMode.valuesOf(context).enabled;

    final builder = FaceMotionScope.maybeOf(context)?.playerBuilder;
    final Widget player;
    if (builder != null) {
      player = builder(
        context,
        FacePlayerRequest(
          kind: widget.kind,
          tint: widget.tint,
          motion: widget.motion,
          popToken: widget.popToken,
          isPaused: isPaused,
        ),
      );
    } else if (!_hasBudget) {
      player = fallback;
    } else {
      player = FaceStateMachinePlayer(
        kind: widget.kind,
        tint: widget.tint,
        motion: widget.motion,
        popToken: widget.popToken,
        isPaused: isPaused,
        fallback: fallback,
      );
    }

    return ExcludeSemantics(
      child: RepaintBoundary(
        child: SizedBox(width: widget.dimension, height: widget.dimension, child: player),
      ),
    );
  }
}
