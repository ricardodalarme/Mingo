import 'package:equatable/equatable.dart';

/// The week's numbers, counted by the backend from the person's own data; never scored or compared.
final class const WeeklyReview({
  required final DateTime weekStart,
  required final int slips,
  required final int moodDays,
  required final int rituals,
  required final bool isQuiet,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => WeeklyReview(
    weekStart: DateTime(2026, 11, 2),
    slips: 5,
    moodDays: 4,
    rituals: 2,
    isQuiet: false,
  );

  /// The last day of the week, a Sunday.
  DateTime get weekEnd => weekStart.add(const Duration(days: 6));

  @override
  List<Object?> get props => [weekStart, slips, moodDays, rituals, isQuiet];
}
