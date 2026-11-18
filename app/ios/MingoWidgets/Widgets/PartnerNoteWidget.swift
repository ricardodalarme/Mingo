import SwiftUI
import WidgetKit

/// The note the partner sent to the widget, on a taped sheet of ruled paper.
struct MingoPartnerNoteView: View {
  @Environment(\.widgetFamily) private var family
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry, needsPartner: true) {
      let payload = entry.payload
      let palette = MingoPalette.of(payload.theme)
      let isMedium = family == .systemMedium
      MingoShell(link: .today) {
        ZStack(alignment: .top) {
          MingoPalette.paper
          if isMedium {
            Canvas { context, size in
              var y: CGFloat = 31.5
              while y < size.height {
                context.stroke(
                  Path { $0.move(to: CGPoint(x: 0, y: y)); $0.addLine(to: CGPoint(x: size.width, y: y)) },
                  with: .color(MingoPalette.paperLine), lineWidth: 1)
                y += 32
              }
            }
          }
          Rectangle()
            .fill(palette.highlight.opacity(0.28))
            .frame(width: isMedium ? 70 : 56, height: isMedium ? 22 : 20)
            .rotationEffect(.degrees(-2))
            .offset(y: -6)
        }
      } content: {
        VStack(alignment: .leading, spacing: 0) {
          if let note = payload.partnerNote {
            Text(verbatim: note)
              .mingoHand(isMedium ? 31 : 27)
              .lineSpacing(0)
              .lineLimit(isMedium ? 3 : 3)
              .minimumScaleFactor(0.6)
              .rotationEffect(.degrees(isMedium ? -1.5 : -2), anchor: .leading)
              .padding(.top, isMedium ? 0 : 8)
          } else {
            Text(.noteEmpty).mingoFont(17, .semibold)
          }
          Spacer(minLength: 4)
          HStack {
            Text(footer(payload)).mingoFont(12.5).opacity(0.8).lineLimit(1)
            Spacer(minLength: 4)
            if isMedium, payload.partnerNote != nil {
              Image(systemName: "heart.fill").font(.system(size: 15)).foregroundStyle(palette.highlight)
            }
          }
        }
        .foregroundStyle(MingoPalette.paperInk)
        .padding(.init(top: isMedium ? 22 : 16, leading: isMedium ? 22 : 16, bottom: isMedium ? 14 : 16, trailing: isMedium ? 22 : 16))
      }
    }
  }

  private func footer(_ payload: MingoPayload) -> LocalizedStringResource {
    guard payload.partnerNote != nil else { return .noteEmptyHint }
    let time = payload.partnerNoteAt.map { MingoFormat.arrived($0, now: entry.date) } ?? ""
    if let name = payload.partnerName { return .noteFrom(name, time) }
    return .noteFromPartner(time)
  }
}

struct MingoPartnerNoteWidget: Widget {
  let kind = "MingoPartnerNoteWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .frequent)) { entry in
      MingoPartnerNoteView(entry: entry)
    }
    .configurationDisplayName(.widgetPartnerNoteName)
    .description(.widgetPartnerNoteDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
    .contentMarginsDisabled()
  }
}
