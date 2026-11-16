import 'package:design_system/design_system.dart';

const double _topInset = 80;
const double _textMaxWidth = 260;
const double _gap = AppSpace.s8;

/// A centred invitation shown when a collection is empty or a read failed.
///
/// A 64 point face, a title, up to two lines of text and one action, starting 80 points from the top.
/// There is no container: the page draws behind it. The caller supplies the face, title and supporting
/// line; a failed read uses [FaceKind.sad] and a retry action.
class const BaseEmptyState({
  required final String title,
  required final String text,
  final String? actionText,
  final VoidCallback? onAction,
  final bool isSecondaryAction = false,
  final FaceKind face = FaceKind.smile,
  final String? faceLabel,
  final int? textMaxLines = 2,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final action = actionText;

    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpace.s24, _topInset, AppSpace.s24, AppSpace.s8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: _gap,
        children: [
          BaseFace(kind: face, size: FaceSize.showcase, semanticLabel: faceLabel),
          Text(
            title,
            textAlign: TextAlign.center,
            style: context.text.titleSm.copyWith(
              fontWeight: FontWeight.w600,
              color: colors.textPrimary,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _textMaxWidth),
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: textMaxLines,
              overflow: textMaxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
              style: context.text.bodySm.copyWith(color: colors.textSecondary),
            ),
          ),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.s10),
              child: isSecondaryAction
                  ? BaseButton.secondary(text: action, onPressed: onAction)
                  : BaseButton.primary(text: action, onPressed: onAction, isFullWidth: false),
            ),
        ],
      ),
    );
  }
}
