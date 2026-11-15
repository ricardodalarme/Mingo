import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The logical size of a share card; exported at 1080 by 1350 pixels.
const double shareCardWidth = 360;
const double shareCardHeight = 450;
const double shareCardPadding = AppSpace.s28;

/// The width a card's content can use between its paddings.
const double shareCardContentWidth = shareCardWidth - shareCardPadding * 2;

/// The surface every share card is drawn on: an eyebrow, the content and the product mark.
class const ShareCardFrame({
  required final String eyebrow,
  required final Widget child,
  final bool isDark = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n.share;
    final secondary = isDark
        ? colors.textOnAction.withValues(alpha: .72)
        : colors.textSecondary;

    final content = Padding(
      padding: const EdgeInsets.all(shareCardPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            eyebrow,
            style: context.text.label.copyWith(color: isDark ? secondary : colors.accentLabel),
          ),
          const SizedBox(height: AppSpace.s24),
          Expanded(child: child),
          const SizedBox(height: AppSpace.s16),
          Row(
            children: [
              AppIcon(
                icon: AppIcons.heart_filled,
                size: AppIconSize.xs,
                color: isDark ? secondary : colors.accentHighlight,
              ),
              const SizedBox(width: AppSpace.s6),
              Text(l10n.productMark, style: context.text.micro.copyWith(color: secondary)),
            ],
          ),
        ],
      ),
    );

    return SizedBox(
      width: shareCardWidth,
      height: shareCardHeight,
      child: isDark
          ? DecoratedBox(decoration: const BoxDecoration(gradient: _nightSky), child: content)
          : AppWashSurface(wash: AppWash.hero, child: content),
    );
  }
}

const LinearGradient _nightSky = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [AppPalette.neutral800, AppPalette.neutral900],
);

/// A hairline that separates two blocks inside a card.
class const ShareCardDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBorder.hair,
      child: ColoredBox(color: context.colors.borderDefault),
    );
  }
}
