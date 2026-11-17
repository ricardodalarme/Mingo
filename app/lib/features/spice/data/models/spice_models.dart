import 'package:equatable/equatable.dart';

/// Where the mode stands for the couple.
enum SpiceStage() {
  /// Neither person switched it on, or only the other did not yet.
  off,

  /// This person switched it on and waits for the partner.
  waitingPartner,

  /// The partner switched it on and this person has not.
  partnerWants,

  /// Both switched it on.
  on,
}

/// How far the cards and desires go, from the gentlest to the boldest.
enum SpiceLevel() {
  soft,
  warm,
  hot,
}

/// A private answer to a desire; only what both people want is ever shown.
enum SpiceAnswer() {
  want,
  maybe,
  notToday,
}

/// What a person can do with the week's challenge.
enum SpiceChallengeAction() {
  seen,
  accept,
  done,
  swap,
}

/// The mode for this person and the level the couple shares.
final class const SpiceStatus({
  required final SpiceStage stage,
  required final SpiceLevel myLevel,
  final SpiceLevel? coupleLevel,
}) with Equatable {
  @override
  List<Object?> get props => [stage, myLevel, coupleLevel];
}

/// An evening card; the other person answers it.
final class const SpiceCard({
  required final String id,
  required final String text,
  required final bool isMine,
}) with Equatable {
  @override
  List<Object?> get props => [id, text, isMine];
}

/// A desire the person can answer privately.
final class const SpiceDesire({
  required final String slug,
  required final String title,
  required final SpiceLevel level,
  final SpiceAnswer? answer,
}) with Equatable {
  SpiceDesire withAnswer(SpiceAnswer value) =>
      SpiceDesire(slug: slug, title: title, level: level, answer: value);

  @override
  List<Object?> get props => [slug, title, level, answer];
}

/// A desire both people answered "want".
final class const SpiceMatch({required final String slug, required final String title})
    with Equatable {
  @override
  List<Object?> get props => [slug, title];
}

/// The couple's challenge of the week, with no points and no deadline.
final class const SpiceChallenge({
  required final String text,
  required final bool acceptedByMe,
  required final bool doneByMe,
  required final bool acceptedByPartner,
  required final int swapsLeft,
}) with Equatable {
  @override
  List<Object?> get props => [text, acceptedByMe, doneByMe, acceptedByPartner, swapsLeft];
}

/// The person's own limits for the mode.
final class const SpiceSettings({
  required final SpiceLevel maxLevel,
  required final bool notifications,
}) with Equatable {
  SpiceSettings copyWith({SpiceLevel? maxLevel, bool? notifications}) => SpiceSettings(
    maxLevel: maxLevel ?? this.maxLevel,
    notifications: notifications ?? this.notifications,
  );

  @override
  List<Object?> get props => [maxLevel, notifications];
}

/// How many challenge swaps a couple has each week.
const int spiceMaxSwaps = 3;
