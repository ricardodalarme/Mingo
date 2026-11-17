part of 'mood_calendar_cubit.dart';

/// The month of the person's own moods; no one else's day ever arrives here.
final class const MoodCalendarState({
  final Resource<List<MoodEntry>> entries = const Loading(),
  final DateTime? month,
}) with Equatable {
  /// The days of [month] that have a mood worth marking, without a time of day.
  Set<DateTime> get markedDays => switch (entries) {
    Success(:final value) => {
      for (final entry in value)
        if (entry.mood != null) DateTime(entry.day.year, entry.day.month, entry.day.day),
    },
    _ => const {},
  };

  bool get isEmpty => switch (entries) {
    Success(:final value) => value.isEmpty,
    _ => false,
  };

  MoodCalendarState copyWith({
    Resource<List<MoodEntry>>? entries,
    DateTime? month,
    bool clearMonth = false,
  }) {
    return MoodCalendarState(
      entries: entries ?? this.entries,
      month: clearMonth ? null : month ?? this.month,
    );
  }

  @override
  List<Object?> get props => [entries, month];
}
