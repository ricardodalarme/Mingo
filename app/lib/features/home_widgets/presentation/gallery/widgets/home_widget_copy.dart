import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:design_system/design_system.dart';
import 'package:formatters/formatters.dart';

/// The text the home widget previews show, formatted in the app language.
extension HomeWidgetCopy on BuildContext {
  String get _locale => LocaleSettings.currentLocale.languageCode;

  /// "2 years, 7 months and 25 days", leaving out the units that are zero.
  String durationText({required int years, required int months, required int days}) {
    final l10n = this.l10n.homeWidgets;
    final parts = [
      if (years > 0) l10n.durationYears(count: years),
      if (months > 0) l10n.durationMonths(count: months),
      if (days > 0 || (years == 0 && months == 0)) l10n.durationDays(count: days),
    ];
    if (parts.length < 2) return parts.join();

    return '${parts.sublist(0, parts.length - 1).join(', ')} ${l10n.durationAnd} ${parts.last}';
  }

  /// "2 hours ago" for [then] seen from [now].
  String agoText(DateTime then, DateTime now) {
    final l10n = this.l10n.homeWidgets;
    final difference = now.difference(then);
    if (difference.inMinutes < 1) return l10n.agoNow;
    if (difference.inMinutes < 60) return l10n.agoMinutes(count: difference.inMinutes);
    if (difference.inHours < 24) return l10n.agoHours(count: difference.inHours);

    return l10n.agoDays(count: difference.inDays);
  }

  /// The abbreviated weekday without the trailing period some languages add.
  String weekdayShort(DateTime date) =>
      DateFormatters.custom(date, 'EEE', locale: _locale).replaceAll('.', '');

  /// The abbreviated month without the trailing period some languages add.
  String monthShort(DateTime date) =>
      DateFormatters.custom(date, 'MMM', locale: _locale).replaceAll('.', '');

  String clock(DateTime date) => DateFormatters.custom(date, 'HH:mm', locale: _locale);

  /// The time a note arrived: the clock when it is today, the short date otherwise.
  String arrivedText(DateTime at, DateTime now) {
    final isToday = at.year == now.year && at.month == now.month && at.day == now.day;

    return isToday ? clock(at) : DateFormatters.custom(at, 'd MMM', locale: _locale);
  }

  String moodName(MoodKind mood) => l10n.mood.moods.selectOrFallback(mood.name);

  /// The next occurrence of a weekly moment, as "today, 22:00" or "Sun, 10:00".
  ///
  /// [weekday] runs 1 (Monday) to 7 (Sunday), [time] is `HH:mm`.
  String whenText({required int weekday, required String time, required DateTime now}) {
    final l10n = this.l10n.homeWidgets;
    final ahead = (weekday - now.weekday) % 7;
    if (ahead == 0) return l10n.ritualToday(time: time);
    if (ahead == 1) return l10n.ritualTomorrow(time: time);
    final day = weekdayShort(DateTime(now.year, now.month, now.day + ahead));

    return l10n.ritualOn(day: day, time: time);
  }
}
