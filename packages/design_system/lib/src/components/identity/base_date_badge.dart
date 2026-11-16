import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

const double _width = 54;
const double _tilt = 3;
const double _monthPadding = 3;

/// A small calendar tile: a month strip over the day number.
///
/// Display only; the row or card that holds it is the touch target and reads the full date, so the
/// badge is hidden from screen readers. [isPast] mutes it, [isTilted] gives it the 3° lean and should
/// be turned off when several badges stack.
class const BaseDateBadge({
  required final DateTime date,
  final bool isTilted = true,
  final bool isPast = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final months = context.designSystemL10nOrBase.input.calendar.months;
    final month = months[date.month - 1];
    final monthLabel = (month.length > 3 ? month.substring(0, 3) : month).toUpperCase();

    final badge = Container(
      width: _width,
      decoration: BoxDecoration(
        color: isPast ? AppPalette.neutral100 : colors.bgSurface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: AppBorders.hair(colors.borderDefault),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: _monthPadding),
            color: isPast ? AppPalette.neutral400 : colors.accentHighlight,
            child: Text(
              monthLabel,
              textAlign: TextAlign.center,
              style: context.text.micro.copyWith(
                fontSize: 10,
                height: 1.2,
                fontWeight: FontWeight.w600,
                letterSpacing: .06 * 10,
                color: colors.textOnAction,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpace.s6, bottom: 7),
            child: Text(
              date.day.toString().padLeft(2, '0'),
              style: context.text.titleSm.copyWith(
                fontSize: 20,
                height: 1.1,
                fontWeight: FontWeight.w600,
                color: isPast ? AppPalette.neutral600 : colors.textPrimary,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );

    return ExcludeSemantics(
      child: Align(
        alignment: Alignment.topLeft,
        widthFactor: 1,
        heightFactor: 1,
        child: isTilted
            ? Transform.rotate(angle: -_tilt * 3.1415926535897932 / 180, child: badge)
            : badge,
      ),
    );
  }
}
