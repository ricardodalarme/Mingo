import SwiftUI
import WidgetKit

/// The idea of the day.
struct MingoIdeaView: View {
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry) {
      let palette = MingoPalette.of(entry.payload.theme)
      MingoShell(link: .today) {
        LinearGradient(colors: [MingoPalette.cream, palette.soft], startPoint: .leading, endPoint: .trailing)
      } content: {
        HStack(spacing: 16) {
          Image(systemName: "lightbulb.fill")
            .font(.system(size: 34))
            .foregroundStyle(palette.highlight)
            .frame(width: 78, height: 78)
            .background(.white, in: RoundedRectangle(cornerRadius: 26))
            .shadow(color: palette.label.opacity(0.3), radius: 10, y: 6)
          VStack(alignment: .leading, spacing: 0) {
            MingoEyebrow(text: .ideaEyebrow, color: palette.ink)
            if let title = entry.payload.dailyIdeaTitle {
              Text(verbatim: title).mingoFont(18, .semibold).tracking(-0.4).lineLimit(3).minimumScaleFactor(0.8)
                .padding(.top, 6)
            } else {
              Text(.ideaEmpty).mingoFont(18, .semibold).padding(.top, 6)
            }
            Text(.ideaHint).mingoFont(12.5).opacity(0.8).padding(.top, 4)
          }
        }
        .foregroundStyle(palette.ink)
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
      }
    }
  }
}

struct MingoIdeaWidget: Widget {
  let kind = "MingoIdeaWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .daily)) { entry in
      MingoIdeaView(entry: entry)
    }
    .configurationDisplayName(.widgetIdeaName)
    .description(.widgetIdeaDescription)
    .supportedFamilies([.systemMedium])
    .contentMarginsDisabled()
  }
}
