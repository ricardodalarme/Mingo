import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_heart.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// What a home widget that needs a partner shows until one is connected.
class const InvitePreview({
  required final HomeWidgetPayload payload,
  required final HomeWidgetSize size,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);

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
            HomeWidgetHeart(size: 22, color: palette.highlight),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeWidgetText(
                  text: l10n.inviteTitle,
                  size: 15,
                  weight: FontWeight.w600,
                  color: HomeWidgetPalette.charcoal,
                  maxLines: 3,
                ),
                const SizedBox(height: 3),
                HomeWidgetText(
                  text: l10n.inviteAction,
                  size: 12.5,
                  color: palette.label,
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
