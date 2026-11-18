import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Days until the next important date, as a ring when small and a headline when medium.
class const NextDatePreview({
  required final HomeWidgetPayload payload,
  required final HomeWidgetSize size,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);
    final days = payload.daysUntilNextDateOn(now);
    final title = payload.nextDateTitle;
    final isMedium = size == HomeWidgetSize.medium;

    if (days == null) {
      return HomeWidgetFrame(
        size: size,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppPalette.white,
          border: Border.all(color: palette.border),
        ),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeWidgetEyebrow(text: l10n.nextDateEyebrow, color: palette.label),
              HomeWidgetText(
                text: l10n.nextDateEmpty,
                size: 17,
                weight: FontWeight.w600,
                color: HomeWidgetPalette.charcoal,
              ),
            ],
          ),
        ),
      );
    }

    if (isMedium) {
      return HomeWidgetFrame(
        size: size,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-1, -0.4),
            end: Alignment(1, 0.4),
            colors: [HomeWidgetPalette.sky, AppHue.roseSoft],
          ),
        ),
        child: DefaultTextStyle.merge(
          style: const TextStyle(color: HomeWidgetPalette.skyInk),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeWidgetEyebrow(
                      text: l10n.nextDateEyebrow,
                      color: HomeWidgetPalette.skyInk.withValues(alpha: .75),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        HomeWidgetText(
                          text: '$days',
                          size: 52,
                          weight: FontWeight.w600,
                          letterSpacing: -2.6,
                          height: 1,
                          maxLines: 1,
                        ),
                        const SizedBox(width: 6),
                        HomeWidgetText(text: l10n.counterUnit(count: days), size: 20, maxLines: 1),
                      ],
                    ),
                    if (title != null) ...[
                      const SizedBox(height: 4),
                      Opacity(
                        opacity: 0.8,
                        child: HomeWidgetText(text: title, size: 13, maxLines: 1),
                      ),
                    ],
                  ],
                ),
              ),
              const AppIcon(icon: AppIcons.calendar_filled, size: 56, color: AppHue.roseHighlight),
            ],
          ),
        ),
      );
    }

    return HomeWidgetFrame(
      size: size,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppPalette.white,
        border: Border.all(color: palette.border),
      ),
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            top: 0,
            child: _Confetti(8, HomeWidgetPalette.confettiYellow, true),
          ),
          const Positioned(
            right: 6,
            top: 12,
            child: _Confetti(6, HomeWidgetPalette.confettiBlue, false),
          ),
          Positioned(left: 10, bottom: 8, child: _Confetti(6, palette.highlight, false)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 104,
                height: 104,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size.square(104),
                      painter: _RingPainter(
                        progress: (1 - days / 30).clamp(0.06, 1),
                        track: palette.soft,
                        color: palette.highlight,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HomeWidgetText(
                          text: '$days',
                          size: 34,
                          weight: FontWeight.w600,
                          color: HomeWidgetPalette.charcoal,
                          letterSpacing: -1.4,
                          height: 1,
                          maxLines: 1,
                        ),
                        HomeWidgetText(
                          text: l10n.counterUnit(count: days),
                          size: 12,
                          color: context.colors.textSecondary,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              if (title != null)
                HomeWidgetText(
                  text: title,
                  size: 12.5,
                  weight: FontWeight.w500,
                  color: HomeWidgetPalette.charcoal,
                  maxLines: 1,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class const _Confetti(final double size, final Color color, final bool isRound)
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: isRound ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isRound ? null : const BorderRadius.all(Radius.circular(2)),
      ),
    );
  }
}

class _RingPainter({
  required final double progress,
  required final Color track,
  required final Color color,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 9.0;
    final rect = Offset.zero & size;
    final arc = rect.deflate(stroke / 2 + 8);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    canvas
      ..drawArc(arc, 0, 6.2832, false, paint..color = track)
      ..drawArc(arc, -1.5708, 6.2832 * progress, false, paint..color = color);
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.track != track || oldDelegate.color != color;
}
