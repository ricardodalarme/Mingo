import 'package:design_system/design_system.dart';

/// The density of a [BaseStat].
enum BaseStatSize() {
  /// A card for a row of three, number type.title.sm 20.
  compact,

  /// A roomier card with a 26 number.
  large,

  /// The number alone, type.display, outside a card.
  hero,
}

const double _rowGap = 8;
const String _missing = '—';

/// A number with a short caption.
///
/// It never carries a trend, a rank or a comparison. A null [value] renders an em dash, never 0.
/// Read as one item, such as "969 days".
class const BaseStat({
  required final String? value,
  required final String caption,
  final BaseStatSize size = .compact,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isHero = size == .hero;
    final numberStyle = switch (size) {
      .compact => context.text.titleSm.copyWith(fontWeight: FontWeight.w600, fontSize: 20),
      .large => context.text.titleSm.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 26,
        height: 1.15,
      ),
      .hero => context.text.display,
    }.copyWith(color: colors.textPrimary, fontFeatures: const [FontFeature.tabularFigures()]);
    final captionStyle = context.text.caption.copyWith(
      fontSize: size == .compact ? 12.5 : null,
      color: colors.textSecondary,
    );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value ?? _missing, style: numberStyle),
        Text(caption, style: captionStyle),
      ],
    );

    return Semantics(
      container: true,
      label: '${value ?? _missing} $caption',
      child: ExcludeSemantics(
        child: isHero
            ? content
            : Container(
                width: double.infinity,
                padding: size == .compact
                    ? const EdgeInsets.symmetric(horizontal: AppSpace.s12, vertical: AppSpace.s10)
                    : const EdgeInsets.all(AppSpace.s16),
                decoration: BoxDecoration(
                  color: colors.bgSurface,
                  borderRadius: BorderRadius.circular(size == .compact ? AppRadius.xl : 22),
                  border: AppBorders.hair(colors.borderDefault),
                ),
                child: content,
              ),
      ),
    );
  }
}

/// Lays [children], usually three compact [BaseStat]s, in equal columns.
class const BaseStatRow({required final List<Widget> children, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: _rowGap,
        children: [for (final child in children) Expanded(child: child)],
      ),
    );
  }
}
