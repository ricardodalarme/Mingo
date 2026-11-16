import 'package:design_system/design_system.dart';

const double _tileRadius = 18;
const double _tileMinHeight = 56;
const double _tileHorizontalPadding = 16;
const double _tileVerticalPadding = 14;
const double _tileGap = 12;
const double _supportGap = 2;
const double _previewRadius = 26;
const double _previewTileGap = 14;
const double _previewWidth = 74;
const double _previewHeight = 86;
const double _previewInnerRadius = 16;

/// A selectable row with a title, optional support text and a leading visual.
///
/// The trailing control is a radio or checkbox; selection reports through
/// [onTap]. A [preview] takes the place of [leading] with a 74 × 86 rounded slot, for choices that are
/// better seen than described; the tile then uses the roomier radius 26 and is decorative to readers.
class const BaseOptionTile({
  required final String title,
  final String? support,
  final Widget? leading,
  final Widget? preview,
  final bool isSelected = false,
  final VoidCallback? onTap,
  final BaseOptionTileControl control = BaseOptionTileControl.radio,
  final String? semanticLabel,
  final bool isEnabled = true,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final hasPreview = preview != null;
    final tileRadius = hasPreview ? _previewRadius : _tileRadius;

    final card = Container(
      constraints: const BoxConstraints(minHeight: _tileMinHeight),
      padding: hasPreview
          ? const EdgeInsets.fromLTRB(
              AppSpace.s12,
              AppSpace.s12,
              _tileHorizontalPadding,
              AppSpace.s12,
            )
          : const EdgeInsets.symmetric(
              horizontal: _tileHorizontalPadding,
              vertical: _tileVerticalPadding,
            ),
      decoration: BoxDecoration(
        color: colors.bgSurface,
        borderRadius: BorderRadius.circular(tileRadius),
        border: Border.all(
          color: isSelected ? colors.borderSelected : colors.borderDefault,
          width: isSelected ? AppBorder.selected : AppBorder.hair,
        ),
        boxShadow: isSelected ? AppShadows.selected : null,
      ),
      child: Row(
        spacing: hasPreview ? _previewTileGap : _tileGap,
        children: [
          if (hasPreview)
            ExcludeSemantics(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(_previewInnerRadius),
                child: SizedBox(width: _previewWidth, height: _previewHeight, child: preview),
              ),
            )
          else
            ?leading,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.text.body.copyWith(
                    fontWeight: hasPreview ? FontWeight.w600 : FontWeight.w500,
                    fontSize: hasPreview ? 16.5 : null,
                    color: colors.textPrimary,
                  ),
                ),
                if (support != null) ...[
                  const SizedBox(height: _supportGap),
                  Text(support!, style: context.text.caption.copyWith(color: colors.textSecondary)),
                ],
              ],
            ),
          ),
          ExcludeSemantics(
            child: switch (control) {
              .radio => BaseRadio(isSelected: isSelected),
              .checkbox => BaseCheckbox(value: isSelected),
            },
          ),
        ],
      ),
    );

    final semantics = Semantics(
      label: semanticLabel ?? title,
      selected: isSelected,
      enabled: isEnabled,
      child: ExcludeSemantics(child: card),
    );

    if (onTap == null) return semantics;

    return Semantics(
      label: semanticLabel ?? title,
      selected: isSelected,
      enabled: isEnabled,
      child: AppPressable(
        onTap: onTap,
        isEnabled: isEnabled,
        borderRadius: BorderRadius.circular(tileRadius),
        isSelected: isSelected,
        enforceMinTapTarget: true,
        child: ExcludeSemantics(child: card),
      ),
    );
  }
}

/// The selection control shown at the end of a [BaseOptionTile].
enum BaseOptionTileControl() {
  /// A single-choice radio circle.
  radio,

  /// A multiple-choice checkbox.
  checkbox,
}
