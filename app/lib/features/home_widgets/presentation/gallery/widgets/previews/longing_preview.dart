import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_heart.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The one-tap "missing you" home widget, or the missing the partner just sent.
class const LongingPreview({
  required final HomeWidgetPayload payload,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);
    final missedAt = DateTime.tryParse(payload.partnerMissedAt ?? '')?.toLocal();

    return HomeWidgetFrame(
      size: HomeWidgetSize.small,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.85,
          colors: [palette.mist, palette.soft.withValues(alpha: .7), AppPalette.white],
          stops: const [0, 0.6, 1],
        ),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: palette.ink),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 90,
              height: 90,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  _Ring(size: 90, color: palette.highlight.withValues(alpha: .25)),
                  _Ring(size: 62, color: palette.highlight.withValues(alpha: .4)),
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(color: palette.highlight, shape: BoxShape.circle),
                    child: const HomeWidgetHeart(size: 28, color: AppPalette.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            HomeWidgetText(
              text: missedAt == null ? l10n.longingAction : l10n.longingReceived,
              size: 14.5,
              weight: FontWeight.w600,
              align: TextAlign.center,
            ),
            if (missedAt != null)
              Opacity(
                opacity: 0.75,
                child: HomeWidgetText(text: context.agoText(missedAt, now), size: 12, maxLines: 1),
              ),
          ],
        ),
      ),
    );
  }
}

class const _Ring({required final double size, required final Color color})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
    );
  }
}
