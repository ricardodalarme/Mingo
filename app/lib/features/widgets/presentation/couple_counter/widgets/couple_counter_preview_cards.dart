import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// Small and medium previews of the couple counter (`X-149`).
class const CoupleCounterPreviewCards({required final WidgetPayload payload, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.counterSmallLabel,
          style: context.text.label.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpace.s8),
        WidgetFamilyPreview(family: WidgetFamily.counter, payload: payload),
        const SizedBox(height: AppSpace.s20),
        Text(
          l10n.counterMediumLabel,
          style: context.text.label.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpace.s8),
        WidgetFamilyPreview(family: WidgetFamily.counterMedium, payload: payload),
        const SizedBox(height: AppSpace.s16),
        BaseNote(text: l10n.counterMidnightNote, icon: AppIcons.clock),
        if (payload.isSignedIn && !payload.isPaired) ...[
          const SizedBox(height: AppSpace.s12),
          BaseButton(
            text: l10n.statesUnpairedAction,
            variant: BaseButtonVariant.secondary,
            onPressed: () => context.pushRoute(const InviteRoute()),
          ),
        ],
        if (payload.isSignedIn && payload.togetherSince == null) ...[
          const SizedBox(height: AppSpace.s12),
          BaseButton(
            text: l10n.counterSetDateAction,
            variant: BaseButtonVariant.secondary,
            onPressed: () => context.pushRoute(const RelationshipRoute()),
          ),
        ],
      ],
    );
  }
}
