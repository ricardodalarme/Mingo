import 'package:app/features/notifications/data/models/notification_kind.dart';
import 'package:equatable/equatable.dart';

/// One entry of the in-app notification list.
final class const InboxItem({
  required final String id,
  required final NotificationKind kind,
  required final DateTime createdAt,
  final DateTime? readAt,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => InboxItem(
    id: 'fake',
    kind: NotificationKind.cardReceived,
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );

  bool get isRead => readAt != null;

  @override
  List<Object?> get props => [id, kind, createdAt, readAt];
}
