import 'package:equatable/equatable.dart';

/// A day the person marked as sensitive; private to them.
final class const SensitiveDay({required final DateTime day}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => SensitiveDay(day: DateTime(2026, 11, 15));

  @override
  List<Object?> get props => [day];
}

/// The person's marked days and the server's local day, which the switch acts on.
final class const SensitiveDays({
  required final DateTime today,
  required final List<SensitiveDay> days,
}) with Equatable {
  /// A skeleton placeholder with the shape of a real month.
  factory fake() => SensitiveDays(today: DateTime(2026, 11, 15), days: [SensitiveDay.fake()]);

  bool get isTodayMarked => isMarked(today);

  Set<DateTime> get markedDays => {for (final day in days) day.day};

  bool isMarked(DateTime day) => days.any((marked) => _isSameDay(marked.day, day));

  /// The same days with [day] marked when it was not, or dropped when it was.
  SensitiveDays withToggled(DateTime day) => SensitiveDays(
    today: today,
    days: isMarked(day)
        ? [
            for (final marked in days)
              if (!_isSameDay(marked.day, day)) marked,
          ]
        : [...days, SensitiveDay(day: day)],
  );

  @override
  List<Object?> get props => [today, days];

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
