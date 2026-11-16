import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

/// The four states a message bubble can show.
enum BaseBubbleVariant() {
  /// The person's own message: dark, on the right.
  own,

  /// The other side's message: white with a hair border, on the left.
  other,

  /// Three pulsing dots for the other side.
  typing,

  /// An own message that did not send: error border and a retry link, on the right.
  failure,
}

const double _maxWidthFactor = .84;
const double _radius = 22;
const double _tailRadius = 8;
const double _sendingOpacity = .6;
const double _typingWidth = 62;
const double _typingHeight = 44;
const double _typingGap = 4;

/// A message bubble for own, other, typing and failed messages.
///
/// Own bubbles sit on the right with the dark action fill; a failed one keeps the surface with an error
/// border. `isSending` dims a bubble and `isFailed` gives any bubble the error border. Long press copying and retrying are the
/// feature's job: `onRetry` only draws the link. The screen reader hears the speaker, then the text.
class const BaseBubble({
  final BaseBubbleVariant variant = .other,
  final String? text,
  final String? time,
  final Widget? action,
  final VoidCallback? onRetry,
  final bool isSending = false,
  final bool isFailed = false,
  final String? speaker,
  final String? semanticLabel,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase;
    final isOwn = variant == .own || variant == .failure;
    final hasError = variant == .failure || isFailed;
    final background = variant == .own ? colors.actionPrimary : colors.bgSurface;
    final ink = variant == .own ? colors.textOnAction : colors.textPrimary;
    final border = hasError
        ? Border.all(color: AppStatus.error.inkColor(colors), width: AppBorder.error)
        : (variant == .own ? null : AppBorders.hair(colors.borderDefault));
    const radius = Radius.circular(_radius);
    const tail = Radius.circular(_tailRadius);
    final isTyping = variant == .typing;

    final retryText = onRetry == null ? null : l10n.common.tryAgain;
    final bubble = Container(
      constraints: isTyping
          ? const BoxConstraints(minWidth: _typingWidth, minHeight: _typingHeight)
          : null,
      padding: isTyping
          ? const EdgeInsets.symmetric(horizontal: AppSpace.s20, vertical: AppSpace.s16)
          : const EdgeInsets.symmetric(horizontal: AppSpace.s16, vertical: AppSpace.s12),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: isOwn ? radius : tail,
          bottomRight: isOwn ? tail : radius,
        ),
        border: border,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isTyping)
            BaseLoadingDots(
              gap: _typingGap,
              color: colors.textSecondary,
              semanticLabel: l10n.common.typing,
            )
          else if (text != null)
            Text(
              text!,
              style: context.text.bodySm.copyWith(fontSize: 15.5, height: 22 / 15.5, color: ink),
            ),
          if (time != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.s4),
              child: Text(
                time!,
                style: context.text.micro.copyWith(color: ink.withValues(alpha: .75)),
              ),
            ),
          if (retryText != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.s8),
              child: AppPressable(
                onTap: onRetry,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                enforceMinTapTarget: true,
                child: Text(
                  retryText,
                  style: context.text.bodySm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppStatus.error.inkColor(colors),
                  ),
                ),
              ),
            ),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.s8),
              child: action,
            ),
        ],
      ),
    );

    final said = speaker ?? (variant == .own ? l10n.common.youSaid : null);
    final label = semanticLabel ?? (said != null && text != null ? '$said: $text' : null);

    return LayoutBuilder(
      builder: (context, constraints) {
        final available = constraints.hasBoundedWidth
            ? constraints.maxWidth
            : MediaQuery.sizeOf(context).width;

        return Align(
          alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: available * _maxWidthFactor),
            child: Opacity(
              opacity: isSending ? _sendingOpacity : 1,
              child: Semantics(
                container: true,
                label: label,
                child: label == null ? bubble : ExcludeSemantics(child: bubble),
              ),
            ),
          ),
        );
      },
    );
  }
}
