import 'package:app/features/annoyances/data/models/gentle_response.dart';
import 'package:equatable/equatable.dart';

/// A request in the three sentences "when", "I feel", "I would like", between the two partners.
final class const GentleRequest({
  required final String id,
  required final String whenText,
  required final String feelText,
  required final String wishText,
  required final String senderId,
  required final String recipientId,
  required final DateTime createdAt,
  final GentleResponse? response,
  final DateTime? seenAt,
  final DateTime? thankedAt,
  final String? senderName,
  final String? recipientName,
}) with Equatable {
  /// The sentence the recipient reads.
  bool isFrom(String userId) => senderId == userId;

  bool get isAnswered => response != null;

  /// Whether the sender may still thank for a promise that was kept.
  bool get canBeThanked => response == GentleResponse.willDo && thankedAt == null;

  @override
  List<Object?> get props => [
    id,
    whenText,
    feelText,
    wishText,
    senderId,
    recipientId,
    createdAt,
    response,
    seenAt,
    thankedAt,
    senderName,
    recipientName,
  ];
}
