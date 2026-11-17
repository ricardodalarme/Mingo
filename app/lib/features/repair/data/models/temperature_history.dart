import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:equatable/equatable.dart';

/// How many weeks the history covers.
const int temperatureHistoryWeeks = 8;

/// How long a fight answer keeps the app in conflict mode.
const Duration conflictWindow = Duration(hours: 24);

/// One private temperature answer.
final class const TemperatureCheck({required final Temperature level, required final DateTime at})
    with Equatable {
  @override
  List<Object?> get props => [level, at];
}

/// The week starting on [start] (a Monday), summed up by its last answer, if there was one.
final class const TemperatureWeek({required final DateTime start, final Temperature? level})
    with Equatable {
  @override
  List<Object?> get props => [start, level];
}

/// The last [temperatureHistoryWeeks] weeks, oldest first, ending with the week of [now].
///
/// A week shows the last answer given in it; a week without answers has no level.
List<TemperatureWeek> temperatureWeeks(List<TemperatureCheck> checks, {required DateTime now}) {
  final today = DateTime(now.year, now.month, now.day);
  final thisMonday = today.subtract(Duration(days: today.weekday - DateTime.monday));

  return [
    for (var index = temperatureHistoryWeeks - 1; index >= 0; index--)
      () {
        final start = DateTime(thisMonday.year, thisMonday.month, thisMonday.day - 7 * index);
        final end = DateTime(start.year, start.month, start.day + 7);
        final inWeek = checks.where((check) => !check.at.isBefore(start) && check.at.isBefore(end));
        final last = inWeek.isEmpty ? null : inWeek.reduce((a, b) => b.at.isAfter(a.at) ? b : a);

        return TemperatureWeek(start: start, level: last?.level);
      }(),
  ];
}
