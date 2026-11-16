import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Explains what inviting a partner adds.
Future<void> showWhyInviteSheet(BuildContext context) {
  final l10n = context.l10n.partnerStep.why;

  return BaseSheet.show<void>(
    context: context,
    title: l10n.title,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.shared, style: context.text.body),
        const SizedBox(height: AppSpace.s12),
        Text(l10n.privacy, style: context.text.body.copyWith(color: context.colors.textSecondary)),
      ],
    ),
  );
}
