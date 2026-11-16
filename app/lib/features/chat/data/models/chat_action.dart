import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:equatable/equatable.dart';

/// Where a suggestion is: waiting for the person, running, done or put aside.
enum ChatActionStatus() {
  pending,
  running,
  done,
  dismissed,
  failed,
}

/// One card the mascot offers under a reply. Nothing happens until the person taps it.
final class const ChatAction({
  required final String tool,
  required final bool needsConfirmation,
  required final PreparedChatAction prepared,
  final ChatActionStatus status = ChatActionStatus.pending,
}) with Equatable {
  ChatAction copyWith({ChatActionStatus? status}) => ChatAction(
    tool: tool,
    needsConfirmation: needsConfirmation,
    prepared: prepared,
    status: status ?? this.status,
  );

  @override
  List<Object?> get props => [tool, needsConfirmation, prepared.text, prepared.valueKey, status];
}
