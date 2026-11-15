import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/presentation/mood/mood_faces.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// Every mood as a tappable face with its label, three per row.
class const MoodGrid({
  required final MoodKind? selected,
  required final ValueChanged<MoodKind> onSelected,
  final bool isEnabled = true,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.mood;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - AppSpace.s8 * 2) / 3;

        return Wrap(
          spacing: AppSpace.s8,
          runSpacing: AppSpace.s8,
          children: [
            for (final mood in MoodKind.values)
              SizedBox(
                width: width,
                child: _MoodTile(
                  mood: mood,
                  label: l10n.moods.selectOrFallback(mood.name),
                  isSelected: selected == mood,
                  isEnabled: isEnabled,
                  onTap: () => onSelected(mood),
                ),
              ),
          ],
        );
      },
    );
  }
}

class const _MoodTile({
  required final MoodKind mood,
  required final String label,
  required final bool isSelected,
  required final bool isEnabled,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppPressable(
      onTap: onTap,
      isEnabled: isEnabled,
      isSelected: isSelected,
      borderRadius: BorderRadius.circular(AppRadius.card),
      enforceMinTapTarget: true,
      child: AnimatedContainer(
        width: double.infinity,
        duration: context.motionDuration(AppMotion.fast),
        padding: const EdgeInsets.symmetric(vertical: AppSpace.s12),
        decoration: BoxDecoration(
          color: isSelected ? colors.accentSoft : colors.bgSurface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: isSelected
              ? AppBorders.selected(colors.borderSelected)
              : AppBorders.hair(colors.borderDefault),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseFace(kind: mood.face, selected: isSelected, semanticLabel: label),
            const SizedBox(height: AppSpace.s8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.text.bodySm.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? colors.accentLabel : colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
