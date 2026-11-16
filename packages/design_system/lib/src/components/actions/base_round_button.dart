import 'package:design_system/design_system.dart';

/// The weight of a [BaseRoundButton].
enum BaseRoundButtonVariant() {
  /// A white 40 point button for app bars and back or close actions.
  standard,

  /// The dark 50 point button for the one main icon action of a bar, such as send.
  primary,
}

const double _standardSide = 40;
const double _primarySide = 50;
const double _primaryIconSize = AppIconSize.lg;

/// A circular icon button.
///
/// Icon-only, so [semanticLabel] should always be supplied. While [isLoading] the icon is
/// replaced by loading dots and taps are ignored.
class const BaseRoundButton({
  required final IconData icon,
  required final VoidCallback? onPressed,
  final String? semanticLabel,
  final BaseRoundButtonVariant variant = .standard,
  final bool isEnabled = true,
  final bool isLoading = false,
  super.key,
}) extends StatefulWidget {
  /// The dark 50 point variant, for the one main icon action of a bar.
  const new primary({
    required IconData icon,
    required VoidCallback? onPressed,
    String? semanticLabel,
    bool isEnabled = true,
    bool isLoading = false,
    Key? key,
  }) : this(
         icon: icon,
         onPressed: onPressed,
         semanticLabel: semanticLabel,
         variant: .primary,
         isEnabled: isEnabled,
         isLoading: isLoading,
         key: key,
       );

  @override
  State<BaseRoundButton> createState() => _BaseRoundButtonState();
}

class _BaseRoundButtonState() extends State<BaseRoundButton> {
  bool _isPressed = false;

  void _setPressed(bool isInteractive, bool value) {
    if (!isInteractive || _isPressed == value) return;
    setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isPrimary = widget.variant == .primary;
    final side = isPrimary ? _primarySide : _standardSide;
    final foreground = isPrimary ? colors.textOnAction : colors.iconDefault;
    final isInteractive = widget.isEnabled && !widget.isLoading && widget.onPressed != null;

    return AppPressable(
      onTap: isInteractive ? widget.onPressed : null,
      isEnabled: widget.isEnabled && (widget.isLoading || widget.onPressed != null),
      semanticLabel: widget.semanticLabel,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      enforceMinTapTarget: true,
      child: Listener(
        onPointerDown: (_) => _setPressed(isInteractive, true),
        onPointerUp: (_) => _setPressed(isInteractive, false),
        onPointerCancel: (_) => _setPressed(isInteractive, false),
        child: SizedBox(
          width: side,
          height: side,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isPrimary
                  ? (_isPressed ? colors.actionPrimaryPressed : colors.actionPrimary)
                  : colors.bgSurface,
              border: isPrimary ? null : AppBorders.hair(colors.borderDefault),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: widget.isLoading
                  ? ExcludeSemantics(child: BaseLoadingDots(color: foreground))
                  : AppIcon(
                      icon: widget.icon,
                      size: isPrimary ? _primaryIconSize : AppIconSize.md,
                      color: foreground,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
