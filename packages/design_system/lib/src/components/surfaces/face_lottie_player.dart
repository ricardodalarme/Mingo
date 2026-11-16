import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

/// Plays one face animation, looping or once, tinted in a single color.
class const FaceLottiePlayer({
  required final LottieComposition composition,
  required final Color tint,
  required final bool isLooping,
  required final double startOffset,
  required final bool isPaused,
  required final VoidCallback onCompleted,
  super.key,
}) extends StatefulWidget {
  @override
  State<FaceLottiePlayer> createState() => _FaceLottiePlayerState();
}

class _FaceLottiePlayerState() extends State<FaceLottiePlayer> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.composition.duration)
      ..addStatusListener(_onStatus)
      ..value = widget.startOffset;
    _play();
  }

  @override
  void didUpdateWidget(FaceLottiePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPaused != oldWidget.isPaused) _play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _play() {
    if (widget.isPaused) {
      _controller.stop();
    } else if (widget.isLooping) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  void _onStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed && !widget.isLooping) widget.onCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie(
      composition: widget.composition,
      controller: _controller,
      frameRate: FrameRate.composition,
      fit: BoxFit.contain,
      delegates: LottieDelegates(
        values: [
          ValueDelegate.color(const ['**'], value: widget.tint),
          ValueDelegate.strokeColor(const ['**'], value: widget.tint),
        ],
      ),
    );
  }
}
