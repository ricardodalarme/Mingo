import SwiftUI
import WidgetKit

/// Days until the next important date, as a ring when small and a headline when medium.
struct MingoNextDateView: View {
  @Environment(\.widgetFamily) private var family
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry) {
      let payload = entry.payload
      let palette = MingoPalette.of(payload.theme)
      if let days = payload.daysUntilNextDate(on: entry.date) {
        if family == .systemMedium {
          medium(days: days, title: payload.nextDateTitle)
        } else {
          small(days: days, title: payload.nextDateTitle, palette: palette)
        }
      } else {
        empty(palette: palette)
      }
    }
  }

  private func small(days: Int, title: String?, palette: MingoPalette) -> some View {
    MingoShell(link: .dates) {
      ZStack {
        MingoPalette.surface
        Circle().fill(MingoPalette.confettiYellow).frame(width: 8, height: 8).offset(x: -70, y: -68)
        RoundedRectangle(cornerRadius: 2).fill(MingoPalette.confettiBlue).frame(width: 6, height: 6)
          .rotationEffect(.degrees(30)).offset(x: 62, y: -56)
        RoundedRectangle(cornerRadius: 2).fill(palette.highlight).frame(width: 6, height: 6).offset(x: -60, y: 60)
      }
    } content: {
      VStack(spacing: 6) {
        ZStack {
          Circle().stroke(palette.soft, lineWidth: 9)
          Circle()
            .trim(from: 0, to: max(0.06, min(1, 1 - Double(days) / 30)))
            .stroke(palette.highlight, style: StrokeStyle(lineWidth: 9, lineCap: .round))
            .rotationEffect(.degrees(-90))
          VStack(spacing: 0) {
            Text(verbatim: String(days)).font(.system(size: 34, weight: .semibold)).tracking(-1.4)
            Text(MingoFormat.dayUnit(days)).mingoFont(12).foregroundStyle(MingoPalette.textSecondary)
          }
          .foregroundStyle(MingoPalette.textPrimary)
        }
        .frame(width: 96, height: 96)
        if let title {
          Text(verbatim: title).mingoFont(12.5, .medium).foregroundStyle(MingoPalette.textPrimary).lineLimit(1)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(14)
    }
  }

  private func medium(days: Int, title: String?) -> some View {
    MingoShell(link: .dates) {
      LinearGradient(colors: [MingoPalette.sky, Color(hex: 0xFBE3E9)], startPoint: .leading, endPoint: .trailing)
    } content: {
      HStack {
        VStack(alignment: .leading, spacing: 0) {
          MingoEyebrow(text: .nextDateEyebrow, color: MingoPalette.skyInk)
          HStack(alignment: .firstTextBaseline, spacing: 6) {
            Text(verbatim: String(days)).font(.system(size: 52, weight: .semibold)).tracking(-2.6)
            Text(MingoFormat.dayUnit(days)).mingoFont(20)
          }
          .padding(.top, 6)
          if let title {
            Text(verbatim: title).mingoFont(13).opacity(0.8).lineLimit(1).padding(.top, 4)
          }
        }
        Spacer(minLength: 4)
        Image(systemName: "calendar")
          .font(.system(size: 48, weight: .light))
          .foregroundStyle(Color(hex: 0xE8577A))
      }
      .foregroundStyle(MingoPalette.skyInk)
      .padding(.horizontal, 18)
      .padding(.vertical, 16)
    }
  }

  private func empty(palette: MingoPalette) -> some View {
    MingoShell(link: .dates) {
      MingoPalette.surface
    } content: {
      VStack(alignment: .leading, spacing: 0) {
        MingoEyebrow(text: .nextDateEyebrow, color: palette.label, opacity: 1)
        Spacer(minLength: 4)
        Text(.nextDateEmpty).mingoFont(17, .semibold).foregroundStyle(MingoPalette.textPrimary)
      }
      .padding(16)
    }
  }
}

struct MingoNextDateWidget: Widget {
  let kind = "MingoNextDateWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .daily)) { entry in
      MingoNextDateView(entry: entry)
    }
    .configurationDisplayName(.widgetNextDateName)
    .description(.widgetNextDateDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
    .contentMarginsDisabled()
  }
}
