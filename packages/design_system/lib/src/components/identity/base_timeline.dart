import 'package:design_system/design_system.dart';

const double _railX = 8;
const double _railWidth = 2;
const double _contentInset = 28;
const double _dotSize = 10;
const double _itemGap = 12;
const double _thumbSize = 44;

/// A vertical dotted rail with one [BaseTimelineItem] per entry.
///
/// The order is the feature's choice; the timeline does not sort. The rail and dots are decorative.
class const BaseTimeline({required final List<Widget> children, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RailPainter(color: context.colors.accentSoft),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: _itemGap,
        children: children,
      ),
    );
  }
}

/// One card of a [BaseTimeline]: title, meta line and an optional thumbnail, with its dot on the rail.
///
/// Reads title, then meta.
class const BaseTimelineItem({
  required final String title,
  final String? meta,
  final Widget? thumbnail,
  final VoidCallback? onTap,
  final bool isAdd = false,
  super.key,
}) extends StatelessWidget {
  /// The dashed row that adds an entry: a dashed dot, a plus icon and [label].
  const new add({required String label, required VoidCallback? onTap, Key? key})
    : this(title: label, onTap: onTap, isAdd: true, key: key);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = BorderRadius.circular(AppRadius.xxl);

    final card = isAdd
        ? CustomPaint(
            foregroundPainter: DashedRoundedPainter(
              color: colors.accentHighlight,
              radius: AppRadius.xxl,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.s16, vertical: AppSpace.s14),
              child: Row(
                children: [
                  AppIcon(icon: AppIcons.plus, color: colors.accentLabel),
                  const SizedBox(width: AppSpace.s10),
                  Flexible(
                    child: Text(
                      title,
                      style: context.text.bodySm.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colors.accentLabel,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.s16, vertical: 13),
            decoration: BoxDecoration(
              color: colors.bgSurface,
              borderRadius: radius,
              border: AppBorders.hair(colors.borderDefault),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: context.text.body.copyWith(fontWeight: FontWeight.w600)),
                      if (meta != null)
                        Text(
                          meta!,
                          style: context.text.caption.copyWith(color: colors.textSecondary),
                        ),
                    ],
                  ),
                ),
                if (thumbnail != null) ...[
                  const SizedBox(width: AppSpace.s12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: SizedBox(width: _thumbSize, height: _thumbSize, child: thumbnail),
                  ),
                ],
              ],
            ),
          );

    final tappable = onTap == null
        ? card
        : AppPressable(onTap: onTap, borderRadius: radius, child: card);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: _contentInset),
          child: tappable,
        ),
        Positioned(
          left: _railX - _dotSize / 2,
          top: 0,
          bottom: 0,
          child: Center(
            child: ExcludeSemantics(
              child: Container(
                width: _dotSize,
                height: _dotSize,
                decoration: BoxDecoration(
                  color: isAdd ? null : colors.bgSurface,
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.accentHighlight, width: 2),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class const _RailPainter({required final Color color}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _railWidth
      ..strokeCap = StrokeCap.round;
    var y = 6.0;
    while (y < size.height - 6) {
      canvas.drawLine(Offset(_railX, y), Offset(_railX, y + 2), paint);
      y += 6;
    }
  }

  @override
  bool shouldRepaint(_RailPainter oldDelegate) => oldDelegate.color != color;
}
