import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/features/mood/presentation/mood/mood_faces.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The mood the partner chose to share, or the honest note that none is shared.
class const PartnerMoodPreview({
  required final HomeWidgetPayload payload,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);
    final mood = payload.partnerMood;
    final at = DateTime.tryParse(payload.partnerMoodAt ?? '')?.toLocal();
    final name = payload.partnerName;
    final eyebrow = mood == null
        ? l10n.moodNowAnonymous
        : (name == null ? l10n.moodNowAnonymous : l10n.moodNow(name: name));

    return HomeWidgetFrame(
      size: HomeWidgetSize.small,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(0.6, -0.6),
          radius: 1.1,
          colors: [palette.mist, palette.soft, AppPalette.white],
          stops: const [0, 0.55, 1],
        ),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: palette.ink),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -34,
              top: -32,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppPalette.white.withValues(alpha: .5),
                ),
              ),
            ),
            SizedBox.expand(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeWidgetEyebrow(text: eyebrow, color: palette.ink.withValues(alpha: .75)),
                  if (mood == null)
                    HomeWidgetText(
                      text: l10n.moodHidden,
                      size: 13,
                      color: palette.ink.withValues(alpha: .8),
                      maxLines: 4,
                    )
                  else ...[
                    BaseFace(kind: mood.face, size: FaceSize.showcase, tint: palette.highlight),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeWidgetText(
                          text: context.moodName(mood),
                          size: 17,
                          weight: FontWeight.w600,
                          letterSpacing: -0.3,
                          maxLines: 1,
                        ),
                        if (at != null)
                          Opacity(
                            opacity: 0.75,
                            child: HomeWidgetText(
                              text: context.agoText(at, now),
                              size: 12.5,
                              maxLines: 1,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
