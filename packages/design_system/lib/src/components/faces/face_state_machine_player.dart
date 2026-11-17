import 'dart:math';

import 'package:design_system/src/components/faces/base_face.dart';
import 'package:dotlottie_flutter/dotlottie_flutter.dart';
import 'package:flutter/widgets.dart';

/// The `source` of `assets/faces.lottie`, which lives in this package.
///
/// The plugin loads `assets/<source>`, so the path climbs out of `assets/` to the package asset key.
const String faceAnimationSource = '../packages/design_system/assets/faces.lottie';

bool _hasReportedFailure = false;

void _reportFailure(Object error) {
  if (_hasReportedFailure) return;
  _hasReportedFailure = true;
  debugPrint('BaseFace animation unavailable, showing the static face: $error');
}

/// Plays the state machine named after [kind] in `faces.lottie`, tinted in [tint].
///
/// While the animation loads, or if it fails, [fallback] is shown.
class const FaceStateMachinePlayer({
  required final FaceKind kind,
  required final Color tint,
  required final FaceMotion motion,
  required final int popToken,
  required final bool isPaused,
  required final Widget fallback,
  super.key,
}) extends StatefulWidget {
  @override
  State<FaceStateMachinePlayer> createState() => _FaceStateMachinePlayerState();
}

class _FaceStateMachinePlayerState() extends State<FaceStateMachinePlayer> {
  static final Random _random = Random();

  DotLottieViewController? _controller;
  bool _isLoaded = false;
  bool _hasFailed = false;
  int _run = 0;

  @override
  void didUpdateWidget(FaceStateMachinePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tint != oldWidget.tint) _applyTint();
    if (widget.isPaused != oldWidget.isPaused) {
      _applyPause();
    } else if (widget.popToken != oldWidget.popToken) {
      _pop();
    }
  }

  Future<void> _guard(Future<Object?> Function() call) async {
    try {
      await call();
    } on Object catch (error) {
      _reportFailure(error);
    }
  }

  Future<void> _applyTint() async {
    final controller = _controller;
    if (controller == null || !_isLoaded) return;
    final tint = widget.tint;
    await _guard(() => controller.setColorSlot('ink', tint.r, tint.g, tint.b));
  }

  Future<void> _overrideState(DotLottieViewController controller, String state) =>
      _guard(() => controller.stateMachineOverrideState(state, immediate: true));

  Future<void> _start() async {
    final controller = _controller;
    if (controller == null || !_isLoaded) return;
    final run = ++_run;
    await _guard(() => controller.stateMachineSetBooleanInput('restStill', false));
    if (widget.isPaused) {
      await _overrideState(controller, 'still');
    } else if (widget.popToken > 0) {
      await _overrideState(controller, 'still');
      await _guard(() => controller.stateMachineFire('pop'));
    } else if (widget.motion == FaceMotion.enter) {
      await _overrideState(controller, 'in');
    } else {
      await _overrideState(controller, 'still');
      await Future<void>.delayed(Duration(milliseconds: _random.nextInt(2000)));
      if (!mounted || run != _run || widget.isPaused) return;
      await _overrideState(controller, 'idle');
    }
  }

  Future<void> _applyPause() async {
    final controller = _controller;
    if (controller == null || !_isLoaded) return;
    if (widget.isPaused) {
      _run++;
      await _overrideState(controller, 'still');
    } else {
      await _overrideState(controller, 'idle');
    }
  }

  Future<void> _pop() async {
    final controller = _controller;
    if (controller == null || !_isLoaded || widget.isPaused) return;
    await _guard(() => controller.stateMachineFire('pop'));
  }

  void _onFailure() {
    _reportFailure('${widget.kind.name} could not be loaded');
    if (mounted) setState(() => _hasFailed = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasFailed) return widget.fallback;

    final showsFallback = !_isLoaded && widget.motion != FaceMotion.enter;

    return Stack(
      fit: StackFit.expand,
      children: [
        DotLottieView(
          key: ValueKey(widget.kind),
          source: faceAnimationSource,
          sourceType: 'asset',
          stateMachineId: widget.kind.name,
          onViewCreated: (controller) => _controller = controller,
          onLoad: () {
            if (!mounted) return;
            setState(() => _isLoaded = true);
            _applyTint();
            _start();
          },
          onLoadError: _onFailure,
          stateMachineOnStateEntered: (_) => _applyTint(),
          stateMachineOnError: _reportFailure,
        ),
        if (showsFallback) widget.fallback,
      ],
    );
  }
}
