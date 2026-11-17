import 'package:equatable/equatable.dart';

/// A sent card as listed in the history, from the person's side.
final class const CardSummary({
  required final String id,
  required final bool isMine,
  required final DateTime sentAt,
  required final int itemCount,
  final String? reaction,
  final bool hasReply = false,
  final bool isOpened = false,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => CardSummary(id: 'fake', isMine: true, sentAt: DateTime(2026), itemCount: 3);

  @override
  List<Object?> get props => [id, isMine, sentAt, itemCount, reaction, hasReply, isOpened];
}
