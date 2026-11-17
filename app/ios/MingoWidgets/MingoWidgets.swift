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
  static var ownWeekLabel: String { tr(pt: "MINHA SEMANA", en: "MY WEEK") }
  static func slipsThisWeek(_ count: Int) -> String {
    tr(pt: "\(count) slips", en: "\(count) slips")
  }
  static func weekdayShort(_ day: Int) -> String {
    let pt = ["seg", "ter", "qua", "qui", "sex", "sáb", "dom"]
    let en = ["mon", "tue", "wed", "thu", "fri", "sat", "sun"]
    guard day >= 1, day <= 7 else { return "" }
    return isEnglish ? en[day - 1] : pt[day - 1]
  }
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
  static var counterToday: String { tr(pt: "Hoje", en: "Today") }
  static func counterBreakdown(_ years: Int, _ months: Int, _ days: Int) -> String {
    tr(
      pt: "\(years) anos, \(months) meses e \(days) dias",
      en: "\(years) years, \(months) months and \(days) days"
    )
  }

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

  static var partnerMoodLabel: String { tr(pt: "HUMOR DO PARCEIRO", en: "PARTNER MOOD") }
  static var partnerMoodHidden: String {
    tr(pt: "O humor aparece quando seu par compartilhar.", en: "Mood appears when your partner shares it.")
  }
  static func partnerMoodNow(_ name: String) -> String {
    tr(pt: "\(name) agora", en: "\(name) now")
  }
  static var partnerMoodNowAnonymous: String { tr(pt: "Agora", en: "Now") }
  static func moodName(_ mood: String) -> String {
    switch mood {
    case "happy": return tr(pt: "Feliz", en: "Happy")
    case "tired": return tr(pt: "Cansado(a)", en: "Tired")
    case "sad": return tr(pt: "Triste", en: "Sad")
    case "stressed": return tr(pt: "Estressado(a)", en: "Stressed")
    case "loving": return tr(pt: "Carinhoso(a)", en: "Affectionate")
    case "playful": return tr(pt: "Brincalhão(ona)", en: "Playful")
    default: return ""
    }
  }
  static func moodSymbol(_ mood: String) -> String {
    switch mood {
    case "happy": return "face.smiling"
    case "tired": return "moon.zzz"
    case "sad": return "cloud.rain"
    case "stressed": return "bolt"
    case "loving": return "heart"
    case "playful": return "sparkles"
    default: return "circle.dotted"
    }
  }

  static var longingLabel: String { tr(pt: "SAUDADE DE NÓS", en: "MISSING US") }
  static var longingAction: String { tr(pt: "Mandar saudade", en: "Send some missing") }
  static var longingReceived: String { tr(pt: "Seu par mandou saudade", en: "Your partner misses you") }
  static var longingHint: String { tr(pt: "Um toque e a pessoa sente.", en: "One tap and they feel it.") }

  static var distanceLabel: String { tr(pt: "NAMORO À DISTÂNCIA", en: "LONG DISTANCE") }
  static var distanceMissing: String {
    tr(pt: "Fuso do seu par ainda não definido", en: "Your partner's timezone is not set")
  }
  static var distanceHint: String { tr(pt: "Cada um no seu fuso.", en: "Each in their own timezone.") }
  static func distanceDays(_ days: Int) -> String {
    tr(pt: "\(days) dias até se verem", en: "\(days) days until you meet")
  }
  static var distanceNoReunion: String { tr(pt: "Próximo encontro sem data", en: "Next meeting without a date") }

  static func relativeTime(_ iso: String?) -> String {
    guard let iso else { return "" }
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    var date = formatter.date(from: iso)
    if date == nil {
      formatter.formatOptions = [.withInternetDateTime]
      date = formatter.date(from: iso)
    }
    guard let date else { return "" }
    let minutes = max(0, Int(Date().timeIntervalSince(date) / 60))
    if minutes < 1 { return tr(pt: "agora", en: "just now") }
    if minutes < 60 { return tr(pt: "há \(minutes) min", en: "\(minutes) min ago") }
    let hours = minutes / 60
    if hours < 24 { return tr(pt: "há \(hours) h", en: "\(hours) h ago") }
    return tr(pt: "há \(hours / 24) d", en: "\(hours / 24) d ago")
  }

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
    tr(pt: "Anotar slip, próxima data, ritual ou cartão.", en: "Quick slip, next date, ritual, or card.")
  }
  static var ownMediumDisplayName: String {
    tr(pt: "Mingo · Meu (médio)", en: "Mingo · Mine (medium)")
  }
  static var ownMediumDescription: String {
    tr(pt: "Minha semana, ideia do dia ou próxima data.", en: "My week, idea of the day or next date.")
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
  static var partnerMoodDisplayName: String {
    tr(pt: "Mingo · Humor do parceiro", en: "Mingo · Partner mood")
  }
  static var partnerMoodDescription: String {
    tr(pt: "O humor que seu par escolheu compartilhar.", en: "The mood your partner chose to share.")
  }
  static var longingDisplayName: String {
    tr(pt: "Mingo · Saudade de nós", en: "Mingo · Missing us")
  }
  static var longingDescription: String {
    tr(pt: "Mande ou receba saudade em um toque.", en: "Send or receive a missing signal in one tap.")
  }
  static var distanceDisplayName: String {
    tr(pt: "Mingo · Namoro à distância", en: "Mingo · Long distance")
  }
  static var distanceDescription: String {
    tr(pt: "Os dois fusos e os dias até se verem.", en: "Both timezones and days until you meet.")
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
  let partnerMoodAt: String?
  let partnerMissedAt: String?
  let myMood: String?
  let ritualTitle: String?
  let ritualSchedule: String?
  let dailyIdeaTitle: String?
  let slipsCount: Int
  let slipsThisWeek: Int
  let slipDays: [String]?
  let suggestionKey: String?
  let cachedPhotoPath: String?
  let ownName: String?
  let cardSendDay: Int?
  let cardSendHour: Int?
  let ownZone: String?
  let partnerZone: String?
  let ownLocalTime: String?
  let partnerLocalTime: String?
  let reunionTitle: String?
  let reunionOn: String?
  let reunionDays: Int?
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
      partnerMoodAt: nil,
      partnerMissedAt: nil,
      myMood: nil,
      ritualTitle: nil,
      ritualSchedule: nil,
      dailyIdeaTitle: nil,
      slipsCount: 0,
      slipsThisWeek: 0,
      slipDays: nil,
      suggestionKey: nil,
      cachedPhotoPath: nil,
      ownName: nil,
      cardSendDay: nil,
      cardSendHour: nil,
      ownZone: nil,
      partnerZone: nil,
      ownLocalTime: nil,
      partnerLocalTime: nil,
      reunionTitle: nil,
      reunionOn: nil,
      reunionDays: nil,
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
        partnerMoodAt: decoded.partnerMoodAt,
        partnerMissedAt: decoded.partnerMissedAt,
        myMood: decoded.myMood,
        ritualTitle: decoded.ritualTitle,
        ritualSchedule: decoded.ritualSchedule,
        dailyIdeaTitle: decoded.dailyIdeaTitle,
        slipsCount: decoded.slipsCount,
        slipsThisWeek: decoded.slipsThisWeek,
        slipDays: decoded.slipDays,
        suggestionKey: decoded.suggestionKey,
        cachedPhotoPath: directPhotoPath,
        ownName: decoded.ownName,
        cardSendDay: decoded.cardSendDay,
        cardSendHour: decoded.cardSendHour,
        ownZone: decoded.ownZone,
        partnerZone: decoded.partnerZone,
        ownLocalTime: decoded.ownLocalTime,
        partnerLocalTime: decoded.partnerLocalTime,
        reunionTitle: decoded.reunionTitle,
        reunionOn: decoded.reunionOn,
        reunionDays: decoded.reunionDays,
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

  /// Years, months and days together at local midnight.
  func durationBreakdown(on now: Date = Date()) -> (years: Int, months: Int, days: Int)? {
    guard isSignedIn, let raw = togetherSince, !raw.isEmpty,
      let start = Self.parseLocalDate(raw)
    else { return nil }
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day], from: start, to: now)
    guard let years = components.year, let months = components.month, let days = components.day,
      years >= 0
    else { return nil }
    return (years, months, days)
  }

  static func parseLocalDate(_ raw: String) -> Date? {
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
    } else if let days = p.daysUntilNextDate(on: entry.date), let title = p.nextDateTitle {
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
    } else if p.cardState == "ready" || p.cardState == "sent" {
      MingoSurfaceCard(deepLink: "mingo://card?homeWidget=1") {
        Text(MingoL10n.cardWeeklyLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(p.cardState == "ready" ? MingoL10n.cardReadyTitle : MingoL10n.cardSentTitle)
          .font(.subheadline.weight(.semibold))
          .lineLimit(2)
        Text(MingoL10n.cardReadySubtitle)
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

  private static func weekdayIndex(_ raw: String) -> Int? {
    guard let date = MingoWidgetPayload.parseLocalDate(raw) else { return nil }
    let weekday = Calendar.current.component(.weekday, from: date)
    return ((weekday + 5) % 7) + 1
  }

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    } else if p.slipsThisWeek > 0 {
      let activeDays = Set((p.slipDays ?? []).compactMap { Self.weekdayIndex($0) })
      MingoSurfaceCard(deepLink: "mingo://slips?homeWidget=1") {
        HStack {
          Text(MingoL10n.ownWeekLabel)
            .font(.caption2.weight(.semibold))
            .foregroundColor(.secondary)
            .lineLimit(1)
          Spacer(minLength: 4)
          Text(MingoL10n.slipsThisWeek(p.slipsThisWeek))
            .font(.caption)
            .foregroundColor(.secondary)
        }
        Spacer(minLength: 6)
        HStack(spacing: 6) {
          ForEach(1...7, id: \.self) { day in
            VStack(spacing: 4) {
              Circle()
                .fill(activeDays.contains(day) ? Color.accentColor : Color.secondary.opacity(0.18))
                .frame(width: 10, height: 10)
              Text(MingoL10n.weekdayShort(day))
                .font(.system(size: 9))
                .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity)
          }
        }
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
  @Environment(\.widgetFamily) private var family
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else {
      let daysText = p.daysTogether(on: entry.date).map { MingoL10n.daysCount($0) } ?? MingoL10n.counterUnset
      let subtitle = (p.showNames ? p.partnerName : nil) ?? MingoL10n.counterDefaultSubtitle
      let breakdown = p.durationBreakdown(on: entry.date)
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
        if family == .systemMedium, let breakdown {
          Text(MingoL10n.counterBreakdown(breakdown.years, breakdown.months, breakdown.days))
            .font(.caption2)
            .foregroundColor(.secondary)
            .lineLimit(1)
          HStack(spacing: 6) {
            Circle().fill(Color.accentColor).frame(width: 6, height: 6)
            Rectangle().fill(Color.secondary.opacity(0.25)).frame(height: 1)
            Circle().stroke(Color.secondary.opacity(0.4), lineWidth: 1).frame(width: 6, height: 6)
            Text(MingoL10n.counterToday)
              .font(.caption2)
              .foregroundColor(.secondary)
          }
        }
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
    } else if !p.isPaired {
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
    } else if !p.isPaired {
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

struct MingoPartnerMoodWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else if let mood = p.partnerMood, !mood.isEmpty, !MingoL10n.moodName(mood).isEmpty {
      let name = p.showNames ? p.partnerName : nil
      MingoSurfaceCard(deepLink: "mingo://today?homeWidget=1") {
        Text(name.map { MingoL10n.partnerMoodNow($0) } ?? MingoL10n.partnerMoodNowAnonymous)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        HStack(spacing: 8) {
          Image(systemName: MingoL10n.moodSymbol(mood))
            .font(.title3)
            .foregroundColor(.accentColor)
          VStack(alignment: .leading, spacing: 2) {
            Text(MingoL10n.moodName(mood))
              .font(.subheadline.weight(.semibold))
              .lineLimit(1)
            Text(MingoL10n.relativeTime(p.partnerMoodAt))
              .font(.caption2)
              .foregroundColor(.secondary)
              .lineLimit(1)
          }
        }
      }
    } else {
      MingoSurfaceCard(deepLink: "mingo://today?homeWidget=1") {
        Text(MingoL10n.partnerMoodLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(MingoL10n.partnerMoodHidden)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(3)
      }
    }
  }
}

struct MingoPartnerMoodWidget: Widget {
  let kind: String = "MingoPartnerMoodWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider()) { entry in
      MingoPartnerMoodWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.partnerMoodDisplayName)
    .description(MingoL10n.partnerMoodDescription)
    .supportedFamilies([.systemSmall])
  }
}

struct MingoLongingWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else {
      let received = p.partnerMissedAt != nil
      MingoSurfaceCard(deepLink: "mingo://today?homeWidget=1") {
        Text(MingoL10n.longingLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(received ? MingoL10n.longingReceived : MingoL10n.longingAction)
          .font(.subheadline.weight(.semibold))
          .lineLimit(2)
        Text(received ? MingoL10n.relativeTime(p.partnerMissedAt) : MingoL10n.longingHint)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(1)
      }
    }
  }
}

struct MingoLongingWidget: Widget {
  let kind: String = "MingoLongingWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider()) { entry in
      MingoLongingWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.longingDisplayName)
    .description(MingoL10n.longingDescription)
    .supportedFamilies([.systemSmall])
  }
}

struct MingoDistanceWidgetView: View {
  let entry: MingoWidgetEntry

  private static func city(_ zone: String?) -> String {
    guard let zone, !zone.isEmpty else { return "" }
    return zone.split(separator: "/").last.map(String.init)?.replacingOccurrences(of: "_", with: " ") ?? zone
  }

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    } else if !p.isPaired {
      MingoUnpairedWidgetCard()
    } else if let partnerZone = p.partnerZone, let ownZone = p.ownZone, !partnerZone.isEmpty,
      !ownZone.isEmpty, partnerZone != ownZone
    {
      MingoSurfaceCard(deepLink: "mingo://together?homeWidget=1") {
        Text(MingoL10n.distanceLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        HStack(alignment: .top, spacing: 12) {
          VStack(alignment: .leading, spacing: 2) {
            Text(p.ownLocalTime ?? "--:--")
              .font(.title3.weight(.semibold))
            Text(Self.city(ownZone))
              .font(.caption2)
              .foregroundColor(.secondary)
              .lineLimit(1)
          }
          Divider().frame(height: 34)
          VStack(alignment: .leading, spacing: 2) {
            Text(p.partnerLocalTime ?? "--:--")
              .font(.title3.weight(.semibold))
            Text(Self.city(partnerZone))
              .font(.caption2)
              .foregroundColor(.secondary)
              .lineLimit(1)
          }
          Spacer(minLength: 0)
        }
        if let days = p.reunionDays {
          Text(MingoL10n.distanceDays(days))
            .font(.caption.weight(.semibold))
            .lineLimit(1)
          Text(p.reunionTitle ?? MingoL10n.distanceHint)
            .font(.caption2)
            .foregroundColor(.secondary)
            .lineLimit(1)
        } else {
          Text(MingoL10n.distanceNoReunion)
            .font(.caption.weight(.semibold))
            .lineLimit(1)
        }
      }
    } else {
      MingoSurfaceCard(deepLink: "mingo://together?homeWidget=1") {
        Text(MingoL10n.distanceLabel)
          .font(.caption2.weight(.semibold))
          .foregroundColor(.secondary)
          .lineLimit(1)
        Spacer(minLength: 4)
        Text(MingoL10n.distanceMissing)
          .font(.caption)
          .foregroundColor(.secondary)
          .lineLimit(3)
      }
    }
  }
}

struct MingoDistanceWidget: Widget {
  let kind: String = "MingoDistanceWidget"

  var body: some WidgetConfiguration {
    StaticConfiguration(kind: kind, provider: MingoTimelineProvider(refreshesAtMidnight: true)) { entry in
      MingoDistanceWidgetView(entry: entry)
    }
    .configurationDisplayName(MingoL10n.distanceDisplayName)
    .description(MingoL10n.distanceDescription)
    .supportedFamilies([.systemMedium])
  }
}

struct MingoCardEncounterWidgetView: View {
  let entry: MingoWidgetEntry

  @ViewBuilder
  var body: some View {
    let p = entry.payload
    if !p.isSignedIn {
      MingoSignedOutWidgetCard()
    } else if !p.isPaired {
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
    MingoPartnerNoteWidget()
    MingoPartnerMoodWidget()
    MingoLongingWidget()
    MingoDistanceWidget()
    MingoCardEncounterWidget()
  }
}
