import Foundation

/// Formats what the widgets show in the system language, with the system formatters.
enum MingoFormat {
  /// "2 hours ago", relative to `now`.
  static func ago(_ date: Date, now: Date) -> String {
    let formatter = RelativeDateTimeFormatter()
    formatter.unitsStyle = .full
    formatter.dateTimeStyle = .numeric
    return formatter.localizedString(for: min(date, now), relativeTo: now)
  }

  /// "2 years, 7 months and 25 days", leaving out the units that are zero.
  static func duration(_ components: DateComponents) -> String? {
    let formatter = DateComponentsFormatter()
    formatter.allowedUnits = [.year, .month, .day]
    formatter.unitsStyle = .full
    formatter.zeroFormattingBehavior = .dropAll
    formatter.maximumUnitCount = 3
    let text = formatter.string(from: components)
    return text?.isEmpty == false ? text : nil
  }

  /// The abbreviated weekday, such as "mon" or "seg", without the period some languages add.
  static func weekdayShort(_ date: Date) -> String {
    date.formatted(.dateTime.weekday(.abbreviated)).replacingOccurrences(of: ".", with: "")
  }

  /// The abbreviated month, such as "nov", without the period some languages add.
  static func monthShort(_ date: Date) -> String {
    date.formatted(.dateTime.month(.abbreviated)).replacingOccurrences(of: ".", with: "")
  }

  /// The time of day in the system's 12 or 24 hour style.
  static func clock(_ date: Date, in zone: TimeZone = .current) -> String {
    var style = Date.FormatStyle(date: .omitted, time: .shortened)
    style.timeZone = zone
    return date.formatted(style)
  }

  /// "today, 22:00", "tomorrow, 22:00" or "sun, 22:00" for the next time something happens.
  static func when(_ date: Date, now: Date) -> String {
    let calendar = Calendar.current
    let time = clock(date)
    if calendar.isDate(date, inSameDayAs: now) {
      return String(localized: .whenToday(time))
    }
    if let tomorrow = calendar.date(byAdding: .day, value: 1, to: now), calendar.isDate(date, inSameDayAs: tomorrow) {
      return String(localized: .whenTomorrow(time))
    }
    return String(localized: .whenWeekday(weekdayShort(date), time))
  }

  /// The time a note arrived: the clock when it came today, the short date otherwise.
  static func arrived(_ date: Date, now: Date) -> String {
    if Calendar.current.isDate(date, inSameDayAs: now) { return clock(date) }
    return date.formatted(.dateTime.day().month(.abbreviated)).replacingOccurrences(of: ".", with: "")
  }

  /// The city part of an IANA zone name: `America/Sao_Paulo` becomes `Sao Paulo`.
  static func city(_ zone: String) -> String {
    zone.split(separator: "/").last.map { $0.replacingOccurrences(of: "_", with: " ") } ?? zone
  }
}

extension MingoFormat {
  /// The word for a count of days, singular only for exactly one.
  static func dayUnit(_ days: Int) -> LocalizedStringResource {
    days == 1 ? .counterUnitOne : .counterUnitOther
  }

  /// "days until you meet" in the right number.
  static func untilMeeting(_ days: Int) -> LocalizedStringResource {
    days == 1 ? .distanceUntilOne : .distanceUntilOther
  }
}
