import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_surface_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';

/// 2x2 grid of the four small personal widgets (`X-146`):
/// Anotar slip, Próxima data, Humor, and Ritual.
class const OwnSmallWidgetsGrid({
  required final WidgetPayload payload,
  required final bool isDarkPreview,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final now = clock.now();

    if (!payload.isSignedIn) {
      return WidgetSurfacePreview(
        categoryLabel: l10n.signedOutLabel,
        title: l10n.signedOutBody,
        subtitle: l10n.ownIdeaHint,
        isDark: isDarkPreview,
        deepLinkUri: Uri.parse('mingo://sign-in'),
      );
    }

    final daysUntilDate = payload.daysUntilNextDateOn(now);
    final dateTitle = switch (daysUntilDate) {
      final days? => l10n.ownSmallDateDays(count: days),
      null => l10n.ownSmallDateDefaultTitle,
    };
    final dateSubtitle = payload.nextDateTitle ?? l10n.ownIdeaHint;

    final ritualTitle = payload.ritualTitle ?? l10n.ownSmallRitualDefaultTitle;
    final ritualSubtitle = payload.ritualSchedule ?? l10n.ownSmallRitualDefaultTime;

    final moodTitle = l10n.ownSmallMoodPrompt;
    final moodSubtitle = l10n.ownSmallMoodOptions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: WidgetSurfacePreview(
                categoryLabel: l10n.ownSlipLabel,
                title: l10n.ownSlipTitle,
                subtitle: l10n.ownSlipSubtitle,
                badgeText: l10n.ownSmallSlipAction,
                isDark: isDarkPreview,
                deepLinkUri: Uri.parse('mingo://capture'),
              ),
            ),
            const SizedBox(width: AppSpace.s12),
            Expanded(
              child: WidgetSurfacePreview(
                categoryLabel: l10n.ownSmallDateDefaultTitle,
                title: dateTitle,
                subtitle: dateSubtitle,
                isDark: isDarkPreview,
                deepLinkUri: Uri.parse('mingo://dates'),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.s12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: WidgetSurfacePreview(
                categoryLabel: l10n.ownSmallMoodLabel,
                title: moodTitle,
                subtitle: moodSubtitle,
                isDark: isDarkPreview,
                deepLinkUri: Uri.parse('mingo://mood'),
              ),
            ),
            const SizedBox(width: AppSpace.s12),
            Expanded(
              child: WidgetSurfacePreview(
                categoryLabel: l10n.ownSmallRitualLabel,
                title: ritualTitle,
                subtitle: ritualSubtitle,
                isDark: isDarkPreview,
                deepLinkUri: Uri.parse('mingo://rituals'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
