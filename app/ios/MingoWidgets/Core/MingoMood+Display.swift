import Foundation
import SwiftUI

extension MingoPayload.Mood {
  /// The mood's name in the system language.
  var name: LocalizedStringResource {
    switch self {
    case .happy: .moodHappy
    case .tired: .moodTired
    case .sad: .moodSad
    case .stressed: .moodStressed
    case .loving: .moodLoving
    case .playful: .moodPlayful
    }
  }

  /// The hand-drawn face shared with the app.
  var face: ImageResource {
    switch self {
    case .happy: .faceHappy
    case .tired: .faceTired
    case .sad: .faceSad
    case .stressed: .faceStressed
    case .loving: .faceLoving
    case .playful: .facePlayful
    }
  }
}
