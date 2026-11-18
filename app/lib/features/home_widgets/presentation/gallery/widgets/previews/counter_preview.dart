import 'dart:ui' show PointMode;

import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_heart.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:formatters/formatters.dart';

/// Days together, with the two initials and, when medium, the story timeline.
class const CounterPreview({
  required final HomeWidgetPayload payload,
  required final HomeWidgetSize size,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final palette = HomeWidgetPalette.of(payload.theme);
    final isMedium = size == HomeWidgetSize.medium;
    final warm = Color.lerp(palette.tintStart, palette.tintEnd, 0.55)!;

    return HomeWidgetFrame(
      size: size,
      padding: EdgeInsets.symmetric(horizontal: isMedium ? 18 : 16, vertical: isMedium ? 16 : 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: isMedium ? Alignment.centerLeft : Alignment.topLeft,
          end: isMedium ? Alignment.centerRight : Alignment.bottomRight,
          colors: isMedium
              ? [palette.tintStart, warm, HomeWidgetPalette.peach]
              : [palette.tintStart, palette.tintEnd],
        ),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: palette.ink),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (!isMedium)
              Positioned(
                right: -38,
                bottom: -41,
                child: Opacity(
                  opacity: 0.28,
                  child: Transform.rotate(
                    angle: 0.24,
                    child: const HomeWidgetHeart(size: 120, color: AppPalette.white),
                  ),
                ),
              ),
            _body(context, palette, isMedium),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context, HomeWidgetPalette palette, bool isMedium) {
    final l10n = context.l10n.homeWidgets;
    final days = payload.daysTogetherOn(now);
    final duration = payload.durationOn(now);
    final eyebrow = HomeWidgetEyebrow(
      text: l10n.counterEyebrow,
      color: palette.ink.withValues(alpha: .75),
    );

    if (days == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          eyebrow,
          HomeWidgetText(
            text: l10n.counterNeedDate,
            size: 17,
            weight: FontWeight.w600,
            color: palette.ink,
          ),
        ],
      );
    }

    final number = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        HomeWidgetText(
          text: '$days',
          size: isMedium ? 56 : 50,
          weight: FontWeight.w600,
          letterSpacing: isMedium ? -2.8 : -2.5,
          height: 0.95,
          maxLines: 1,
        ),
        const SizedBox(height: 3),
        Opacity(
          opacity: 0.85,
          child: HomeWidgetText(
            text: isMedium && duration != null
                ? context.durationText(
                    years: duration.years,
                    months: duration.months,
                    days: duration.days,
                  )
                : l10n.counterUnit(count: days),
            size: 14,
            maxLines: 1,
          ),
        ),
      ],
    );
    final initials = HomeWidgetInitials(
      own: payload.ownName,
      partner: payload.partnerName,
      ownColor: palette.label,
      ownBackground: AppPalette.white,
    );
    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [eyebrow, number, initials],
    );

    if (!isMedium) return SizedBox.expand(child: left);

    return Row(
      children: [
        Expanded(child: left),
        SizedBox(
          width: 140,
          child: _Timeline(payload: payload, palette: palette),
        ),
      ],
    );
  }
}

class const _Timeline({
  required final HomeWidgetPayload payload,
  required final HomeWidgetPalette palette,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final start = payload.togetherSince;
    final items = <({String text, bool isToday})>[
      if (payload.milestones.isEmpty && start != null)
        (text: DateFormatters.mediumDate(DateTime.parse(start)), isToday: false),
      for (final milestone in payload.milestones) (text: milestone.title, isToday: false),
      (text: l10n.counterToday, isToday: true),
    ];

    return Stack(
      children: [
        Positioned(
          left: 5,
          top: 10,
          bottom: 10,
          child: CustomPaint(painter: _DottedLinePainter(palette.ink.withValues(alpha: .4))),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final item in items)
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: -17,
                      top: 3,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: item.isToday ? HomeWidgetPalette.charcoal : palette.label,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppPalette.white, width: 2),
                        ),
                      ),
                    ),
                    HomeWidgetText(text: item.text, size: 12.5, maxLines: 1),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DottedLinePainter(final Color color) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    for (var y = 0.0; y < size.height; y += 5) {
      canvas.drawPoints(PointMode.points, [Offset(0, y)], paint);
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) => oldDelegate.color != color;
}
