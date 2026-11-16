/// What a person chose to do about a partner when they started.
enum PartnerIntent() {
  /// Send an invite now.
  invite,

  /// Start alone and invite later.
  later,

  /// Use the app alone and never be prompted to invite.
  soloOnly,
}
