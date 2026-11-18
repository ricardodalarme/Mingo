import SwiftUI
import WidgetKit

/// Days together, with the two initials and, when medium, the story timeline.
struct MingoCounterView: View {
  @Environment(\.widgetFamily) private var family
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry) {
      let payload = entry.payload
      let palette = MingoPalette.of(payload.theme)
      let isMedium = family == .systemMedium
      MingoShell(link: .together) {
        ZStack(alignment: .bottomTrailing) {
          LinearGradient(
            colors: isMedium
              ? [palette.tintStart, palette.tintMiddle, MingoPalette.peach]
              : [palette.tintStart, palette.tintEnd],
            startPoint: isMedium ? .leading : .topLeading,
            endPoint: isMedium ? .trailing : .bottomTrailing
          )
          if !isMedium {
            Image(systemName: "heart.fill")
              .font(.system(size: 120))
              .foregroundStyle(.white.opacity(0.28))
              .rotationEffect(.degrees(14))
              .offset(x: 22, y: 26)
              .accessibilityHidden(true)
          }
        }
      } content: {
        content(payload: payload, palette: palette, isMedium: isMedium)
          .foregroundStyle(palette.ink)
          .padding(.horizontal, isMedium ? 18 : 16)
          .padding(.vertical, isMedium ? 16 : 15)
      }
    }
  }

  @ViewBuilder
  private func content(payload: MingoPayload, palette: MingoPalette, isMedium: Bool) -> some View {
    if let days = payload.daysTogether(on: entry.date) {
      HStack(spacing: 0) {
        VStack(alignment: .leading, spacing: 0) {
          MingoEyebrow(text: .counterEyebrow, color: palette.ink)
          Spacer(minLength: 4)
          Text(verbatim: String(days))
            .font(.system(size: isMedium ? 56 : 50, weight: .semibold))
            .tracking(isMedium ? -2.8 : -2.5)
            .minimumScaleFactor(0.6)
            .lineLimit(1)
          if isMedium, let duration = payload.durationTogether(on: entry.date).flatMap(MingoFormat.duration) {
            Text(verbatim: duration).mingoFont(14).opacity(0.85).lineLimit(1).minimumScaleFactor(0.8)
          } else {
            Text(MingoFormat.dayUnit(days)).mingoFont(14).opacity(0.85)
          }
          Spacer(minLength: 4)
          MingoInitials(
            own: payload.ownName, partner: payload.partnerName,
            ownColor: palette.label, ownBackground: .white)
        }
        if isMedium {
          MingoTimeline(payload: payload, palette: palette, now: entry.date)
            .frame(width: 140)
        }
      }
    } else {
      VStack(alignment: .leading, spacing: 0) {
        MingoEyebrow(text: .counterEyebrow, color: palette.ink)
        Spacer(minLength: 4)
        Text(.counterNeedDate).mingoFont(17, .semibold)
      }
    }
  }
}

private struct MingoTimeline: View {
  let payload: MingoPayload
  let palette: MingoPalette
  let now: Date

  private struct Item: Identifiable {
    let id: Int
    let text: String
    let isToday: Bool
  }

  private var items: [Item] {
    var titles: [(String, Bool)] = payload.milestones.suffix(2).map { ($0.title, false) }
    if titles.isEmpty, let start = MingoPayload.localDate(payload.togetherSince) {
      titles.append((start.formatted(date: .abbreviated, time: .omitted), false))
    }
    titles.append((String(localized: .counterToday), true))
    return titles.enumerated().map { Item(id: $0.offset, text: $0.element.0, isToday: $0.element.1) }
  }

  var body: some View {
    HStack(alignment: .top, spacing: 8) {
      Line().stroke(palette.ink.opacity(0.4), style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [0.1, 5]))
        .frame(width: 2)
        .padding(.vertical, 10)
        .padding(.leading, 4)
      VStack(alignment: .leading, spacing: 0) {
        ForEach(items) { item in
          if item.id > 0 { Spacer(minLength: 0) }
          HStack(spacing: 8) {
            Circle()
              .fill(item.isToday ? MingoPalette.charcoal : palette.label)
              .frame(width: 10, height: 10)
              .overlay(Circle().stroke(.white, lineWidth: 2))
              .offset(x: -17)
              .padding(.trailing, -17)
            Text(verbatim: item.text).mingoFont(12.5).lineLimit(1)
          }
        }
      }
      .padding(.leading, 4)
    }
  }

  private struct Line: Shape {
    func path(in rect: CGRect) -> Path {
      var path = Path()
      path.move(to: CGPoint(x: rect.midX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
      return path
    }
  }
}

struct MingoCounterWidget: Widget {
  let kind = "MingoCounterWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .daily)) { entry in
      MingoCounterView(entry: entry)
    }
    .configurationDisplayName(.widgetCounterName)
    .description(.widgetCounterDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
    .contentMarginsDisabled()
  }
}
