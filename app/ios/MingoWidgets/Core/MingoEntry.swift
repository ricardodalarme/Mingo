import SwiftUI
import WidgetKit

struct MingoEntry: TimelineEntry {
  let date: Date
  let payload: MingoPayload
}

/// How often the content of a widget goes stale on its own.
enum MingoRefresh {
  /// The widget shows a day count or a date, so it only changes at midnight.
  case daily
  /// The widget shows "2 hours ago" or a clock, so it changes through the day.
  case frequent
}

/// Reads the payload the app wrote and schedules the timeline entries a widget needs.
///
/// The widgets never reach the network: everything they show was already written by the app.
struct MingoProvider: TimelineProvider {
  let refresh: MingoRefresh

  func placeholder(in context: Context) -> MingoEntry {
    MingoEntry(date: Date(), payload: .sample)
  }

  func getSnapshot(in context: Context, completion: @escaping (MingoEntry) -> Void) {
    let payload = context.isPreview ? MingoPayload.sample : MingoPayload.load()
    completion(MingoEntry(date: Date(), payload: payload))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<MingoEntry>) -> Void) {
    let now = Date()
    let payload = MingoPayload.load()
    let calendar = Calendar.current
    let midnight = calendar.nextDate(
      after: now,
      matching: DateComponents(hour: 0, minute: 0),
      matchingPolicy: .nextTime
    ) ?? now.addingTimeInterval(86_400)

    var dates = [now]
    switch refresh {
    case .daily:
      dates.append(midnight)
    case .frequent:
      dates += (1...12).map { now.addingTimeInterval(Double($0) * 1_800) }
      if midnight > now { dates.append(midnight) }
    }
    let entries = dates.sorted().map { MingoEntry(date: $0, payload: payload) }
    completion(Timeline(entries: entries, policy: .after(entries.last?.date ?? midnight)))
  }
}

extension MingoPayload {
  /// Sample content for the widget gallery, never shown on a person's home screen.
  static var sample: MingoPayload {
    var payload = MingoPayload()
    payload.isSignedIn = true
    payload.isPaired = true
    payload.ownName = "Alex"
    payload.partnerName = "Sam"
    let calendar = Calendar.current
    let today = Date()
    func iso(_ days: Int) -> String {
      let date = calendar.date(byAdding: .day, value: days, to: today) ?? today
      let parts = calendar.dateComponents([.year, .month, .day], from: date)
      return String(format: "%04d-%02d-%02d", parts.year ?? 2026, parts.month ?? 1, parts.day ?? 1)
    }
    payload.togetherSince = iso(-969)
    payload.milestones = [
      Milestone(title: String(localized: .sampleMilestoneFirst), on: iso(-700)),
      Milestone(title: String(localized: .sampleMilestoneSecond), on: iso(-300)),
    ]
    payload.nextDateTitle = String(localized: .sampleDate)
    payload.nextDateOn = iso(12)
    payload.cardState = .ready
    payload.cardSendDay = 0
    payload.cardSendHour = 18
    payload.partnerNote = String(localized: .sampleNote)
    payload.partnerNoteAt = today.addingTimeInterval(-3_600)
    payload.partnerMood = .loving
    payload.partnerMoodAt = today.addingTimeInterval(-7_200)
    payload.ritualTitle = String(localized: .sampleRitual)
    payload.ritualWeekday = 7
    payload.ritualTime = "22:00"
    payload.dailyIdeaTitle = String(localized: .sampleIdea)
    payload.slipsThisWeek = 3
    payload.slipDays = [iso(0), iso(-2), iso(-3)]
    payload.ownZone = "America/Sao_Paulo"
    payload.partnerZone = "Europe/Lisbon"
    payload.reunionOn = iso(42)
    return payload
  }
}
