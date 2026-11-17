/// What happened when a slip was sent on its own.
enum SlipSendOutcome() {
  /// The partner has it.
  sent,

  /// The wording matched a rule, so the card was held instead of sent.
  held,

  /// Nothing was sent: no partner, or the slip may not be sent.
  notSent,
}
