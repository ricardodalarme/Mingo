import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// The partner mood and longing widgets (`X-152`), side by side.
class const MoodLongingPreviewSection({required final WidgetPayload payload, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _tile(context, WidgetFamily.partnerMood, payload)),
            const SizedBox(width: AppSpace.s12),
            Expanded(child: _tile(context, WidgetFamily.longing, payload)),
          ],
        ),
        const SizedBox(height: AppSpace.s16),
        BaseNote(text: l10n.partnerMoodPrivacy),
        const SizedBox(height: AppSpace.s8),
        BaseNote(text: l10n.longingPrivacy, icon: AppIcons.heart),
        const SizedBox(height: AppSpace.s16),
        BaseButton(
          text: l10n.moodUpdateAction,
          variant: BaseButtonVariant.secondary,
          onPressed: () => context.pushRoute(MoodRoute()),
        ),
      ],
    );
  }

  Widget _tile(BuildContext context, WidgetFamily family, WidgetPayload payload) {
    final l10n = context.l10n.widgets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetFamilyPreview(family: family, payload: payload),
        const SizedBox(height: AppSpace.s8),
        Text(
          l10n.familyLabels.selectOrFallback(family.name),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.text.caption.copyWith(color: context.colors.textSecondary),
        ),
      ],
    );
  }
}
