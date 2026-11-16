import 'package:design_system/design_system.dart';

/// One face and its label in a [MoodRow].
class const MoodRowOption({required final FaceKind face, required final String label});

/// A section header with a row of tappable faces and their labels.
///
/// The row is a selector: [selectedIndex] fills the chosen option, and every option answers the
/// tap at once.
class const MoodRow({
  required final String title,
  required final List<MoodRowOption> options,
  required final ValueChanged<int> onSelected,
  final String? supportText,
  final String? actionLabel,
  final VoidCallback? onAction,
  final int? selectedIndex,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final action = actionLabel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(title, style: context.text.titleSm)),
            if (action != null)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onAction,
                child: Text(
                  action,
                  style: context.text.bodySm.copyWith(color: colors.textSecondary),
                ),
              ),
          ],
        ),
        if (supportText != null) ...[
          const SizedBox(height: AppSpace.s4),
          Text(supportText!, style: context.text.caption.copyWith(color: colors.textSecondary)),
        ],
        const SizedBox(height: AppSpace.s14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var index = 0; index < options.length; index++)
              Expanded(
                child: _MoodOption(
                  option: options[index],
                  isSelected: selectedIndex == index,
                  onTap: () => onSelected(index),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class const _MoodOption({
  required final MoodRowOption option,
  required final bool isSelected,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppPressable(
      onTap: onTap,
      semanticLabel: option.label,
      isSelected: isSelected,
      enforceMinTapTarget: true,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: SizedBox(
        width: double.infinity,
        child: AnimatedContainer(
          duration: context.motionDuration(AppMotion.fast),
          padding: const EdgeInsets.symmetric(vertical: AppSpace.s8),
          decoration: BoxDecoration(
            color: isSelected ? colors.accentSoft : null,
            borderRadius: BorderRadius.circular(AppRadius.card),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BaseFace(kind: option.face, size: FaceSize.large, selected: isSelected),
              const SizedBox(height: AppSpace.s6),
              Text(
                option.label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.text.micro.copyWith(
                  color: isSelected ? colors.accentLabel : colors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
