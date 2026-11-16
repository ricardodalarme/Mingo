import 'package:design_system/design_system.dart';

const double _previewRadius = AppRadius.sm;

/// A miniature of the app in one color: a screen with an accent line, a card and a dark action.
///
/// Decorative: the option that holds it carries the name.
class const ThemePreview({required final AppThemeVariant variant, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = AppColors.forVariant(variant);

    return ColoredBox(
      color: colors.bgScreen,
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.s8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: .55,
                child: SizedBox(
                  height: AppSpace.s6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.accentHighlight,
                      borderRadius: BorderRadius.circular(AppSpace.s2 + 1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.bgSurface,
                  borderRadius: BorderRadius.circular(_previewRadius),
                  border: Border.all(color: colors.borderDefault),
                ),
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            SizedBox(
              height: AppSpace.s10,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.actionPrimary,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
