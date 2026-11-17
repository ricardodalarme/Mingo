import 'package:design_system/design_system.dart';

/// A centred explanation shown when a read or an action failed, with one way to try again.
///
/// It looks like [BaseEmptyState] but always shows [FaceKind.sad], so a failure is never mistaken
/// for an empty list. Use it for failures that need their own copy; the shared failure surface in
/// the app builds on it.
class const BaseErrorState({
  required final String title,
  required final String text,
  final String? actionText,
  final VoidCallback? onAction,
  final bool isSecondaryAction = false,
  final String? faceLabel,
  final int? textMaxLines = 2,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseEmptyState(
      face: FaceKind.sad,
      title: title,
      text: text,
      actionText: actionText,
      onAction: onAction,
      isSecondaryAction: isSecondaryAction,
      faceLabel: faceLabel,
      textMaxLines: textMaxLines,
    );
  }
}
