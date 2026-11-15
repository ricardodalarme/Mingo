import 'package:equatable/equatable.dart';

/// A one-tap message from the partner, with the answer already stored, if any.
final class const ReceivedSignal({
  required final String id,
  required final SignalKind kind,
  required final DateTime createdAt,
  final String? value,
  final String? body,
  final RepairResponse? response,
  final DateTime? respondedAt,
  final DateTime? seenAt,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => ReceivedSignal(
    id: 'fake',
    kind: SignalKind.repair,
    createdAt: DateTime(2026),
    body: 'Podemos recomeçar?',
  );

  /// Whether the person already answered or acknowledged the message.
  bool get isAnswered => respondedAt != null || seenAt != null;

  ReceivedSignal copyWith({RepairResponse? response, DateTime? respondedAt, DateTime? seenAt}) =>
      ReceivedSignal(
        id: id,
        kind: kind,
        createdAt: createdAt,
        value: value,
        body: body,
        response: response ?? this.response,
        respondedAt: respondedAt ?? this.respondedAt,
        seenAt: seenAt ?? this.seenAt,
      );

  @override
  List<Object?> get props => [id, kind, createdAt, value, body, response, respondedAt, seenAt];
}

/// How a person can answer a message, matching the server responses.
enum RepairResponse() {
  here,
  talk,
  moreTime,
  willDo,
  notNow,
  plan,
  later,
  heart,
}

/// What a one-tap message to the partner is about.
enum SignalKind() {
  need,
  missUs,
  hug,
  distance,
  repair,
  heavyDay,
  goodNews,
}

/// The answers each kind asks for, in the order they are offered.
extension SignalKindAnswers on SignalKind {
  List<RepairResponse> get answers => switch (this) {
    SignalKind.need => const [RepairResponse.talk, RepairResponse.notNow, RepairResponse.heart],
    SignalKind.missUs => const [RepairResponse.plan, RepairResponse.talk, RepairResponse.heart],
    SignalKind.hug => const [RepairResponse.heart],
    SignalKind.distance => const [RepairResponse.here, RepairResponse.later],
    SignalKind.repair => const [RepairResponse.talk, RepairResponse.moreTime, RepairResponse.later],
    SignalKind.heavyDay => const [RepairResponse.here, RepairResponse.willDo],
    SignalKind.goodNews => const [RepairResponse.heart],
  };

  /// Whether acknowledging without an answer is honest for this kind.
  bool get acceptsAcknowledgement => this == SignalKind.missUs || this == SignalKind.goodNews;
}
