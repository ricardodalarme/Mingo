import 'package:app/features/cards/data/models/card_status.dart';
import 'package:equatable/equatable.dart';

/// A piece of editorial content shown on Hoje.
final class const Suggestion({
  required final String slug,
  required final String title,
  final String? body,
  final List<String> tags = const [],
}) with Equatable {
  factory fromMap(Map<String, dynamic> map) => Suggestion(
    slug: map['slug'] as String,
    title: map['title'] as String,
    body: map['body'] as String?,
    tags: (map['tags'] as List<dynamic>?)?.cast<String>() ?? const [],
  );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'slug': slug,
    'title': title,
    'body': body,
    'tags': tags,
  };

  @override
  List<Object?> get props => [slug, title, body, tags];
}

/// Everything Hoje shows, read in one request.
final class const TodayHome({
  required final bool isPaired,
  required final int unopenedCards,
  required final int slipsThisWeek,
  required final int slipsTotal,
  required final bool hasPendingInvite,
  required final bool hasPlus,
  final String? partnerName,
  final DateTime? localDate,
  final String? cardStatus,
  final DateTime? togetherSince,
  final int unseenSignals = 0,
  final Suggestion? question,
  final Suggestion? idea,
  final List<DateTime> slipDays = const [],
}) with Equatable {
  factory fromMap(Map<String, dynamic> map) => TodayHome(
    isPaired: map['isPaired'] as bool,
    unopenedCards: map['unopenedCards'] as int,
    slipsThisWeek: map['slipsThisWeek'] as int,
    slipsTotal: map['slipsTotal'] as int? ?? 0,
    hasPendingInvite: map['hasPendingInvite'] as bool,
    hasPlus: map['hasPlus'] as bool,
    partnerName: map['partnerName'] as String?,
    localDate: _date(map['localDate']),
    cardStatus: map['cardStatus'] as String?,
    togetherSince: _date(map['togetherSince']),
    unseenSignals: map['unseenSignals'] as int? ?? 0,
    question: _suggestion(map['question']),
    idea: _suggestion(map['idea']),
    slipDays:
        (map['slipDays'] as List<dynamic>?)
            ?.map((value) => DateTime.parse(value as String))
            .toList() ??
        const [],
  );

  /// A skeleton placeholder, never shown as a real record.
  const new fake()
    : this(
        isPaired: true,
        unopenedCards: 0,
        slipsThisWeek: 2,
        slipsTotal: 2,
        hasPendingInvite: false,
        hasPlus: false,
        partnerName: 'Nome',
        question: const Suggestion(slug: 'fake', title: 'Qual é uma mania dele que você adora?'),
        idea: const Suggestion(
          slug: 'fake',
          title: 'Uma ideia pequena para hoje',
          body: 'Leva dois minutos.',
        ),
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
    'isPaired': isPaired,
    'unopenedCards': unopenedCards,
    'slipsThisWeek': slipsThisWeek,
    'slipsTotal': slipsTotal,
    'hasPendingInvite': hasPendingInvite,
    'hasPlus': hasPlus,
    'partnerName': partnerName,
    'localDate': localDate?.toIso8601String(),
    'cardStatus': cardStatus,
    'togetherSince': togetherSince?.toIso8601String(),
    'unseenSignals': unseenSignals,
    'question': question?.toMap(),
    'idea': idea?.toMap(),
    'slipDays': [for (final day in slipDays) day.toIso8601String()],
  };

  /// Whether this week's card exists and has not gone out yet.
  bool get hasCardToSend =>
      cardStatus == CardStatus.draft.name || cardStatus == CardStatus.held.name;

  static DateTime? _date(Object? value) => value == null ? null : DateTime.parse(value as String);

  static Suggestion? _suggestion(Object? value) =>
      value == null ? null : Suggestion.fromMap(value as Map<String, dynamic>);

  @override
  List<Object?> get props => [
    isPaired,
    unopenedCards,
    slipsThisWeek,
    slipsTotal,
    hasPendingInvite,
    hasPlus,
    partnerName,
    localDate,
    cardStatus,
    togetherSince,
    unseenSignals,
    question,
    idea,
    slipDays,
  ];
}
