import 'package:design_system/src/icons/app_icon.dart';
import 'package:design_system/src/theme/app_theme.dart';
import 'package:design_system/src/tokens/tokens.dart';
import 'package:flutter/widgets.dart';

/// The line under a field: an icon and a caption, in the error ink when [isError].
///
/// An error is announced to screen readers as it appears.
class const FieldMessage({
  required final String text,
  final bool isError = false,
  final bool isCentered = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final color = isError ? AppPalette.errorInk : colors.textSecondary;

    return Semantics(
      liveRegion: isError,
      child: Row(
        mainAxisAlignment: isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpace.s6,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: AppIcon(
              icon: isError ? AppIcons.warning : AppIcons.info,
              size: 16,
              color: color,
            ),
          ),
          Flexible(
            child: Text(
              text,
              textAlign: isCentered ? TextAlign.center : TextAlign.start,
              style: context.text.caption.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
