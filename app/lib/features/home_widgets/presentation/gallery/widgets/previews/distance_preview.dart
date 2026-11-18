import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:timezone/timezone.dart' as tz;

/// Both clocks of a long-distance couple and the days until they meet.
class const DistancePreview({
  required final HomeWidgetPayload payload,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);
    final ownZone = payload.ownZone;
    final partnerZone = payload.partnerZone;

    if (ownZone == null || partnerZone == null) {
      return HomeWidgetFrame(
        size: HomeWidgetSize.medium,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppPalette.white,
          border: Border.all(color: palette.border),
        ),
        child: SizedBox.expand(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: HomeWidgetText(
              text: l10n.distanceMissing,
              size: 15,
              weight: FontWeight.w600,
              color: HomeWidgetPalette.charcoal,
              maxLines: 3,
            ),
          ),
        ),
      );
    }

    final days = payload.daysUntilReunionOn(now);
    final name = payload.partnerName;

    return HomeWidgetFrame(
      size: HomeWidgetSize.medium,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: _Half(
                  zone: ownZone,
                  label: l10n.distanceYou(city: _city(ownZone)),
                  now: now,
                  colors: const [HomeWidgetPalette.dayStart, HomeWidgetPalette.dayEnd],
                  alignment: CrossAxisAlignment.start,
                ),
              ),
              Expanded(
                child: _Half(
                  zone: partnerZone,
                  label: name == null ? _city(partnerZone) : '${_city(partnerZone)} · $name',
                  now: now,
                  colors: const [HomeWidgetPalette.nightStart, HomeWidgetPalette.nightHalfEnd],
                  alignment: CrossAxisAlignment.end,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
              color: AppPalette.white,
              borderRadius: BorderRadius.all(Radius.circular(22)),
              boxShadow: AppShadows.paper,
            ),
            child: days == null
                ? HomeWidgetText(
                    text: l10n.distanceNoReunion,
                    size: 12,
                    color: HomeWidgetPalette.charcoal,
                    align: TextAlign.center,
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HomeWidgetText(
                        text: '$days',
                        size: 26,
                        weight: FontWeight.w600,
                        letterSpacing: -1,
                        height: 1,
                        color: HomeWidgetPalette.charcoal,
                        maxLines: 1,
                      ),
                      HomeWidgetText(
                        text: l10n.distanceUntil(count: days),
                        size: 11.5,
                        color: context.colors.textSecondary,
                        maxLines: 1,
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  String _city(String zone) => zone.split('/').last.replaceAll('_', ' ');
}

class const _Half({
  required final String zone,
  required final String label,
  required final DateTime now,
  required final List<Color> colors,
  required final CrossAxisAlignment alignment,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final local = _localTime(zone, now);
    final isNight = local.hour < 6 || local.hour >= 18;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-0.4, -1),
          end: const Alignment(0.4, 1),
          colors: colors,
        ),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppIcon(icon: isNight ? AppIcons.moon : AppIcons.sun, size: 26, color: AppPalette.white),
          Column(
            crossAxisAlignment: alignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              HomeWidgetText(
                text: context.clock(local),
                size: 24,
                weight: FontWeight.w600,
                letterSpacing: -0.7,
                color: AppPalette.white,
                maxLines: 1,
              ),
              Opacity(
                opacity: 0.9,
                child: HomeWidgetText(
                  text: label,
                  size: 12.5,
                  color: AppPalette.white,
                  maxLines: 1,
                  align: alignment == CrossAxisAlignment.end ? TextAlign.right : TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime _localTime(String zone, DateTime now) {
    try {
      final local = tz.TZDateTime.from(now, tz.getLocation(zone));

      return DateTime(local.year, local.month, local.day, local.hour, local.minute);
    } on Object {
      return now;
    }
  }
}
