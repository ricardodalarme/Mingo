import 'package:design_system/design_system.dart';

const double _height = 40;
const double _circle = 30;
const double _gap = 8;

/// A tappable pill with a 30 point leading circle and a short label.
///
/// Acts like a button, not a selectable filter: for choices use [BaseChoiceChip]. The [leading] is
/// usually an icon on a soft tint ([BaseChip.icon]) or a [BaseAvatar] ([BaseChip.avatar]). The label is
/// one line and never wraps.
class const BaseChip({
  required final String label,
  required final Widget leading,
  final VoidCallback? onTap,
  final bool isEnabled = true,
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  /// A chip whose circle holds [icon] in the accent over the soft tint.
  new icon({
    required String label,
    required IconData icon,
    VoidCallback? onTap,
    bool isEnabled = true,
    String? semanticLabel,
    Key? key,
  }) : this(
         label: label,
         leading: _IconCircle(icon: icon),
         onTap: onTap,
         isEnabled: isEnabled,
         semanticLabel: semanticLabel,
         key: key,
       );

  /// A chip whose circle holds [initials] or a [imageUrl] photo.
  new avatar({
    required String label,
    String? initials,
    String? imageUrl,
    bool isPartner = false,
    VoidCallback? onTap,
    bool isEnabled = true,
    String? semanticLabel,
    Key? key,
  }) : this(
         label: label,
         leading: BaseAvatar(
           initials: initials,
           imageUrl: imageUrl,
           isPartner: isPartner,
           hasRing: false,
           size: .small,
         ),
         onTap: onTap,
         isEnabled: isEnabled,
         semanticLabel: semanticLabel,
         key: key,
       );

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final chip = Container(
      height: _height,
      padding: const EdgeInsets.only(left: 5, right: AppSpace.s14),
      decoration: BoxDecoration(
        color: colors.bgSurface,
        borderRadius: BorderRadius.circular(_height / 2),
        border: AppBorders.hair(colors.borderDefault),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: _gap,
        children: [
          SizedBox(
            width: _circle,
            height: _circle,
            child: FittedBox(child: leading),
          ),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: context.text.bodySm.copyWith(
                fontWeight: FontWeight.w500,
                color: colors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );

    return AppPressable(
      onTap: onTap,
      isEnabled: isEnabled && onTap != null,
      semanticLabel: semanticLabel ?? label,
      borderRadius: BorderRadius.circular(_height / 2),
      enforceMinTapTarget: true,
      child: ExcludeSemantics(child: chip),
    );
  }
}

class const _IconCircle({required final IconData icon}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: _circle,
      height: _circle,
      decoration: BoxDecoration(color: colors.accentSoft, shape: BoxShape.circle),
      child: Center(
        child: AppIcon(icon: icon, size: 15, color: colors.accentHighlight),
      ),
    );
  }
}
