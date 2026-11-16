import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

/// The confirmation sheet for destructive or irreversible actions.
///
/// A bottom sheet with a handle, the question, one sentence and the exact verb on a filled button over
/// a text Cancel. Use it only for actions that remove something; the destructive variant fills the
/// verb in the error color.
abstract final class BaseConfirmSheet() {
  /// Shows the sheet and resolves to the person's choice.
  ///
  /// Returns `true` on confirm and `false` on cancel, scrim tap or drag. [onConfirm] runs before the
  /// sheet closes.
  static Future<bool> show({
    required BuildContext context,
    required String title,
    required String text,
    required String confirmText,
    VoidCallback? onConfirm,
    String? cancelText,
    bool isDestructive = false,
  }) async {
    final cancel = cancelText ?? context.designSystemL10nOrBase.common.cancel;

    final result = await BaseSheet.show<bool>(
      context: context,
      title: title,
      subtitle: text,
      hasCloseButton: false,
      child: Builder(
        builder: (sheetContext) {
          void close({required bool didConfirm}) => Navigator.of(sheetContext).pop(didConfirm);

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpace.s6,
            children: [
              if (isDestructive)
                BaseButton.danger(
                  text: confirmText,
                  onPressed: () {
                    onConfirm?.call();
                    close(didConfirm: true);
                  },
                )
              else
                BaseButton.primary(
                  text: confirmText,
                  onPressed: () {
                    onConfirm?.call();
                    close(didConfirm: true);
                  },
                ),
              BaseButton.text(
                text: cancel,
                onPressed: () => close(didConfirm: false),
                isFullWidth: true,
              ),
            ],
          );
        },
      ),
    );

    return result ?? false;
  }
}
