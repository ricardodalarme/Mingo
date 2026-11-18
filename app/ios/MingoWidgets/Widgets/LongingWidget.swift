import SwiftUI
import WidgetKit

/// The one-tap "missing you" widget, or the missing the partner just sent.
struct MingoLongingView: View {
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry, needsPartner: true) {
      let payload = entry.payload
      let palette = MingoPalette.of(payload.theme)
      MingoShell(link: .today) {
        RadialGradient(
          colors: [palette.mist, palette.soft.opacity(0.7), .white], center: .center,
          startRadius: 0, endRadius: 150)
      } content: {
        VStack(spacing: 10) {
          ZStack {
            Circle().stroke(palette.highlight.opacity(0.25), lineWidth: 2).frame(width: 90, height: 90)
            Circle().stroke(palette.highlight.opacity(0.4), lineWidth: 2).frame(width: 62, height: 62)
            Image(systemName: "heart.fill")
              .font(.system(size: 26))
              .foregroundStyle(.white)
              .frame(width: 54, height: 54)
              .background(palette.highlight, in: Circle())
          }
          .frame(width: 90, height: 90)
          VStack(spacing: 1) {
            Text(payload.partnerMissedAt == nil ? .longingAction : .longingReceived)
              .mingoFont(14.5, .semibold)
              .multilineTextAlignment(.center)
              .lineLimit(2)
            if let missed = payload.partnerMissedAt {
              Text(verbatim: MingoFormat.ago(missed, now: entry.date)).mingoFont(12).opacity(0.75)
            }
          }
        }
        .foregroundStyle(palette.ink)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}

struct MingoLongingWidget: Widget {
  let kind = "MingoLongingWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .frequent)) { entry in
      MingoLongingView(entry: entry)
    }
    .configurationDisplayName(.widgetLongingName)
    .description(.widgetLongingDescription)
    .supportedFamilies([.systemSmall])
    .contentMarginsDisabled()
  }
}
