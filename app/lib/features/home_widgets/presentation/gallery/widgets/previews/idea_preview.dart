import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The idea of the day.
class const IdeaPreview({required final HomeWidgetPayload payload, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);
    final title = payload.dailyIdeaTitle;

    return HomeWidgetFrame(
      size: HomeWidgetSize.medium,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(-1, -0.4),
          end: const Alignment(1, 0.4),
          colors: [HomeWidgetPalette.cream, palette.soft],
        ),
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: palette.ink),
        child: Row(
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                color: AppPalette.white,
                borderRadius: const BorderRadius.all(Radius.circular(26)),
                boxShadow: [
                  BoxShadow(
                    color: palette.label.withValues(alpha: .3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                    spreadRadius: -12,
                  ),
                ],
              ),
              child: AppIcon(icon: AppIcons.lightbulb, size: 40, color: palette.highlight),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeWidgetEyebrow(
                    text: l10n.ideaEyebrow,
                    color: palette.ink.withValues(alpha: .75),
                  ),
                  const SizedBox(height: 6),
                  HomeWidgetText(
                    text: title ?? l10n.ideaEmpty,
                    size: 18,
                    weight: FontWeight.w600,
                    letterSpacing: -0.4,
                    height: 1.2,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 4),
                  Opacity(
                    opacity: 0.8,
                    child: HomeWidgetText(text: l10n.ideaHint, size: 12.5, maxLines: 1),
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
