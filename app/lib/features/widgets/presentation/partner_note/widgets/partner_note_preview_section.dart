import 'dart:io';

import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_payload.dart';
import 'package:app/features/widgets/presentation/shared/widget_family_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Medium and small previews of the partner note widget (`X-151`).
class const PartnerNotePreviewSection({required final WidgetPayload payload, super.key})
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
        WidgetFamilyPreview(family: WidgetFamily.partnerNote, payload: payload),
        const SizedBox(height: AppSpace.s20),
        Text(l10n.previewSmall, style: context.text.label.copyWith(color: colors.textSecondary)),
        const SizedBox(height: AppSpace.s8),
        WidgetFamilyPreview(family: WidgetFamily.partnerNote, payload: payload),
        const SizedBox(height: AppSpace.s16),
        BaseNote(text: l10n.partnerNotePrivacy),
        if (!payload.allowPartnerNotes) ...[
          const SizedBox(height: AppSpace.s8),
          BaseNote(text: l10n.noteDisabledHint, icon: AppIcons.info),
        ],
        if (!Platform.isAndroid) ...[
          const SizedBox(height: AppSpace.s8),
          BaseNote(text: l10n.howToAddIosLockNote, icon: AppIcons.info),
        ],
      ],
    );
  }
}
