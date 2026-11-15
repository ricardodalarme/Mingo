import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The three live theme choices.
class const ProfileThemePicker({
  required final AppThemeVariant selected,
  required final ValueChanged<AppThemeVariant> onChanged,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.profileSetup;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.themeLabel,
          style: context.text.label.copyWith(color: context.colors.textSecondary),
        ),
        const SizedBox(height: AppSpace.s8),
        Wrap(
          spacing: AppSpace.s8,
          runSpacing: AppSpace.s8,
          children: [
            BaseChoiceChip(
              label: l10n.themeRose,
              isSelected: selected == AppThemeVariant.rose,
              onTap: () => onChanged(AppThemeVariant.rose),
            ),
            BaseChoiceChip(
              label: l10n.themeBlue,
              isSelected: selected == AppThemeVariant.blue,
              onTap: () => onChanged(AppThemeVariant.blue),
            ),
            BaseChoiceChip(
              label: l10n.themeNeutral,
              isSelected: selected == AppThemeVariant.neutral,
              onTap: () => onChanged(AppThemeVariant.neutral),
            ),
          ],
        ),
      ],
    );
  }
}
