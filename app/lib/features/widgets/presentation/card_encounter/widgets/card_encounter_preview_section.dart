import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// Medium and small previews of the card and next encounter widget (`X-153`).
class const CardEncounterPreviewSection({required final WidgetPayload payload, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.previewMedium, style: context.text.label.copyWith(color: colors.textSecondary)),
        const SizedBox(height: AppSpace.s8),
        WidgetFamilyPreview(family: WidgetFamily.cardEncounter, payload: payload),
        const SizedBox(height: AppSpace.s20),
        Text(l10n.previewSmall, style: context.text.label.copyWith(color: colors.textSecondary)),
        const SizedBox(height: AppSpace.s8),
        WidgetFamilyPreview(family: WidgetFamily.ownSundayCard, payload: payload),
        const SizedBox(height: AppSpace.s16),
        BaseNote(text: l10n.cardEncounterPrivacyNote, icon: AppIcons.shield),
        const SizedBox(height: AppSpace.s8),
        BaseButton(
          text: l10n.nextEncounterEmptySubtitle,
          variant: BaseButtonVariant.secondary,
          onPressed: () => context.pushRoute(const DatesRoute()),
        ),
      ],
    );
  }
}
