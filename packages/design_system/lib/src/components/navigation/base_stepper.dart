import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

const double _barWidth = 18;
const double _barHeight = 4;
const double _barGap = 5;
const double _segmentHeight = 3;
const double _segmentGap = 4;

/// Progress for a guided flow.
///
/// The default form shows 18 × 4 bars and reads "Step 3 of 5". [BaseStepper.continuous] draws full-width
/// segments for content that advances by itself and reads "Part 2 of 3".
class const BaseStepper({
  required final int count,
  required final int currentIndex,
  final String? semanticLabel,
  final double progress = 1,
  final bool isContinuous = false,
  super.key,
}) extends StatelessWidget {
  /// Full-width story segments across the top of a full-screen sequence.
  ///
  /// Segments before [currentIndex] are played, the one at [currentIndex] is filled to [progress]
  /// (0 to 1) and the rest are upcoming.
  const new continuous({
    required int count,
    required int currentIndex,
    double progress = 0,
    String? semanticLabel,
    Key? key,
  }) : this(
         count: count,
         currentIndex: currentIndex,
         progress: progress,
         semanticLabel: semanticLabel,
         isContinuous: true,
         key: key,
       );

  @override
  Widget build(BuildContext context) {
    final l10n = context.designSystemL10nOrBase.navigation;
    final label =
        semanticLabel ??
        (isContinuous
            ? l10n.partOf(current: currentIndex + 1, total: count)
            : l10n.stepOf(current: currentIndex + 1, total: count));

    return Semantics(
      label: label,
      child: ExcludeSemantics(child: isContinuous ? _continuous(context) : _bars(context)),
    );
  }

  Widget _bars(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int index = 0; index < count; index++) ...[
          if (index > 0) const SizedBox(width: _barGap),
          SizedBox(
            width: _barWidth,
            height: _barHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: index <= currentIndex ? colors.actionPrimary : AppPalette.neutral150,
                borderRadius: BorderRadius.circular(_barHeight / 2),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _continuous(BuildContext context) {
    final colors = context.colors;
    final fill = progress.clamp(0.0, 1.0);

    return Row(
      children: [
        for (int index = 0; index < count; index++) ...[
          if (index > 0) const SizedBox(width: _segmentGap),
          Expanded(
            child: SizedBox(
              height: _segmentHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppPalette.neutral150,
                  borderRadius: BorderRadius.circular(AppRadius.xs - 1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.xs - 1),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: FractionallySizedBox(
                      widthFactor: index < currentIndex ? 1 : (index == currentIndex ? fill : 0),
                      heightFactor: 1,
                      child: ColoredBox(color: colors.actionPrimary),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
