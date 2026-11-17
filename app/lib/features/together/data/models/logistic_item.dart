import 'package:equatable/equatable.dart';

/// One practical thing the couple shares; an unset [assigneeId] means both of them.
final class const LogisticItem({
  required final String id,
  required final String title,
  final String? assigneeId,
  final String? authorId,
  final bool isShared = false,
  final bool isConfirmed = false,
  final bool isDone = false,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => const LogisticItem(id: 'fake', title: 'Comprar pão');

  /// Whether the other person proposed this item and still waits for the person to confirm it.
  bool needsConfirmationFrom(String? personId) =>
      isShared && !isConfirmed && authorId != null && authorId != personId;

  /// Whether the person proposed this shared item and the other one has not confirmed it.
  bool isWaitingFor(String? personId) => isShared && !isConfirmed && authorId == personId;

  LogisticItem copyWith({String? assigneeId, bool clearAssignee = false, bool? isDone}) =>
      LogisticItem(
        id: id,
        title: title,
        assigneeId: clearAssignee ? null : assigneeId ?? this.assigneeId,
        authorId: authorId,
        isShared: isShared,
        isConfirmed: isConfirmed,
        isDone: isDone ?? this.isDone,
      );

  @override
  List<Object?> get props => [id, title, assigneeId, authorId, isShared, isConfirmed, isDone];
}

/// The longest title the server accepts.
const int logisticTitleMaxLength = 120;
