import 'dart:math';

import 'package:design_system/src/components/surfaces/base_face.dart';
import 'package:design_system/src/components/surfaces/face_animations.dart';
import 'package:design_system/src/components/surfaces/face_lottie_player.dart';
import 'package:design_system/src/components/surfaces/face_motion_scope.dart';
import 'package:design_system/src/components/surfaces/face_svg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// The line drawing of a face, static or animated; falls back to the static drawing when the
/// animation is unavailable.
///
/// [motion] must be [FaceMotion.idle] or [FaceMotion.enter]. A pop plays when [popToken] changes or
/// when [popsOnMount] is set.
class const FaceDrawing({
  required final FaceKind kind,
  required final double dimension,
  required final Color tint,
  required final FaceMotion motion,
  required final int popToken,
  final bool popsOnMount = false,
  super.key,
}) extends StatefulWidget {
  @override
  State<FaceDrawing> createState() => _FaceDrawingState();
}

class _FaceDrawingState() extends State<FaceDrawing> with WidgetsBindingObserver {
  static final Random _random = Random();

  late FaceClip _clip;
  late double _startOffset;
  int _generation = 0;
  bool _isForeground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _isForeground = _isResumed(WidgetsBinding.instance.lifecycleState);
    _clip = widget.popsOnMount ? .pop : _restingClip(widget.motion);
    _startOffset = _clip == .idle ? _random.nextDouble() : 0;
  }

  @override
  void didUpdateWidget(FaceDrawing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.kind != oldWidget.kind) {
      _restart(_restingClip(widget.motion), 0);
    } else if (widget.popToken != oldWidget.popToken) {
      _restart(.pop, 0);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isForeground = _isResumed(state);
    if (isForeground == _isForeground) return;
    setState(() {
      _isForeground = isForeground;
      if (isForeground) _restart(.idle, _random.nextDouble());
    });
  }

  static bool _isResumed(AppLifecycleState? state) =>
      state == null || state == AppLifecycleState.resumed;

  static FaceClip _restingClip(FaceMotion motion) => motion == .enter ? .enter : .idle;

  void _restart(FaceClip clip, double startOffset) {
    _clip = clip;
    _startOffset = startOffset;
    _generation++;
  }

  void _onCompleted() {
    if (!mounted) return;
    setState(() => _restart(.idle, 0));
  }

  @override
  Widget build(BuildContext context) {
    final isPaused = !_isForeground || !TickerMode.valuesOf(context).enabled;
    final request = FacePlayerRequest(
      kind: widget.kind,
      clip: _clip,
      tint: widget.tint,
      startOffset: _startOffset,
      isPaused: isPaused,
      onCompleted: _onCompleted,
    );

    final builder = FaceMotionScope.maybeOf(context)?.playerBuilder;
    final Widget player;
    if (builder != null) {
      player = builder(context, request);
    } else {
      final composition = FaceAnimations.compositionFor(widget.kind, _clip);
      if (composition == null) {
        FaceAnimations.reportFailure('${widget.kind.name} ${_clip.name} is not loaded');
        player = _staticFace;
      } else {
        player = FaceLottiePlayer(
          key: ValueKey((widget.kind, _clip, _generation)),
          composition: composition,
          tint: widget.tint,
          isLooping: _clip == .idle,
          startOffset: _startOffset,
          isPaused: isPaused,
          onCompleted: _onCompleted,
        );
      }
    }

    return ExcludeSemantics(
      child: RepaintBoundary(
        child: SizedBox(width: widget.dimension, height: widget.dimension, child: player),
      ),
    );
  }

  Widget get _staticFace => SvgPicture.string(
    faceSvgFor(widget.kind, widget.tint),
    width: widget.dimension,
    height: widget.dimension,
  );
}
