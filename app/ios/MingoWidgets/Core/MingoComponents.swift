import SwiftUI
import WidgetKit

/// The frame every widget shares: its background, a tap target and the deep link it opens.
struct MingoShell<Background: View, Content: View>: View {
  let link: MingoLink
  @ViewBuilder var background: () -> Background
  @ViewBuilder var content: () -> Content

  var body: some View {
    content()
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      .widgetURL(link.url)
      .containerBackground(for: .widget) { background() }
  }
}

/// The small uppercase label at the top of a widget.
struct MingoEyebrow: View {
  let text: LocalizedStringResource
  var color: Color = .primary
  var opacity: Double = 0.75

  var body: some View {
    Text(text)
      .font(.system(size: 11.5, weight: .semibold))
      .tracking(0.7)
      .textCase(.uppercase)
      .foregroundStyle(color.opacity(opacity))
      .lineLimit(1)
  }
}

extension View {
  func mingoFont(_ size: CGFloat, _ weight: Font.Weight = .regular) -> some View {
    font(.system(size: size, weight: weight))
  }

  func mingoHand(_ size: CGFloat) -> some View {
    font(.custom("Caveat", size: size))
  }
}

/// Two overlapping initials for the two people.
struct MingoInitials: View {
  let own: String?
  let partner: String?
  let ownColor: Color
  let ownBackground: Color
  var size: CGFloat = 26

  var body: some View {
    HStack(spacing: -size * 0.3) {
      if let initial = Self.initial(own) {
        circle(initial, color: ownColor, background: ownBackground)
      }
      if let initial = Self.initial(partner) {
        circle(initial, color: .white, background: MingoPalette.charcoal)
      }
    }
  }

  private func circle(_ initial: String, color: Color, background: Color) -> some View {
    Text(verbatim: initial)
      .font(.system(size: 10, weight: .semibold))
      .foregroundStyle(color)
      .frame(width: size, height: size)
      .background(background, in: Circle())
      .overlay(Circle().stroke(.white, lineWidth: 2))
  }

  private static func initial(_ name: String?) -> String? {
    name?.first.map { String($0).uppercased() }
  }
}

/// The hand-drawn face of a mood, drawn from the app's own faces.
struct MingoMoodFace: View {
  let mood: MingoPayload.Mood
  var color: Color
  var size: CGFloat = 46

  var body: some View {
    Image(mood.face)
      .renderingMode(.template)
      .resizable()
      .scaledToFit()
      .frame(width: size, height: size)
      .foregroundStyle(color)
  }
}

/// What a widget shows when nobody is signed in.
struct MingoSignedOutView: View {
  var body: some View {
    MingoShell(link: .signIn) {
      MingoPalette.surface
    } content: {
      VStack(alignment: .leading, spacing: 0) {
        MingoEyebrow(text: .signedOutLabel, color: MingoPalette.textSecondary, opacity: 1)
        Spacer(minLength: 4)
        Text(.signedOutTitle)
          .mingoFont(15, .semibold)
          .foregroundStyle(MingoPalette.textPrimary)
          .lineLimit(3)
      }
      .padding(16)
    }
  }
}

/// What a widget about the partner shows until a partner is connected.
struct MingoInviteView: View {
  let theme: MingoPayload.Theme

  var body: some View {
    let palette = MingoPalette.of(theme)
    MingoShell(link: .invite) {
      MingoPalette.surface
    } content: {
      VStack(alignment: .leading, spacing: 0) {
        Image(systemName: "heart.fill")
          .font(.system(size: 20))
          .foregroundStyle(palette.highlight)
        Spacer(minLength: 4)
        Text(.inviteTitle)
          .mingoFont(15, .semibold)
          .foregroundStyle(MingoPalette.textPrimary)
          .lineLimit(3)
        Text(.inviteAction)
          .mingoFont(12.5)
          .foregroundStyle(palette.label)
          .padding(.top, 3)
      }
      .padding(16)
    }
  }
}

/// Picks the guard states every widget shares before it draws its own content.
struct MingoGate<Content: View>: View {
  let entry: MingoEntry
  var needsPartner = false
  @ViewBuilder var content: () -> Content

  var body: some View {
    if !entry.payload.isSignedIn {
      MingoSignedOutView()
    } else if needsPartner && !entry.payload.isPaired {
      MingoInviteView(theme: entry.payload.theme)
    } else {
      content()
    }
  }
}
