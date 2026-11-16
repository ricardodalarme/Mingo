import 'package:design_system/design_system.dart';

const double _illustrationWidth = 48;
const double _illustrationHeight = 40;

/// A banner with a drawn [illustration] on the left and a compact action on the right.
///
/// For moments that deserve a picture, such as a received card. One per screen. A radial wash grows from
/// the left edge. It reads as one item with the button as its action; the illustration is decorative and draws its own
/// colors (an icon takes `accentLabel`).
/// The standard banner with a 20 point icon is [BaseBanner].
class const BaseIllustratedBanner({
  required final Widget illustration,
  required final String title,
  required final String actionLabel,
  required final VoidCallback? onAction,
  final String? message,
  final VoidCallback? onTap,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = BorderRadius.circular(AppRadius.card);

    final content = Container(
      padding: const EdgeInsets.fromLTRB(AppSpace.s18, AppSpace.s16, AppSpace.s16, AppSpace.s16),
      decoration: BoxDecoration(
        color: colors.bgSurface,
        borderRadius: radius,
        border: AppBorders.hair(colors.borderDefault),
        gradient: RadialGradient(
          center: Alignment.centerLeft,
          radius: 1.1,
          colors: [colors.washLight, colors.washLight.withValues(alpha: 0)],
          stops: const [0, .7],
        ),
      ),
      child: Row(
        spacing: 14,
        children: [
          ExcludeSemantics(
            child: SizedBox(
              width: _illustrationWidth,
              height: _illustrationHeight,
              child: FittedBox(child: illustration),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.text.body.copyWith(fontWeight: FontWeight.w600)),
                if (message != null)
                  Text(message!, style: context.text.caption.copyWith(color: colors.textSecondary)),
              ],
            ),
          ),
          BaseButton.compact(text: actionLabel, onPressed: onAction),
        ],
      ),
    );

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: [title, ?message].join('. '),
      child: onTap == null
          ? content
          : AppPressable(onTap: onTap, borderRadius: radius, child: content),
    );
  }
}
