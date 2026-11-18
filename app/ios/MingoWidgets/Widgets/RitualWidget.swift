import SwiftUI
import WidgetKit

/// The ritual the couple keeps, on a night sky, with when it comes next.
struct MingoRitualView: View {
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry) {
      let payload = entry.payload
      MingoShell(link: .rituals) {
        ZStack(alignment: .topTrailing) {
          LinearGradient(
            colors: [MingoPalette.nightStart, MingoPalette.nightMiddle, MingoPalette.nightEnd],
            startPoint: UnitPoint(x: 0.35, y: 0), endPoint: UnitPoint(x: 0.65, y: 1))
          Image(systemName: "moon.stars.fill")
            .font(.system(size: 46))
            .foregroundStyle(.white.opacity(0.9))
            .padding(14)
            .accessibilityHidden(true)
        }
      } content: {
        VStack(alignment: .leading, spacing: 0) {
          MingoEyebrow(text: .ritualEyebrow, color: .white)
          Spacer(minLength: 4)
          if let title = payload.ritualTitle {
            Text(verbatim: title).mingoFont(21, .semibold).tracking(-0.4).lineLimit(3).minimumScaleFactor(0.8)
            if let next = payload.nextRitual(after: entry.date) {
              Text(verbatim: MingoFormat.when(next, now: entry.date)).mingoFont(12.5).opacity(0.8).padding(.top, 6)
            }
          } else {
            Text(.ritualEmptyTitle).mingoFont(21, .semibold).tracking(-0.4).lineLimit(3)
            Text(.ritualEmptyHint).mingoFont(12.5).opacity(0.8).padding(.top, 6)
          }
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 15)
      }
    }
  }
}

struct MingoRitualWidget: Widget {
  let kind = "MingoRitualWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .daily)) { entry in
      MingoRitualView(entry: entry)
    }
    .configurationDisplayName(.widgetRitualName)
    .description(.widgetRitualDescription)
    .supportedFamilies([.systemSmall])
    .contentMarginsDisabled()
  }
}
