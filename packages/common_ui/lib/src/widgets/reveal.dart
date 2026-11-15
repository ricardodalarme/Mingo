import 'dart:math' as math;

import 'package:design_system/design_system.dart';

/// Runs one staggered entrance for the [Reveal]s below it.
///
/// The entrance plays once, the first time [play] turns true. Later loads keep
/// the rows at rest, so a refresh or a new page never replays it.
class const RevealScope({required final Widget child, final bool play = true, super.key})
    extends StatefulWidget {
  @override
  State<RevealScope> createState() => _RevealScopeState();
}

class _RevealScopeState() extends State<RevealScope> with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(vsync: this, value: 1);
  bool _hasPlayed = false;
  bool _isReady = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _progress.duration = _groupTimeline(context.motionDuration(AppMotion.fast));
    if (_isReady) return;
    _isReady = true;
    if (widget.play) _play();
  }

  @override
  void didUpdateWidget(covariant RevealScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.play && !oldWidget.play) _play();
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  void _play() {
    if (_hasPlayed) return;
    _hasPlayed = true;
    if (context.reduceMotion) {
      _progress.value = 1;
      return;
    }
    _progress.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return _RevealGroup(
      timeline: _RevealTimeline(
        progress: _progress,
        step: AppMotion.stagger,
        duration: context.motionDuration(AppMotion.fast),
      ),
      child: widget.child,
    );
  }
}

/// A row that fades and lifts into place with the nearest [RevealScope].
///
/// Without a scope it plays its own single entrance when it mounts.
class const Reveal({required final Widget child, final int index = 0, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timeline = _RevealGroup.maybeOf(context);

    return timeline == null
        ? _SoloReveal(child: child)
        : _RevealFrame(timeline: timeline, index: index, child: child);
  }
}

class const _SoloReveal({required final Widget child}) extends StatefulWidget {
  @override
  State<_SoloReveal> createState() => _SoloRevealState();
}

class _SoloRevealState() extends State<_SoloReveal> with SingleTickerProviderStateMixin {
  late final AnimationController _progress = AnimationController(vsync: this, value: 1);
  Duration _duration = Duration.zero;
  bool _hasStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStarted) return;
    _hasStarted = true;
    _duration = context.motionDuration(AppMotion.base);
    _progress.duration = _duration;
    if (context.reduceMotion) return;
    _progress.forward(from: 0);
  }

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _RevealFrame(
      timeline: _RevealTimeline(progress: _progress, step: Duration.zero, duration: _duration),
      index: 0,
      child: widget.child,
    );
  }
}

class const _RevealTimeline({
  /// Progress of the whole group, from 0 to 1.
  required final Animation<double> progress,

  /// Delay between one row and the next.
  required final Duration step,

  /// How long one row takes.
  required final Duration duration,
});

class const _RevealGroup({required final _RevealTimeline timeline, required super.child})
    extends InheritedWidget {
  static _RevealTimeline? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_RevealGroup>()?.timeline;

  @override
  bool updateShouldNotify(_RevealGroup oldWidget) =>
      timeline.progress != oldWidget.timeline.progress ||
      timeline.step != oldWidget.timeline.step ||
      timeline.duration != oldWidget.timeline.duration;
}

class const _RevealFrame({
  required final _RevealTimeline timeline,
  required final int index,
  required final Widget child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const lastStep = AppMotion.staggerRows - 1;
    final delay = timeline.step * math.min(math.max(index, 0), lastStep);
    final total = timeline.duration + timeline.step * lastStep;
    final begin = delay.inMicroseconds / total.inMicroseconds;
    final end = (delay + timeline.duration).inMicroseconds / total.inMicroseconds;
    final curve = Interval(begin, end, curve: AppMotion.fastCurve);

    return AnimatedBuilder(
      animation: timeline.progress,
      builder: (context, _) {
        final progress = curve.transform(timeline.progress.value);

        return Opacity(
          opacity: progress,
          child: Transform.translate(offset: Offset(0, AppSpace.s8 * (1 - progress)), child: child),
        );
      },
    );
  }
}

Duration _groupTimeline(Duration row) => row + AppMotion.stagger * (AppMotion.staggerRows - 1);
