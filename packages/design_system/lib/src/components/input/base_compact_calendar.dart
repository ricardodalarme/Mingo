import 'package:clock/clock.dart';
import 'package:design_system/design_system.dart';
import 'package:design_system/design_system_l10n.dart';

const double _gap = 6;

/// A month overview in small round cells, with no month arrows and a marker on days that have something.
///
/// A tap on a day reports it through [onDayTap]. [markerBuilder] can draw a face or dot inside a marked
/// day. For picking dates use [BaseCalendarGrid].
class const BaseCompactCalendar({
  required final DateTime month,
  final Set<DateTime> marked = const {},
  final DateTime? today,
  final BaseCalendarWeekStart weekStart = .sunday,
  final ValueChanged<DateTime>? onDayTap,
  final Widget? Function(DateTime day)? markerBuilder,
  super.key,
}) extends StatelessWidget {
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase.input.calendar;
    final now = today ?? clock.now();
    final first = DateTime(month.year, month.month);
    final daysInMonth = DateTime(first.year, first.month + 1, 0).day;
    final offset = weekStart == .sunday ? first.weekday % 7 : (first.weekday - 1) % 7;
    final rows = (offset + daysInMonth + 6) ~/ 7;
    final weekdays = weekStart == .sunday
        ? l10n.weekdays
        : [...l10n.weekdays.skip(1), l10n.weekdays.first];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cell = (constraints.maxWidth - _gap * 6) / 7;

        return Column(
          mainAxisSize: MainAxisSize.min,
          spacing: _gap,
          children: [
            ExcludeSemantics(
              child: Row(
                spacing: _gap,
                children: [
                  for (final label in weekdays)
                    SizedBox(
                      width: cell,
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: context.text.micro.copyWith(color: colors.textPlaceholder),
                      ),
                    ),
                ],
              ),
            ),
            for (var row = 0; row < rows; row++)
              Row(
                spacing: _gap,
                children: [
                  for (var column = 0; column < 7; column++)
                    _cell(
                      context,
                      size: cell,
                      day: row * 7 + column - offset + 1,
                      daysInMonth: daysInMonth,
                      today: now,
                    ),
                ],
              ),
          ],
        );
      },
    );
  }

  Widget _cell(
    BuildContext context, {
    required double size,
    required int day,
    required int daysInMonth,
    required DateTime today,
  }) {
    if (day < 1 || day > daysInMonth) return SizedBox(width: size, height: size);

    final colors = context.colors;
    final l10n = context.designSystemL10nOrBase.input.calendar;
    final date = DateTime(month.year, month.month, day);
    final isMarked = marked.any((value) => _isSameDay(value, date));
    final isToday = _isSameDay(date, today);
    final marker = isMarked ? markerBuilder?.call(date) : null;

    final base = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isMarked ? colors.accentSoft : colors.bgSurface,
        shape: BoxShape.circle,
        border: isMarked || isToday ? null : AppBorders.hair(colors.borderDefault),
      ),
      child:
          marker ??
          Text(
            '$day',
            style: context.text.micro.copyWith(
              fontSize: 13,
              fontWeight: isMarked ? FontWeight.w600 : FontWeight.w500,
              color: isMarked ? colors.accentLabel : colors.textPrimary,
            ),
          ),
    );

    final circle = isToday
        ? CustomPaint(
            foregroundPainter: DashedRoundedPainter(
              color: colors.accentHighlight,
              radius: size / 2,
            ),
            child: base,
          )
        : base;

    final label = [
      l10n.date(day: day, month: l10n.months[date.month - 1], year: date.year),
      if (isToday) l10n.today,
      if (isMarked) l10n.hasEntry,
    ].join(', ');

    if (onDayTap == null) {
      return Semantics(
        label: label,
        child: ExcludeSemantics(child: circle),
      );
    }

    return AppPressable(
      onTap: () => onDayTap!(date),
      semanticLabel: label,
      borderRadius: BorderRadius.circular(size),
      child: ExcludeSemantics(child: circle),
    );
  }
}
