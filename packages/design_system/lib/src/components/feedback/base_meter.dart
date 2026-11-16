import 'package:design_system/design_system.dart';

const double _trackHeight = 6;
const double _thinTrackHeight = 4;
const double _labelGap = 8;

/// A track with a filled part and a short label.
///
/// It shows a limit that is being used up, never a score: the fill keeps its color near the limit and
/// the [label] changes to say what happens next ("Back tomorrow"). Not for measurable work in progress,
/// goals or streaks. The semantics value is the label. [isThin] is the 4 point track for list rows and
/// [labelOnRight] puts the label beside the track.
class const BaseMeter({
  required final int value,
  required final int max,
  final String? label,
  final bool isThin = false,
  final bool labelOnRight = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fraction = max <= 0 ? 0.0 : (value / max).clamp(0.0, 1.0);
    final height = isThin ? _thinTrackHeight : _trackHeight;

    final track = SizedBox(
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppPalette.neutral100,
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: fraction),
              duration: context.motionDuration(AppMotion.base),
              curve: AppMotion.baseCurve,
              builder: (context, factor, _) => FractionallySizedBox(
                widthFactor: factor,
                heightFactor: 1,
                child: ColoredBox(color: colors.actionPrimary),
              ),
            ),
          ),
        ),
      ),
    );

    final text = label == null
        ? null
        : Text(
            label!,
            style: context.text.caption.copyWith(fontSize: 12.5, color: colors.textSecondary),
          );

    return Semantics(
      container: true,
      value: label ?? '$value / $max',
      child: ExcludeSemantics(
        child: labelOnRight && text != null
            ? Row(
                spacing: AppSpace.s12,
                children: [
                  Expanded(child: track),
                  text,
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  track,
                  if (text != null) ...[const SizedBox(height: _labelGap), text],
                ],
              ),
      ),
    );
  }
}
