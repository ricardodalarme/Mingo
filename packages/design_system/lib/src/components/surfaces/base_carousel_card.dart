import 'package:design_system/design_system.dart';

const double _minHeight = 178;
const double _titleSize = 21;
const double _supportSize = 14.5;

/// The page of a [BaseCarousel]: a tag, a title, a support line and one compact action.
///
/// The whole card is a target when [onTap] is set; [actionText] adds the dark compact button
/// that runs [onAction]. The title takes two lines at most.
class const BaseCarouselCard({
  required final String tag,
  required final String title,
  final String? supportText,
  final String? actionText,
  final VoidCallback? onAction,
  final VoidCallback? onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final card = Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: _minHeight),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.s20, vertical: AppSpace.s18),
      decoration: BoxDecoration(
        color: colors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.ring,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseTag(text: tag),
          const SizedBox(height: AppSpace.s12),
          Semantics(
            header: true,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.text.titleSm.copyWith(
                fontSize: _titleSize,
                height: 1.2,
                letterSpacing: -.42,
              ),
            ),
          ),
          if (supportText != null) ...[
            const SizedBox(height: AppSpace.s6),
            Text(
              supportText!,
              style: context.text.bodySm.copyWith(
                fontSize: _supportSize,
                color: colors.textSecondary,
              ),
            ),
          ],
          if (actionText != null) ...[
            const SizedBox(height: AppSpace.s12),
            BaseButton.compact(text: actionText!, onPressed: onAction ?? onTap),
          ],
        ],
      ),
    );

    if (onTap == null) return card;

    return AppPressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.card),
      child: card,
    );
  }
}
