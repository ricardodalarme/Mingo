import SwiftUI
import WidgetKit

/// Both clocks of a long-distance couple and the days until they meet.
struct MingoDistanceView: View {
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry, needsPartner: true) {
      let payload = entry.payload
      let palette = MingoPalette.of(payload.theme)
      if let own = payload.ownZone.flatMap(TimeZone.init(identifier:)),
        let partner = payload.partnerZone.flatMap(TimeZone.init(identifier:))
      {
        clocks(payload: payload, own: own, partner: partner)
      } else {
        missing(palette: palette)
      }
    }
  }

  private func clocks(payload: MingoPayload, own: TimeZone, partner: TimeZone) -> some View {
    MingoShell(link: .distance) {
      Color.clear
    } content: {
      ZStack {
        HStack(spacing: 0) {
          half(
            zone: own, label: .distanceYou(MingoFormat.city(own.identifier)),
            colors: [MingoPalette.dayStart, MingoPalette.dayEnd], alignment: .leading)
          half(
            zone: partner,
            label: payload.partnerName.map { .distancePartner(MingoFormat.city(partner.identifier), $0) }
              ?? .distanceCity(MingoFormat.city(partner.identifier)),
            colors: [MingoPalette.nightStart, MingoPalette.nightHalfEnd], alignment: .trailing)
        }
        pill(payload: payload)
      }
    }
  }

  private func half(zone: TimeZone, label: LocalizedStringResource, colors: [Color], alignment: HorizontalAlignment)
    -> some View
  {
    let hour = Calendar.current.dateComponents(in: zone, from: entry.date).hour ?? 12
    return VStack(alignment: alignment, spacing: 0) {
      Image(systemName: hour < 6 || hour >= 18 ? "moon.stars.fill" : "sun.max.fill")
        .font(.system(size: 22))
      Spacer(minLength: 4)
      Text(verbatim: MingoFormat.clock(entry.date, in: zone))
        .font(.system(size: 24, weight: .semibold)).tracking(-0.7).monospacedDigit()
      Text(label).mingoFont(12.5).opacity(0.9).lineLimit(1).minimumScaleFactor(0.8)
    }
    .foregroundStyle(.white)
    .padding(16)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment == .leading ? .topLeading : .topTrailing)
    .background(
      LinearGradient(colors: colors, startPoint: UnitPoint(x: 0.3, y: 0), endPoint: UnitPoint(x: 0.7, y: 1)))
  }

  private func pill(payload: MingoPayload) -> some View {
    VStack(spacing: 0) {
      if let days = payload.daysUntilReunion(on: entry.date) {
        Text(verbatim: String(days)).font(.system(size: 26, weight: .semibold)).tracking(-1)
        Text(MingoFormat.untilMeeting(days)).mingoFont(11.5).foregroundStyle(Color(hex: 0x736D70))
      } else {
        Text(.distanceNoReunion).mingoFont(12).multilineTextAlignment(.center)
      }
    }
    .foregroundStyle(MingoPalette.charcoal)
    .padding(.horizontal, 16)
    .padding(.vertical, 8)
    .background(.white, in: RoundedRectangle(cornerRadius: 22))
    .shadow(color: .black.opacity(0.18), radius: 8, y: 4)
  }

  private func missing(palette: MingoPalette) -> some View {
    MingoShell(link: .together) {
      MingoPalette.surface
    } content: {
      VStack(alignment: .leading) {
        Spacer(minLength: 0)
        Text(.distanceMissing).mingoFont(15, .semibold).foregroundStyle(MingoPalette.textPrimary)
      }
      .padding(18)
    }
  }
}

struct MingoDistanceWidget: Widget {
  let kind = "MingoDistanceWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .frequent)) { entry in
      MingoDistanceView(entry: entry)
    }
    .configurationDisplayName(.widgetDistanceName)
    .description(.widgetDistanceDescription)
    .supportedFamilies([.systemMedium])
    .contentMarginsDisabled()
  }
}
