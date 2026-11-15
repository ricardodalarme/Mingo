import 'package:equatable/equatable.dart';

/// Which composition a [ShareCard] draws.
enum ShareCardKind() {
  counter,
  moon,
  timeline,
  quote,
}

/// The content of one share image, built only from what the app already stores.
sealed class const ShareCard() with Equatable {
  /// Which card this is, used for labels.
  ShareCardKind get kind;
}

/// How long the couple has been together, from [since].
final class const ShareCounterCard({required final DateTime since}) extends ShareCard {
  @override
  ShareCardKind get kind => ShareCardKind.counter;

  @override
  List<Object?> get props => [since];
}

/// The moon phase on [date], the couple's special date.
final class const ShareMoonCard({required final DateTime date}) extends ShareCard {
  @override
  ShareCardKind get kind => ShareCardKind.moon;

  @override
  List<Object?> get props => [date];
}

/// One moment on a [ShareTimelineCard].
final class const ShareTimelineEntry({
  required final String title,
  required final DateTime date,
  final String? place,
}) with Equatable {
  @override
  List<Object?> get props => [title, date, place];
}

/// A handful of real moments, newest first.
final class const ShareTimelineCard({required final List<ShareTimelineEntry> entries})
    extends ShareCard {
  @override
  ShareCardKind get kind => ShareCardKind.timeline;

  @override
  List<Object?> get props => [entries];
}

/// A line from a card the person already received.
final class const ShareQuoteCard({
  required final String quote,
  final String? authorName,
  final DateTime? date,
}) extends ShareCard {
  @override
  ShareCardKind get kind => ShareCardKind.quote;

  @override
  List<Object?> get props => [quote, authorName, date];
}
