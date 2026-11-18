import SwiftUI
import UIKit

extension Color {
  init(hex: UInt32, opacity: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xFF) / 255,
      green: Double((hex >> 8) & 0xFF) / 255,
      blue: Double(hex & 0xFF) / 255,
      opacity: opacity
    )
  }

  /// A color that switches with the system appearance.
  init(light: UInt32, dark: UInt32) {
    self.init(uiColor: UIColor { traits in
      let hex = traits.userInterfaceStyle == .dark ? dark : light
      return UIColor(
        red: CGFloat((hex >> 16) & 0xFF) / 255,
        green: CGFloat((hex >> 8) & 0xFF) / 255,
        blue: CGFloat(hex & 0xFF) / 255,
        alpha: 1
      )
    })
  }
}

/// The colors a widget paints with: the person's theme plus the fixed ones every theme shares.
struct MingoPalette {
  let soft: Color
  let highlight: Color
  let label: Color
  let border: Color
  let tintStart: Color
  let tintMiddle: Color
  let tintEnd: Color
  let mist: Color
  let ink: Color

  static func of(_ theme: MingoPayload.Theme) -> MingoPalette {
    switch theme {
    case .rose:
      return MingoPalette(
        soft: Color(hex: 0xFBE3E9), highlight: Color(hex: 0xE8577A), label: Color(hex: 0xC93A60),
        border: Color(hex: 0xF0E4E7), tintStart: Color(hex: 0xFFD3DE), tintMiddle: Color(hex: 0xFFC9B3), tintEnd: Color(hex: 0xFFB9A6),
        mist: Color(hex: 0xFFD6E0), ink: Color(hex: 0x6E2C3C))
    case .blue:
      return MingoPalette(
        soft: Color(hex: 0xE1EDFB), highlight: Color(hex: 0x3C86DA), label: Color(hex: 0x2470C2),
        border: Color(hex: 0xE2EAF3), tintStart: Color(hex: 0xCFE2FA), tintMiddle: Color(hex: 0xBDD5F6), tintEnd: Color(hex: 0xA9C8F2),
        mist: Color(hex: 0xD4E5FB), ink: Color(hex: 0x1F3F66))
    case .neutral:
      return MingoPalette(
        soft: Color(hex: 0xE2F0E7), highlight: Color(hex: 0x3A8E68), label: Color(hex: 0x287752),
        border: Color(hex: 0xE8E7E1), tintStart: Color(hex: 0xD6ECDE), tintMiddle: Color(hex: 0xC6E3D2), tintEnd: Color(hex: 0xB7DCC6),
        mist: Color(hex: 0xD9EEE0), ink: Color(hex: 0x24473A))
    }
  }

  // Fixed colors shared by every theme.
  static let peach = Color(hex: 0xFFE3C4)
  static let cream = Color(hex: 0xFFF1E3)
  static let charcoal = Color(hex: 0x2B2828)
  static let plum = Color(hex: 0x5A2C40)
  static let paper = Color(hex: 0xFFF3D2)
  static let paperInk = Color(hex: 0x5B3A1E)
  static let paperLine = Color(hex: 0xB48C3C, opacity: 0.18)
  static let nightStart = Color(hex: 0x2D2F57)
  static let nightMiddle = Color(hex: 0x6A5389)
  static let nightEnd = Color(hex: 0xB88AA8)
  static let dayStart = Color(hex: 0xFFB66B)
  static let dayEnd = Color(hex: 0xFF7E6B)
  static let nightHalfEnd = Color(hex: 0x5B4B88)
  static let sky = Color(hex: 0xE8F1FF)
  static let skyInk = Color(hex: 0x2B2D4E)
  static let confettiYellow = Color(hex: 0xFFC25C)
  static let confettiBlue = Color(hex: 0x7FB8F0)

  // Surfaces that follow the system appearance.
  static let surface = Color(light: 0xFFFFFF, dark: 0x1F1D1E)
  static let textPrimary = Color(light: 0x2B2828, dark: 0xF4F1F2)
  static let textSecondary = Color(light: 0x736D70, dark: 0xA9A3A6)
}
