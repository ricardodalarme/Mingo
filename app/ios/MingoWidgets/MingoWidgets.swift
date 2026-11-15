import SwiftUI
import UIKit
import WidgetKit

enum MingoL10n {
  static var isEnglish: Bool {
    let code = (Locale.preferredLanguages.first ?? Locale.current.identifier).lowercased()
    return code.hasPrefix("en")
  }

  static func tr(pt: String, en: String) -> String {
    isEnglish ? en : pt
  }

  static var signedOutLabel: String { "MINGO" }
  static var signedOutTitle: String { tr(pt: "Toque para entrar", en: "Tap to sign in") }
  static var unpairedLabel: String { tr(pt: "JUNTOS", en: "TOGETHER") }
  static var unpairedTitle: String { tr(pt: "Convide para ver aqui", en: "Invite to see here") }
  static var unpairedAction: String { tr(pt: "Convidar", en: "Invite") }

  static var nextDateLabel: String { tr(pt: "PRÓXIMA DATA", en: "NEXT DATE") }
  static func daysCount(_ days: Int) -> String {
    tr(pt: "\(days) dias", en: "\(days) days")
  }
  static var ritualLabel: String { "RITUAL" }
  static var ritualDefaultSchedule: String { tr(pt: "Momento da semana", en: "Weekly moment") }
  static var moodLabel: String { tr(pt: "MEU HUMOR", en: "MY MOOD") }
  static var moodSubtitle: String { tr(pt: "Toque para atualizar", en: "Tap to update") }
  static var slipLabel: String { tr(pt: "ANOTAR SLIP", en: "QUICK SLIP") }
  static var slipTitle: String { "+ Slip" }
  static var slipSubtitle: String { tr(pt: "Toque para anotar", en: "Tap to capture") }

  static var jarLabel: String { tr(pt: "POTINHO DO DIA RUIM", en: "BAD-DAY JAR") }
  static func jarSavedCount(_ count: Int) -> String {
    tr(pt: "\(count) motivos guardados", en: "\(count) saved reasons")
  }
  static var jarSubtitle: String { tr(pt: "Para abrir quando precisar", en: "To open when you need it") }
  static var ideaLabel: String { tr(pt: "IDEIA DO DIA", en: "IDEA OF THE DAY") }
  static var ideaDefault: String { tr(pt: "Deixe um bilhete hoje", en: "Leave a short note today") }
  static var ideaSubtitle: String {
    tr(pt: "Toque para ver · Privado no seu aparelho", en: "Tap to view · Private on your device")
  }

  static var lockCalmMoment: String { tr(pt: "Momento calmo", en: "Calm moment") }
  static var lockReminderShortLabel: String { tr(pt: "Lembrete", en: "Reminder") }
  static var lockNeutralText: String { tr(pt: "Texto neutro", en: "Neutral text") }
  static var lockNoNamesHint: String {
    tr(pt: "Sem nomes na tela bloqueada", en: "No names on the lock screen")
  }

  static var counterLabel: String { tr(pt: "JUNTOS HÁ", en: "TOGETHER FOR") }
  static var counterUnset: String { tr(pt: "Começando agora", en: "Starting now") }
  static var counterDefaultSubtitle: String { tr(pt: "Tempo juntos", en: "Time together") }

  static var photoLabel: String { tr(pt: "MEMÓRIA", en: "MEMORY") }
  static var photoPlusOnly: String { tr(pt: "Disponível no Plus", en: "Available on Plus") }
  static var photoCachedSubtitle: String {
    tr(pt: "Memória salva neste aparelho", en: "Memory saved on this device")
  }
  static func photoDaysTogether(_ days: Int) -> String {
    tr(pt: "\(days) dias juntos", en: "\(days) days together")
  }
  static var photoFallbackTitle: String { tr(pt: "Um momento nosso", en: "A moment of ours") }
  static var photoNoPhoto: String { tr(pt: "Sem foto selecionada", en: "No photo selected") }

  static func noteFromNamed(_ name: String) -> String {
    tr(pt: "DE \(name.uppercased())", en: "FROM \(name.uppercased())")
  }
  static var noteFromDefault: String { tr(pt: "RECADO DO PAR", en: "PARTNER NOTE") }
  static var noteReplyHint: String { tr(pt: "Responder com um coração", en: "Reply with a heart") }
  static var noteEmpty: String { tr(pt: "Sem recado novo no momento", en: "No new note right now") }

  static var cardWeeklyLabel: String { tr(pt: "CARTÃO DA SEMANA", en: "WEEKLY CARD") }
  static var cardReadyTitle: String { tr(pt: "Chegou um cartão", en: "A card arrived") }
  static var cardSentTitle: String { tr(pt: "Cartão enviado", en: "Card sent") }
  static var cardDefaultTitle: String { tr(pt: "Cartão de domingo", en: "Sunday card") }
  static var cardNextDateDefault: String { tr(pt: "Próximo encontro", en: "Next date") }
  static var cardReadySubtitle: String { tr(pt: "Toque para abrir", en: "Tap to open") }
  static var cardPreparingSubtitle: String { tr(pt: "Em preparação", en: "In preparation") }

  static var ownSmallDisplayName: String {
    tr(pt: "Mingo · Meu (pequeno)", en: "Mingo · Mine (small)")
  }
  static var ownSmallDescription: String {
    tr(pt: "Anotar slip, próxima data, humor ou ritual.", en: "Quick slip, next date, mood, or ritual.")
  }
  static var ownMediumDisplayName: String {
    tr(pt: "Mingo · Meu (médio)", en: "Mingo · Mine (medium)")
  }
  static var ownMediumDescription: String {
    tr(pt: "Ideia do dia ou potinho do dia ruim.", en: "Idea of the day or bad-day jar.")
  }
  static var lockScreenDisplayName: String {
    tr(pt: "Mingo · Tela de bloqueio", en: "Mingo · Lock screen")
  }
  static var lockScreenDescription: String {
    tr(
      pt: "Símbolo e frase genérica, sem nomes nem mensagens.",
      en: "Symbol and generic phrase, without names or messages."
    )
  }
  static var coupleCounterDisplayName: String {
    tr(pt: "Mingo · Contador do casal", en: "Mingo · Couple counter")
  }
  static var coupleCounterDescription: String {
    tr(pt: "Dias juntos, atualizado à meia-noite.", en: "Days together, updated at midnight.")
  }
  static var couplePhotosDisplayName: String {
    tr(pt: "Mingo · Fotos do casal", en: "Mingo · Couple photos")
  }
  static var couplePhotosDescription: String {
    tr(pt: "Foto em cache local ou cartão neutro.", en: "Locally cached photo or neutral card.")
  }
  static var partnerNoteDisplayName: String {
    tr(pt: "Mingo · Recado do parceiro", en: "Mingo · Partner note")
  }
  static var partnerNoteDescription: String {
    tr(
      pt: "Recado curto marcado pelo seu par para o widget.",
      en: "Short note marked by your partner for the widget."
    )
  }
  static var cardEncounterDisplayName: String {
    tr(pt: "Mingo · Cartão e encontro", en: "Mingo · Card & date")
  }
  static var cardEncounterDescription: String {
    tr(
      pt: "Estado do cartão da semana e próxima data, sem nomes nem texto do cartão.",
      en: "Weekly card state and next date, without names or card text."
    )
  }
}

struct MingoWidgetPayload: Codable {
  let isSignedIn: Bool
  let isPaired: Bool
  let hasPlus: Bool
  let showNames: Bool
  let allowPartnerNotes: Bool
  let onLockScreen: Bool
  let isOffline: Bool
  let togetherSince: String?
  let relationshipPhase: String?
  let partnerName: String?
  let nextDateTitle: String?
  let nextDateOn: String?
  let unopenedCards: Int
  let cardState: String
  let partnerNote: String?
  let partnerNoteMedia: String?
  let partnerNoteAt: String?
  let partnerMood: String?
  let myMood: String?
  let ritualTitle: String?
  let ritualSchedule: String?
  let dailyIdeaTitle: String?
  let slipsCount: Int
  let suggestionKey: String?
  let cachedPhotoPath: String?
  let updatedAt: String

  static let appGroupId = "group.dev.dalarme.mingo"
  static let payloadKey = "mingo_widget_payload"
  static let cachedPhotoKey = "mingo_widget_photo_path"

  static func signedOut() -> MingoWidgetPayload {
    MingoWidgetPayload(
      isSignedIn: false,
      isPaired: false,
      hasPlus: false,
      showNames: false,
      allowPartnerNotes: false,
      onLockScreen: false,
      isOffline: false,
      togetherSince: nil,
      relationshipPhase: nil,
      partnerName: nil,
      nextDateTitle: nil,
      nextDateOn: nil,
      unopenedCards: 0,
      cardState: "none",
      partnerNote: nil,
      partnerNoteMedia: nil,
      partnerNoteAt: nil,
      partnerMood: nil,
      myMood: nil,
      ritualTitle: nil,
      ritualSchedule: nil,
      dailyIdeaTitle: nil,
      slipsCount: 0,
      suggestionKey: nil,
      cachedPhotoPath: nil,
      updatedAt: ""
    )
  }

  static func loadFromSharedStore() -> MingoWidgetPayload {
    guard
      let defaults = UserDefaults(suiteName: appGroupId),
      let raw = defaults.string(forKey: payloadKey),
      let data = raw.data(using: .utf8),
      let decoded = try? JSONDecoder().decode(MingoWidgetPayload.self, from: data)
    else {
      return signedOut()
    }
    if decoded.isSignedIn, decoded.isPaired, decoded.hasPlus,
      decoded.cachedPhotoPath == nil || decoded.cachedPhotoPath?.isEmpty == true,
      let directPhotoPath = defaults.string(forKey: cachedPhotoKey), !directPhotoPath.isEmpty
    {
      return MingoWidgetPayload(
        isSignedIn: decoded.isSignedIn,
        isPaired: decoded.isPaired,
        hasPlus: decoded.hasPlus,
        showNames: decoded.showNames,
        allowPartnerNotes: decoded.allowPartnerNotes,
        onLockScreen: decoded.onLockScreen,
        isOffline: decoded.isOffline,
        togetherSince: decoded.togetherSince,
        relationshipPhase: decoded.relationshipPhase,
        partnerName: decoded.partnerName,
        nextDateTitle: decoded.nextDateTitle,
        nextDateOn: decoded.nextDateOn,
        unopenedCards: decoded.unopenedCards,
        cardState: decoded.cardState,
        partnerNote: decoded.partnerNote,
        partnerNoteMedia: decoded.partnerNoteMedia,
        partnerNoteAt: decoded.partnerNoteAt,
        partnerMood: decoded.partnerMood,
        myMood: decoded.myMood,
        ritualTitle: decoded.ritualTitle,
        ritualSchedule: decoded.ritualSchedule,
        dailyIdeaTitle: decoded.dailyIdeaTitle,
        slipsCount: decoded.slipsCount,
        suggestionKey: decoded.suggestionKey,
        cachedPhotoPath: directPhotoPath,
        updatedAt: decoded.updatedAt
      )
    }
    return decoded
  }

  func daysTogether(on now: Date = Date()) -> Int? {
    guard isSignedIn, let raw = togetherSince, !raw.isEmpty else { return nil }
    guard let start = Self.parseLocalDate(raw) else { return nil }
    let calendar = Calendar.current
    let startOfStart = calendar.startOfDay(for: start)
    let startOfToday = calendar.startOfDay(for: now)
    let diff = calendar.dateComponents([.day], from: startOfStart, to: startOfToday).day ?? 0
    return max(0, diff)
  }

  func daysUntilNextDate(on now: Date = Date()) -> Int? {
    guard isSignedIn, let raw = nextDateOn, !raw.isEmpty else { return nil }
    guard let target = Self.parseLocalDate(raw) else { return nil }
    let calendar = Calendar.current
    let startOfToday = calendar.startOfDay(for: now)
    let startOfTarget = calendar.startOfDay(for: target)
    let diff = calendar.dateComponents([.day], from: startOfToday, to: startOfTarget).day ?? -1
    return diff >= 0 ? diff : nil
  }

  private static func parseLocalDate(_ raw: String) -> Date? {
    let prefix = String(raw.prefix(10))
    let parts = prefix.split(separator: "-")
    guard parts.count == 3,
      let year = Int(parts[0]),
      let month = Int(parts[1]),
      let day = Int(parts[2])
    else { return nil }
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    return Calendar.current.date(from: components)
  }
}

struct MingoWidgetEntry: TimelineEntry {
  let date: Date
  let payload: MingoWidgetPayload
}

struct MingoTimelineProvider: TimelineProvider {
  let refreshesAtMidnight: Bool

  init(refreshesAtMidnight: Bool = false) {
    self.refreshesAtMidnight = refreshesAtMidnight
  }

  func placeholder(in context: Context) -> MingoWidgetEntry {
    MingoWidgetEntry(date: Date(), payload: MingoWidgetPayload.signedOut())
  }

  func getSnapshot(in context: Context, completion: @escaping (MingoWidgetEntry) -> Void) {
    completion(MingoWidgetEntry(date: Date(), payload: MingoWidgetPayload.signedOut()))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<MingoWidgetEntry>) -> Void) {
    let now = Date()
    let payload = MingoWidgetPayload.loadFromSharedStore()
    var entries = [MingoWidgetEntry(date: now, payload: payload)]

    let fifteenMinutes = Calendar.current.date(byAdding: .minute, value: 15, to: now) ?? now.addingTimeInterval(900)
    var nextRefresh = fifteenMinutes
    if refreshesAtMidnight,
      let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: now))
    {
      entries.append(MingoWidgetEntry(date: tomorrow, payload: payload))
      nextRefresh = min(fifteenMinutes, tomorrow)
    }

    completion(Timeline(entries: entries, policy: .after(nextRefresh)))
  }
}

struct MingoSurfaceCard<Content: View>: View {
  @Environment(\.colorScheme) private var colorScheme
  let deepLink: String
  @ViewBuilder let content: () -> Content

  var body: some View {
    let bg = colorScheme == .dark
      ? Color(red: 0.11, green: 0.11, blue: 0.12)
      : Color(red: 0.99, green: 0.97, blue: 0.96)
    let contentView = VStack(alignment: .leading, spacing: 6) {
      content()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .padding(14)
    .widgetURL(URL(string: deepLink))

    if #available(iOSApplicationExtension 17.0, *) {
      contentView.containerBackground(bg, for: .widget)
    } else {
      contentView.background(bg)
    }
  }
}

struct MingoSignedOutWidgetCard: View {
  var body: some View {
    MingoSurfaceCard(deepLink: "mingo://sign-in?homeWidget=1") {
      Text(MingoL10n.signedOutLabel)
        .font(.caption2.weight(.semibold))
        .foregroundColor(.secondary)
        .lineLimit(1)
      Spacer(minLength: 4)
      Text(MingoL10n.signedOutTitle)
        .font(.subheadline.weight(.semibold))
        .lineLimit(2)
    }
  }
}

struct MingoUnpairedWidgetCard: View {
  var body: some View {
    MingoSurfaceCard(deepLink: "mingo://invite?homeWidget=1") {
      Text(MingoL10n.unpairedLabel)
        .font(.caption2.weight(.semibold))
        .foregroundColor(.secondary)
        .lineLimit(1)
      Spacer(minLength: 4)
      Text(MingoL10n.unpairedTitle)
        .font(.subheadline.weight(.semibold))
        .lineLimit(2)
      Text(MingoL10n.unpairedAction)
        .font(.caption)
        .foregroundColor(.secondary)
        .lineLimit(1)
    }
  }
}

struct MingoOwnSmallWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    }    } else if let days = p.daysUntilNextDate(on: entry.date), let title = p.nextDateTitle {
      MingoSurfaceCard(deepLink: "mingo://dates?homeWidget=1") {
        Text(MingoL10n.nextDateLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(MingoL10n.daysCount(days))
          .font(.headline.weight(.semibold))
          .lineLimit(1)
        Text(title)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    } else if let ritual = p.ritualTitle, !ritual.isEmpty {
      MingoSurfaceCard(deepLink: "mingo://rituals?homeWidget=1") {
        Text(MingoL10n.ritualLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(ritual)
          .font(.subheadline.weight(.semibold))
          .lineLimit(2)
        Text(p.ritualSchedule ?? MingoL10n.ritualDefaultSchedule)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    } else if let mood = p.myMood, !mood.isEmpty {
      MingoSurfaceCard(deepLink: "mingo://mood?homeWidget=1") {
        Text(MingoL10n.moodLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(mood)
          .font(.headline.weight(.semibold))
          .lineLimit(1)
        Text(MingoL10n.moodSubtitle)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    } else {
      MingoSurfaceCard(deepLink: "mingo://capture?homeWidget=1") {
        Text(MingoL10n.slipLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(MingoL10n.slipTitle)
          .font(.headline.weight(.semibold))
          .lineLimit(1)
        Text(MingoL10n.slipSubtitle)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(2)
      }
    }
  }
}

struct MingoOwnMediumWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    }    } else if p.dailyIdeaTitle == nil && p.slipsCount > 0 {
      MingoSurfaceCard(deepLink: "mingo://jar?homeWidget=1") {
        Text(MingoL10n.jarLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Text(MingoL10n.jarSavedCount(p.slipsCount))
          .font(.subheadline.weight(.semibold))
          .lineLimit(2)
        Spacer(minLength: 2)
        Text(MingoL10n.jarSubtitle)
          .font(.caption2)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    } else {
      let idea = p.dailyIdeaTitle ?? MingoL10n.ideaDefault
      MingoSurfaceCard(deepLink: "mingo://today?homeWidget=1") {
        Text(MingoL10n.ideaLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Text(idea)
          .font(.subheadline.weight(.semibold))
          .lineLimit(2)
        Spacer(minLength: 2)
        Text(MingoL10n.ideaSubtitle)
          .font(.caption2)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    }
  }
}

struct MingoOwnSmallWidget: Widget {
  let kind: String = "MingoOwnSmallWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider()) { entry in
      MingoOwnSmallWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.ownSmallDisplayName)
    .description(MingoL10n.ownSmallDescription)
    .supportedFamilies([.systemSmall])
  }
}

struct MingoOwnMediumWidget: Widget {
  let kind: String = "MingoOwnMediumWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider()) { entry in
      MingoOwnMediumWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.ownMediumDisplayName)
    .description(MingoL10n.ownMediumDescription)
    .supportedFamilies([.systemMedium])
  }
}

@available(iOS 16.0, *)
struct MingoLockScreenWidgetView: View {
  @Environment(\.widgetFamily) private var family
  let entry: MingoWidgetEntry

  var body: some View {
    let p = entry.payload
    let neutral = !p.isSignedIn || !p.onLockScreen
    let symbol = neutral ? "circle.dotted" : "heart"
    let label = neutral ? MingoL10n.lockReminderShortLabel : MingoL10n.lockCalmMoment
    let phrase = neutral ? MingoL10n.lockNeutralText : MingoL10n.lockNoNamesHint
    let deepLink = !p.isSignedIn
      ? "mingo://sign-in?homeWidget=1"
      : (p.onLockScreen ? "mingo://today?homeWidget=1" : "mingo://settings/widgets?homeWidget=1")

    switch family {
    case .accessoryCircular:
      ZStack {
        AccessoryWidgetBackground()
        Image(systemName: symbol)
          .font(.system(size: 18, weight: .semibold))
      }
      .widgetURL(URL(string: deepLink))
    case .accessoryInline:
      Label(label, systemImage: symbol)
        .widgetURL(URL(string: deepLink))
    default:
      VStack(alignment: .leading, spacing: 2) {
        Label(label, systemImage: symbol)
          .font(.caption.weight(.semibold))
          .lineLimit(1)
        Text(phrase)
          .font(.caption2)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .widgetURL(URL(string: deepLink))
    }
  }
}

private var repaLockScreenFamilies: [WidgetFamily] {
  if #available(iOS 16.0, *) {
    return [.accessoryCircular, .accessoryRectangular, .accessoryInline]
  }
  return []
}

private struct MingoLockScreenWidgetContent: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    if #available(iOS 17.0, *) {
      MingoLockScreenWidgetView(entry: entry)
        .containerBackground(.clear, for: .widget)
    } else if #available(iOS 16.0, *) {
      MingoLockScreenWidgetView(entry: entry)
    } else {
      EmptyView()
    }
  }
}

struct MingoLockScreenWidget: Widget {
  let kind: String = "MingoLockScreenWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider()) { entry in
      MingoLockScreenWidgetContent(entry: entry)
    }
    .configurationDisplayName(MingoL10n.lockScreenDisplayName)
    .description(MingoL10n.lockScreenDescription)
    .supportedFamilies(repaLockScreenFamilies)
  }
}

struct MingoCoupleCounterWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    }    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else {
      let daysText = p.daysTogether(on: entry.date).map { MingoL10n.daysCount($0) } ?? MingoL10n.counterUnset
      let subtitle = (p.showNames ? p.partnerName : nil) ?? MingoL10n.counterDefaultSubtitle
      MingoSurfaceCard(deepLink: "mingo://together?homeWidget=1") {
        Text(MingoL10n.counterLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(daysText)
          .font(.headline.weight(.semibold))
          .lineLimit(1)
        Text(subtitle)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    }
  }
}

struct MingoCoupleCounterWidget: Widget {
  let kind: String = "MingoCoupleCounterWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider(refreshesAtMidnight: true)) { entry in
      MingoCoupleCounterWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.coupleCounterDisplayName)
    .description(MingoL10n.coupleCounterDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

struct MingoCouplePhotosWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    }    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else if !p.hasPlus {
      MingoSurfaceCard(deepLink: "mingo://memories?homeWidget=1") {
        Text(MingoL10n.photoLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(MingoL10n.photoPlusOnly)
          .font(.subheadline.weight(.semibold))
          .lineLimit(2)
      }
    } else if let path = p.cachedPhotoPath, !path.isEmpty, let uiImage = UIImage(contentsOfFile: path) {
      MingoSurfaceCard(deepLink: "mingo://memories?homeWidget=1") {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFill()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .clipped()
          .cornerRadius(8)
        Text(MingoL10n.photoCachedSubtitle)
          .font(.caption2)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    } else {
      let fallbackTitle = p.daysTogether(on: entry.date).map { MingoL10n.photoDaysTogether($0) } ?? MingoL10n.photoFallbackTitle
      MingoSurfaceCard(deepLink: "mingo://memories?homeWidget=1") {
        Text(MingoL10n.photoLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(fallbackTitle)
          .font(.headline.weight(.semibold))
          .lineLimit(2)
        Text(MingoL10n.photoNoPhoto)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    }
  }
}

struct MingoCouplePhotosWidget: Widget {
  let kind: String = "MingoCouplePhotosWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider(refreshesAtMidnight: true)) { entry in
      MingoCouplePhotosWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.couplePhotosDisplayName)
    .description(MingoL10n.couplePhotosDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

struct MingoPartnerNoteWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    }    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else {
      let fromLabel = (p.showNames ? p.partnerName.map { MingoL10n.noteFromNamed($0) } : nil) ?? MingoL10n.noteFromDefault
      if p.allowPartnerNotes, let note = p.partnerNote, !note.isEmpty {
        MingoSurfaceCard(deepLink: "mingo://today?homeWidget=1") {
          Text(fromLabel)
            .font(.caption2.weight(.semibold))
            .foregroundColor(.secondary)
            .lineLimit(1)
          Spacer(minLength: 4)
          Text(note)
            .font(.subheadline.weight(.semibold))
            .lineLimit(2)
          Text(MingoL10n.noteReplyHint)
            .font(.caption2)
            .foregroundColor(.secondary)
            .lineLimit(1)
        }
      } else {
        MingoSurfaceCard(deepLink: "mingo://today?homeWidget=1") {
          Text(fromLabel)
            .font(.caption2.weight(.semibold))
            .foregroundColor(.secondary)
            .lineLimit(1)
          Spacer(minLength: 4)
          Text(MingoL10n.noteEmpty)
            .font(.subheadline.weight(.semibold))
            .lineLimit(2)
        }
      }
    }
  }
}

struct MingoPartnerNoteWidget: Widget {
  let kind: String = "MingoPartnerNoteWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider()) { entry in
      MingoPartnerNoteWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.partnerNoteDisplayName)
    .description(MingoL10n.partnerNoteDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

struct MingoCardEncounterWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    }    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else {
      let cardTitle: String = switch p.cardState {
      case "ready": MingoL10n.cardReadyTitle
      case "sent": MingoL10n.cardSentTitle
      default: MingoL10n.cardDefaultTitle
      }

      let days = p.daysUntilNextDate(on: entry.date)
      let encounterSubtitle: String = if let days {
        "\(MingoL10n.daysCount(days)) · \(p.nextDateTitle ?? MingoL10n.cardNextDateDefault)"
      } else {
        p.cardState == "ready" ? MingoL10n.cardReadySubtitle : MingoL10n.cardPreparingSubtitle
      }

      let targetLink = p.cardState == "ready"
        ? "mingo://card?homeWidget=1"
        : (days != nil ? "mingo://dates?homeWidget=1" : "mingo://card?homeWidget=1")

      MingoSurfaceCard(deepLink: targetLink) {
        Text(MingoL10n.cardWeeklyLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(cardTitle)
          .font(.subheadline.weight(.semibold))
          .lineLimit(2)
        Text(encounterSubtitle)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    }
  }
}

struct MingoCardEncounterWidget: Widget {
  let kind: String = "MingoCardEncounterWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider(refreshesAtMidnight: true)) { entry in
      MingoCardEncounterWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.cardEncounterDisplayName)
    .description(MingoL10n.cardEncounterDescription)
    .supportedFamilies([.systemSmall, .systemMedium])
  }
}

@main
struct MingoWidgetsBundle: WidgetBundle {
  var body: some Widget {
    MingoOwnSmallWidget()
    MingoOwnMediumWidget()
    MingoLockScreenWidget()
    MingoCoupleCounterWidget()
    MingoCouplePhotosWidget()
    MingoPartnerNoteWidget()
    MingoCardEncounterWidget()
  }
}
