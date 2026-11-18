import Foundation

/// The facts the app writes for the widgets: dates, zones and enum names, never display text.
///
/// The app is the only writer; this type only decodes. Unknown keys and values fall back to
/// safe defaults so an older extension keeps working against a newer app.
struct MingoPayload: Decodable, Equatable {
  enum Theme: String, Decodable {
    case rose, blue, neutral

    init(from decoder: Decoder) throws {
      let raw = try decoder.singleValueContainer().decode(String.self)
      self = Theme(rawValue: raw) ?? .rose
    }
  }

  enum CardState: String, Decodable {
    case none, ready, sent

    init(from decoder: Decoder) throws {
      let raw = try decoder.singleValueContainer().decode(String.self)
      self = CardState(rawValue: raw) ?? .none
    }
  }

  enum Mood: String, Decodable, CaseIterable {
    case happy, tired, sad, stressed, loving, playful
  }

  struct Milestone: Decodable, Equatable {
    let title: String
    let on: String
  }

  var isSignedIn = false
  var isPaired = false
  var theme: Theme = .rose
  var ownName: String?
  var partnerName: String?
  var togetherSince: String?
  var milestones: [Milestone] = []
  var nextDateTitle: String?
  var nextDateOn: String?
  var cardState: CardState = .none
  var cardSendDay: Int?
  var cardSendHour: Int?
  var partnerNote: String?
  var partnerNoteAt: Date?
  var partnerMood: Mood?
  var partnerMoodAt: Date?
  var partnerMissedAt: Date?
  var ritualTitle: String?
  var ritualWeekday: Int?
  var ritualTime: String?
  var dailyIdeaTitle: String?
  var slipsThisWeek = 0
  var slipDays: [String] = []
  var ownZone: String?
  var partnerZone: String?
  var reunionTitle: String?
  var reunionOn: String?

  private enum CodingKeys: String, CodingKey {
    case isSignedIn, isPaired, theme, ownName, partnerName, togetherSince, milestones
    case nextDateTitle, nextDateOn, cardState, cardSendDay, cardSendHour
    case partnerNote, partnerNoteAt, partnerMood, partnerMoodAt, partnerMissedAt
    case ritualTitle, ritualWeekday, ritualTime, dailyIdeaTitle, slipsThisWeek, slipDays
    case ownZone, partnerZone, reunionTitle, reunionOn
  }

  init() {}

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    isSignedIn = (try? values.decode(Bool.self, forKey: .isSignedIn)) ?? false
    isPaired = (try? values.decode(Bool.self, forKey: .isPaired)) ?? false
    theme = (try? values.decode(Theme.self, forKey: .theme)) ?? .rose
    ownName = Self.text(values, .ownName)
    partnerName = Self.text(values, .partnerName)
    togetherSince = Self.text(values, .togetherSince)
    milestones = (try? values.decode([Milestone].self, forKey: .milestones)) ?? []
    nextDateTitle = Self.text(values, .nextDateTitle)
    nextDateOn = Self.text(values, .nextDateOn)
    cardState = (try? values.decode(CardState.self, forKey: .cardState)) ?? .none
    cardSendDay = try? values.decode(Int.self, forKey: .cardSendDay)
    cardSendHour = try? values.decode(Int.self, forKey: .cardSendHour)
    partnerNote = Self.text(values, .partnerNote)
    partnerNoteAt = Self.instant(values, .partnerNoteAt)
    partnerMood = (try? values.decode(String.self, forKey: .partnerMood)).flatMap(Mood.init(rawValue:))
    partnerMoodAt = Self.instant(values, .partnerMoodAt)
    partnerMissedAt = Self.instant(values, .partnerMissedAt)
    ritualTitle = Self.text(values, .ritualTitle)
    ritualWeekday = try? values.decode(Int.self, forKey: .ritualWeekday)
    ritualTime = Self.text(values, .ritualTime)
    dailyIdeaTitle = Self.text(values, .dailyIdeaTitle)
    slipsThisWeek = (try? values.decode(Int.self, forKey: .slipsThisWeek)) ?? 0
    slipDays = (try? values.decode([String].self, forKey: .slipDays)) ?? []
    ownZone = Self.text(values, .ownZone)
    partnerZone = Self.text(values, .partnerZone)
    reunionTitle = Self.text(values, .reunionTitle)
    reunionOn = Self.text(values, .reunionOn)
  }

  private static func text(_ values: KeyedDecodingContainer<CodingKeys>, _ key: CodingKeys) -> String? {
    guard let value = try? values.decode(String.self, forKey: key) else { return nil }
    let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.isEmpty ? nil : trimmed
  }

  private static func instant(_ values: KeyedDecodingContainer<CodingKeys>, _ key: CodingKeys) -> Date? {
    guard let raw = text(values, key) else { return nil }
    return (try? Date(raw, strategy: .iso8601)) ?? (try? Date(raw, strategy: Self.fractionalISO8601))
  }

  private static let fractionalISO8601 = Date.ISO8601FormatStyle(includingFractionalSeconds: true)
}

extension MingoPayload {
  static let appGroupId = "group.dev.dalarme.mingo"
  static let storageKey = "mingo_widget_payload"

  /// The payload the app last wrote, or the signed-out one when there is none.
  static func load() -> MingoPayload {
    guard
      let defaults = UserDefaults(suiteName: appGroupId),
      let raw = defaults.string(forKey: storageKey),
      let data = raw.data(using: .utf8),
      let payload = try? JSONDecoder().decode(MingoPayload.self, from: data)
    else { return MingoPayload() }
    return payload
  }

  /// Whole days from `date` to the later `now`, counting local midnights.
  func daysTogether(on now: Date) -> Int? {
    guard isSignedIn, let start = Self.localDate(togetherSince) else { return nil }
    return max(0, Self.calendar.dateComponents([.day], from: start, to: Self.calendar.startOfDay(for: now)).day ?? 0)
  }

  /// Years, months and days since the couple's start date.
  func durationTogether(on now: Date) -> DateComponents? {
    guard isSignedIn, let start = Self.localDate(togetherSince), start <= now else { return nil }
    return Self.calendar.dateComponents([.year, .month, .day], from: start, to: Self.calendar.startOfDay(for: now))
  }

  /// Calendar days until the next important date, or nil when none is upcoming.
  func daysUntilNextDate(on now: Date) -> Int? {
    Self.days(until: nextDateOn, from: now)
  }

  /// Calendar days until the couple meets again, or nil when no reunion is planned.
  func daysUntilReunion(on now: Date) -> Int? {
    Self.days(until: reunionOn, from: now)
  }

  var nextDate: Date? { Self.localDate(nextDateOn) }

  /// The weekdays (1 = Monday ... 7 = Sunday) of this week's slips, one entry per slip.
  var slipWeekdays: [Int] {
    slipDays.compactMap { Self.localDate($0) }.map { Self.isoWeekday(of: $0) }
  }

  /// The next time the weekly ritual happens, from `now`.
  func nextRitual(after now: Date) -> Date? {
    guard let weekday = ritualWeekday, let time = ritualTime else { return nil }
    let parts = time.split(separator: ":").compactMap { Int($0) }
    guard parts.count >= 2 else { return nil }
    var components = DateComponents(hour: parts[0], minute: parts[1])
    components.weekday = weekday % 7 + 1
    return Self.calendar.nextDate(
      after: now.addingTimeInterval(-60),
      matching: components,
      matchingPolicy: .nextTime
    )
  }

  /// The next time the Sunday card goes out, from `now`.
  func nextCardSend(after now: Date) -> Date? {
    guard let day = cardSendDay, let hour = cardSendHour else { return nil }
    var components = DateComponents(hour: hour, minute: 0)
    components.weekday = day % 7 + 1
    return Self.calendar.nextDate(
      after: now.addingTimeInterval(-60),
      matching: components,
      matchingPolicy: .nextTime
    )
  }

  static var calendar: Calendar { Calendar.current }

  /// A `yyyy-MM-dd` string as local midnight, or nil.
  static func localDate(_ raw: String?) -> Date? {
    guard let raw else { return nil }
    let parts = raw.prefix(10).split(separator: "-").compactMap { Int($0) }
    guard parts.count == 3 else { return nil }
    return calendar.date(from: DateComponents(year: parts[0], month: parts[1], day: parts[2]))
  }

  static func isoWeekday(of date: Date) -> Int {
    (calendar.component(.weekday, from: date) + 5) % 7 + 1
  }

  private static func days(until raw: String?, from now: Date) -> Int? {
    guard let target = localDate(raw) else { return nil }
    let days = calendar.dateComponents([.day], from: calendar.startOfDay(for: now), to: target).day ?? -1
    return days >= 0 ? days : nil
  }
}
