import 'package:app/features/home_widgets/data/models/home_widget_kind.dart';
import 'package:app/features/home_widgets/data/models/home_widget_payload.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_copy.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_frame.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_palette.dart';
import 'package:app/features/home_widgets/presentation/gallery/widgets/home_widget_text.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';

/// The person's own week: a bar for each weekday that holds slips.
class const WeekPreview({
  required final HomeWidgetPayload payload,
  required final DateTime now,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.homeWidgets;
    final palette = HomeWidgetPalette.of(payload.theme);
    final monday = DateTime(now.year, now.month, now.day - (now.weekday - 1));
    final perDay = <int, int>{};
    for (final raw in payload.slipDays) {
      final date = DateTime.tryParse(raw);
      if (date != null) perDay.update(date.weekday, (count) => count + 1, ifAbsent: () => 1);
    }

    return HomeWidgetFrame(
      size: HomeWidgetSize.medium,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: AppPalette.white,
        border: Border.all(color: palette.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              HomeWidgetEyebrow(text: l10n.weekEyebrow, color: palette.label),
              HomeWidgetText(
                text: l10n.weekCount(count: payload.slipsThisWeek),
                size: 13,
                color: context.colors.textSecondary,
                maxLines: 1,
              ),
            ],
          ),
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var day = 1; day <= 7; day++) ...[
                  if (day > 1) const SizedBox(width: 10),
                  Expanded(
                    child: _Bar(
                      count: perDay[day] ?? 0,
                      label: context.weekdayShort(monday.add(Duration(days: day - 1))),
                      palette: palette,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _Bar({
  required final int count,
  required final String label,
  required final HomeWidgetPalette palette,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isActive = count > 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: isActive ? 16.0 + 10 * count.clamp(1, 3) : 14,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: isActive ? null : palette.soft,
            gradient: isActive
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [palette.tintEnd, palette.highlight],
                  )
                : null,
          ),
        ),
        const SizedBox(height: 6),
        HomeWidgetText(
          text: label,
          size: 11.5,
          weight: isActive ? FontWeight.w600 : FontWeight.w400,
          color: isActive ? palette.label : context.colors.textSecondary,
          maxLines: 1,
          align: TextAlign.center,
        ),
      ],
    );
  }
}
