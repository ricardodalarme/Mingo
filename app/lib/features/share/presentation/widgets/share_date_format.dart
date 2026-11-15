import 'package:app/l10n/translations.g.dart';

/// Dates written the way the image reads them, already in the person's language.
abstract final class ShareDateFormat() {
  static String long(Translations$share$pt l10n, DateTime date) => l10n.dateLine(
    day: date.day,
    month: l10n.monthsLong[(date.month - 1).clamp(0, 11)],
    year: date.year,
  );

  static String short(Translations$share$pt l10n, DateTime date) =>
      l10n.dateShort(day: date.day, month: l10n.monthsLong[(date.month - 1).clamp(0, 11)]);
}
