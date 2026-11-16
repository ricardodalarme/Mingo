import 'package:equatable/equatable.dart';

/// Something that bothered the person: private, kept for 14 days, never part of a card.
final class const Annoyance({
  required final String id,
  required final String body,
  required final DateTime createdAt,
  required final DateTime expiresAt,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => Annoyance(
    id: 'fake',
    body: 'Fiquei com a louça sozinha de novo',
    createdAt: DateTime(2026),
    expiresAt: DateTime(2026, 1, 15),
  );

  /// Whole days since it was written, at [now].
  int ageInDays(DateTime now) => now.difference(createdAt).inDays;

  /// Whole days left before it disappears, at [now]; never below zero.
  int daysLeft(DateTime now) {
    final left = (expiresAt.difference(now).inHours / 24).ceil();

    return left < 0 ? 0 : left;
  }

  @override
  List<Object?> get props => [id, body, createdAt, expiresAt];
}
