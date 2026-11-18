import SwiftUI
import WidgetKit

/// The one-tap shortcut to log a slip.
struct MingoSlipView: View {
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry) {
      let palette = MingoPalette.of(entry.payload.theme)
      MingoShell(link: .capture) {
        LinearGradient(
          colors: [MingoPalette.charcoal, MingoPalette.plum],
          startPoint: UnitPoint(x: 0.3, y: 0), endPoint: UnitPoint(x: 0.7, y: 1))
      } content: {
        VStack(alignment: .leading, spacing: 0) {
          Text(.slipPrompt)
            .mingoHand(25)
            .lineSpacing(0)
            .opacity(0.95)
          Spacer(minLength: 4)
          HStack(spacing: 14) {
            Image(systemName: "plus")
              .font(.system(size: 22, weight: .bold))
              .foregroundStyle(.white)
              .frame(width: 54, height: 54)
              .background(palette.highlight, in: Circle())
              .overlay(Circle().stroke(palette.highlight.opacity(0.25), lineWidth: 8))
              .shadow(color: palette.highlight.opacity(0.6), radius: 14)
            Text(.slipAction).mingoFont(13).opacity(0.8).lineLimit(2)
          }
        }
        .foregroundStyle(.white)
        .padding(16)
      }
    }
  }
}

struct MingoSlipWidget: Widget {
  let kind = "MingoSlipWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .daily)) { entry in
      MingoSlipView(entry: entry)
    }
    .configurationDisplayName(.widgetSlipName)
    .description(.widgetSlipDescription)
    .supportedFamilies([.systemSmall])
    .contentMarginsDisabled()
  }
}
