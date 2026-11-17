import 'package:equatable/equatable.dart';

/// The longest agreement the server accepts.
const int agreementMaxLength = 200;

/// A short text one person proposes; it becomes an agreement when the other confirms.
final class const Agreement({
  required final String id,
  required final String body,
  required final bool isMine,
  required final bool isShared,
  required final bool isConfirmed,
}) with Equatable {
  /// A skeleton placeholder, never shown as a real record.
  factory fake() => const Agreement(
    id: 'fake',
    body: 'Conversar sobre dinheiro uma vez por mês',
    isMine: true,
    isShared: true,
    isConfirmed: false,
  );

  /// Whether the other person is waiting on this person to confirm it.
  bool get needsMyConfirmation => isShared && !isMine && !isConfirmed;

  /// Whether this person proposed it and the other one has not confirmed yet.
  bool get isWaitingForPartner => isShared && isMine && !isConfirmed;

  @override
  List<Object?> get props => [id, body, isMine, isShared, isConfirmed];
}
