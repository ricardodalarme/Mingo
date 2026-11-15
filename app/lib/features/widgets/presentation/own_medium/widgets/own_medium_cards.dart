import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_surface_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Medium personal widgets (`X-147`): Ideia do dia and Potinho do dia ruim.
class const OwnMediumWidgetsCards({
  required final WidgetPayload payload,
  required final bool isDarkPreview,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;

    if (!payload.isSignedIn) {
      return WidgetSurfacePreview(
        categoryLabel: l10n.signedOutLabel,
        title: l10n.signedOutBody,
        subtitle: l10n.ownIdeaHint,
        isDark: isDarkPreview,
        deepLinkUri: Uri.parse('mingo://sign-in'),
      );
    }

    final ideaTitle = payload.dailyIdeaTitle ?? l10n.ownIdeaDefault;
    final ideaSubtitle = l10n.ownMediumIdeaAction;

    final jarTitle = l10n.ownMediumJarTitle;
    final jarSubtitle = l10n.ownMediumJarPrivacy;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WidgetSurfacePreview(
          categoryLabel: l10n.ownIdeaLabel,
          title: ideaTitle,
          subtitle: ideaSubtitle,
          isDark: isDarkPreview,
          deepLinkUri: Uri.parse('mingo://today'),
        ),
        const SizedBox(height: AppSpace.s16),
        WidgetSurfacePreview(
          categoryLabel: l10n.ownJarLabel,
          title: jarTitle,
          subtitle: jarSubtitle,
          isDark: isDarkPreview,
          deepLinkUri: Uri.parse('mingo://jar'),
        ),
      ],
    );
  }
}
