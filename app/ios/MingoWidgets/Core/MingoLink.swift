import Foundation

/// A page of the app a widget opens when tapped.
enum MingoLink: String {
  case today
  case together
  case capture
  case rituals
  case dates
  case card
  case slips
  case invite
  case distance
  case signIn = "sign-in"

  var url: URL? {
    URL(string: "mingo://\(rawValue)?src=widget")
  }
}
