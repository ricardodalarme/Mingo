import SwiftUI
import WidgetKit

/// The Sunday card when small; the card and the next date as a ticket when medium.
struct MingoCardView: View {
  @Environment(\.widgetFamily) private var family
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry) {
      let palette = MingoPalette.of(entry.payload.theme)
      if family == .systemMedium {
        ticket(palette: palette)
      } else {
        small(palette: palette)
      }
    }
  }

  private var cardLine: LocalizedStringResource {
    switch entry.payload.cardState {
    case .ready: return .cardReady
    case .sent: return .cardSent
    case .none:
      guard let send = entry.payload.nextCardSend(after: entry.date) else { return .cardTitle }
      return .cardSends(MingoFormat.when(send, now: entry.date))
    }
  }

  private func small(palette: MingoPalette) -> some View {
    let count = entry.payload.slipsThisWeek
    return MingoShell(link: .card) {
      LinearGradient(
        colors: [palette.soft, MingoPalette.cream], startPoint: UnitPoint(x: 0.3, y: 0),
        endPoint: UnitPoint(x: 0.7, y: 1))
    } content: {
      ZStack(alignment: .bottomLeading) {
        sheet { EmptyView() }.rotationEffect(.degrees(9)).offset(x: 2, y: 16)
        sheet {
          if count > 0 {
            Text(.cardGoodThings(count)).mingoHand(17).foregroundStyle(palette.label)
          } else {
            Image(systemName: "heart.fill").foregroundStyle(palette.highlight)
          }
        }
        .rotationEffect(.degrees(-5))
        .offset(x: -12, y: 4)
        VStack(alignment: .leading, spacing: 3) {
          Text(.cardTitle).mingoFont(15, .semibold).lineLimit(2)
          Text(cardLine).mingoFont(12.5).opacity(0.8).lineLimit(1)
        }
      }
      .foregroundStyle(palette.ink)
      .padding(16)
    }
  }

  private func sheet<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
    content()
      .padding(10)
      .frame(width: 84, height: 104, alignment: .topLeading)
      .background(.white, in: RoundedRectangle(cornerRadius: 14))
      .shadow(color: .black.opacity(0.18), radius: 8, y: 5)
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
  }

  private func ticket(palette: MingoPalette) -> some View {
    let payload = entry.payload
    let date = payload.daysUntilNextDate(on: entry.date) != nil ? payload.nextDate : nil
    return MingoShell(link: date == nil ? .card : .dates) {
      MingoPalette.surface
    } content: {
      HStack(spacing: 0) {
        VStack(spacing: 2) {
          if let date {
            Text(verbatim: MingoFormat.weekdayShort(date)).mingoFont(12, .semibold).tracking(1.2).textCase(.uppercase)
            Text(verbatim: String(Calendar.current.component(.day, from: date)))
              .font(.system(size: 46, weight: .semibold)).tracking(-1.8)
            Text(verbatim: MingoFormat.monthShort(date)).mingoFont(12).opacity(0.9)
          } else {
            Image(systemName: "calendar").font(.system(size: 34, weight: .light))
          }
        }
        .foregroundStyle(.white)
        .frame(width: 96)
        .frame(maxHeight: .infinity)
        .background(
          LinearGradient(
            colors: [palette.highlight, palette.tintEnd], startPoint: UnitPoint(x: 0.3, y: 0),
            endPoint: UnitPoint(x: 0.7, y: 1)))
        Line().stroke(Color(light: 0xE4D6DA, dark: 0x4A4447), style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [0.1, 5]))
          .frame(width: 2)
        VStack(alignment: .leading, spacing: 0) {
          MingoEyebrow(text: .cardEncounter, color: palette.label, opacity: 1)
          Text(verbatim: payload.nextDateTitle ?? String(localized: .cardEncounterEmpty))
            .mingoFont(19, .semibold).tracking(-0.4).lineLimit(3).minimumScaleFactor(0.8)
            .foregroundStyle(MingoPalette.textPrimary)
            .padding(.top, 6)
          Spacer(minLength: 4)
          HStack {
            Text(cardLine).mingoFont(12.5).foregroundStyle(MingoPalette.textSecondary).lineLimit(1)
            Spacer(minLength: 4)
            MingoInitials(
              own: payload.ownName, partner: payload.partnerName,
              ownColor: palette.label, ownBackground: palette.soft, size: 24)
          }
        }
        .padding(16)
      }
    }
  }

  private struct Line: Shape {
    func path(in rect: CGRect) -> Path {
      var path = Path()
      path.move(to: CGPoint(x: rect.midX, y: rect.minY + 10))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - 10))
      return path
    }
  }
}

struct MingoCardWidget: Widget {
  let kind = "MingoCardWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .daily)) { entry in
      MingoCardView(entry: entry)
    }
    .configurationDisplayName(.widgetCardName)
    .description(.widgetCardDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
    .contentMarginsDisabled()
  }
}
