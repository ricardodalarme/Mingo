import SwiftUI
import WidgetKit

/// The mood the partner chose to share, or the honest note that none is shared.
struct MingoPartnerMoodView: View {
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry, needsPartner: true) {
      let payload = entry.payload
      let palette = MingoPalette.of(payload.theme)
      MingoShell(link: .today) {
        ZStack(alignment: .topTrailing) {
          RadialGradient(
            colors: [palette.mist, palette.soft, .white], center: UnitPoint(x: 0.8, y: 0.2),
            startRadius: 0, endRadius: 190)
          Circle().fill(.white.opacity(0.5)).frame(width: 90, height: 90).offset(x: 34, y: -32)
        }
      } content: {
        VStack(alignment: .leading, spacing: 0) {
          if let mood = payload.partnerMood {
            MingoEyebrow(text: eyebrow(payload), color: palette.ink)
            Spacer(minLength: 4)
            MingoMoodFace(mood: mood, color: palette.highlight, size: 46)
              .frame(width: 64, height: 64)
              .background(.white, in: Circle())
            Spacer(minLength: 4)
            Text(mood.name).mingoFont(17, .semibold).lineLimit(1)
            if let at = payload.partnerMoodAt {
              Text(verbatim: MingoFormat.ago(at, now: entry.date)).mingoFont(12.5).opacity(0.75).lineLimit(1)
            }
          } else {
            MingoEyebrow(text: .moodNowAnonymous, color: palette.ink)
            Spacer(minLength: 4)
            Text(.moodHidden).mingoFont(13).opacity(0.8)
          }
        }
        .foregroundStyle(palette.ink)
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
      }
    }
  }

  private func eyebrow(_ payload: MingoPayload) -> LocalizedStringResource {
    guard let name = payload.partnerName else { return .moodNowAnonymous }
    return .moodNow(name)
  }
}

struct MingoPartnerMoodWidget: Widget {
  let kind = "MingoPartnerMoodWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .frequent)) { entry in
      MingoPartnerMoodView(entry: entry)
    }
    .configurationDisplayName(.widgetPartnerMoodName)
    .description(.widgetPartnerMoodDescription)
    .supportedFamilies([.systemSmall])
    .contentMarginsDisabled()
  }
}
