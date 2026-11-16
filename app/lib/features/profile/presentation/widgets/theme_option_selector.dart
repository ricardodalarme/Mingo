import 'package:app/features/profile/presentation/widgets/theme_preview.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The three app colours as full option tiles with a miniature preview.
class const ThemeOptionSelector({
  required final AppThemeVariant selected,
  required final ValueChanged<AppThemeVariant> onChanged,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.intro.theme;

    final options = [
      (AppThemeVariant.rose, l10n.rose, l10n.roseSupport),
      (AppThemeVariant.blue, l10n.blue, l10n.blueSupport),
      (AppThemeVariant.neutral, l10n.neutral, l10n.neutralSupport),
    ];

    return Column(
      children: [
        for (final (variant, title, support) in options) ...[
          BaseOptionTile(
            title: title,
            support: support,
            preview: ThemePreview(variant: variant),
            isSelected: selected == variant,
            onTap: () => onChanged(variant),
          ),
          const SizedBox(height: AppSpace.s10),
        ],
      ],
    );
  }
}
