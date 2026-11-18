import SwiftUI
import WidgetKit

/// The person's own week: a bar for each weekday that holds slips.
struct MingoWeekView: View {
  let entry: MingoEntry

  var body: some View {
    MingoGate(entry: entry) {
      let payload = entry.payload
      let palette = MingoPalette.of(payload.theme)
      let perDay = Dictionary(grouping: payload.slipWeekdays, by: { $0 }).mapValues(\.count)
      let monday = Calendar.current.date(
        byAdding: .day, value: -(MingoPayload.isoWeekday(of: entry.date) - 1),
        to: Calendar.current.startOfDay(for: entry.date)) ?? entry.date
      MingoShell(link: .slips) {
        MingoPalette.surface
      } content: {
        VStack(spacing: 0) {
          HStack(alignment: .firstTextBaseline) {
            MingoEyebrow(text: .weekEyebrow, color: palette.label, opacity: 1)
            Spacer()
            Text(.weekCount(payload.slipsThisWeek)).mingoFont(13).foregroundStyle(MingoPalette.textSecondary)
          }
          Spacer(minLength: 6)
          HStack(alignment: .bottom, spacing: 10) {
            ForEach(1...7, id: \.self) { day in
              let count = perDay[day] ?? 0
              let date = Calendar.current.date(byAdding: .day, value: day - 1, to: monday) ?? monday
              VStack(spacing: 6) {
                RoundedRectangle(cornerRadius: 10)
                  .fill(count > 0 ? AnyShapeStyle(LinearGradient(colors: [palette.tintEnd, palette.highlight], startPoint: .top, endPoint: .bottom)) : AnyShapeStyle(palette.soft))
                  .frame(height: count > 0 ? 16 + 10 * CGFloat(min(count, 3)) : 14)
                Text(verbatim: MingoFormat.weekdayShort(date))
                  .mingoFont(11.5, count > 0 ? .semibold : .regular)
                  .foregroundStyle(count > 0 ? palette.label : MingoPalette.textSecondary)
                  .lineLimit(1).minimumScaleFactor(0.7)
              }
              .frame(maxWidth: .infinity)
            }
          }
          .frame(height: 70)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 16)
      }
    }
  }
}

struct MingoWeekWidget: Widget {
  let kind = "MingoWeekWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoProvider(refresh: .daily)) { entry in
      MingoWeekView(entry: entry)
    }
    .configurationDisplayName(.widgetWeekName)
    .description(.widgetWeekDescription)
    .supportedFamilies([.systemMedium])
    .contentMarginsDisabled()
  }
}
