import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The ritual the couple keeps, on a night sky, with when it comes next.
class const RitualPreview({
  required final HomeWidgetPayload payload,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final title = payload.ritualTitle;
    final weekday = payload.ritualWeekday;
    final time = payload.ritualTime;
    final when = weekday != null && time != null
        ? context.whenText(weekday: weekday, time: time, now: now)
        : null;

    return HomeWidgetFrame(
      size: HomeWidgetSize.small,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-0.3, -1),
          end: Alignment(0.3, 1),
          colors: [
            HomeWidgetPalette.nightStart,
            HomeWidgetPalette.nightMiddle,
            HomeWidgetPalette.nightEnd,
          ],
          stops: [0, 0.7, 1],
        ),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: AppPalette.white),
        child: Stack(
          children: [
            const Positioned(
              right: -10,
              top: -10,
              child: Opacity(
                opacity: 0.9,
                child: AppIcon(icon: AppIcons.moon, size: 54, color: AppPalette.white),
              ),
            ),
            SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeWidgetEyebrow(
                    text: l10n.ritualEyebrow,
                    color: AppPalette.white.withValues(alpha: .75),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeWidgetText(
                        text: title ?? l10n.ritualEmptyTitle,
                        size: 21,
                        weight: FontWeight.w600,
                        letterSpacing: -0.4,
                        height: 1.1,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 6),
                      Opacity(
                        opacity: 0.8,
                        child: HomeWidgetText(
                          text: when ?? l10n.ritualEmptyHint,
                          size: 12.5,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
