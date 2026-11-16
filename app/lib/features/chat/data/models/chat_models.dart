import 'package:app/features/chat/data/models/chat_action.dart';
import 'package:equatable/equatable.dart';

/// The longest message the server reads.
const int chatMessageMaxLength = 1000;

/// How many earlier turns are sent along so the mascot keeps the thread.
const int chatHistoryTurns = 12;

/// How long a reply may stay silent before it is treated as interrupted.
const Duration chatIdleTimeout = Duration(seconds: 45);

enum ChatRole() {
  user,
  mascot,
}

/// What kind of help the chat gives.
enum ChatMode() {
  free,
  hardConversation,
}

/// One bubble of the conversation; the chat is never stored, so this lives only in memory.
final class const ChatMessage({
  required final String id,
  required final ChatRole role,
  required final String text,
  final bool isStreaming = false,
  final bool isInterrupted = false,
  final String? retryText,
  final List<ChatAction> actions = const [],
}) with Equatable {
  ChatMessage copyWith({
    String? text,
    bool? isStreaming,
    bool? isInterrupted,
    List<ChatAction>? actions,
  }) => ChatMessage(
    id: id,
    role: role,
    text: text ?? this.text,
    isStreaming: isStreaming ?? this.isStreaming,
    isInterrupted: isInterrupted ?? this.isInterrupted,
    retryText: retryText,
    actions: actions ?? this.actions,
  );

  @override
  List<Object?> get props => [id, role, text, isStreaming, isInterrupted, retryText, actions];
}

/// What the server streams back.
sealed class const ChatEvent();

final class const ChatDelta(final String text) extends ChatEvent;

final class const ChatDone(final List<String> options) extends ChatEvent;

final class const ChatError(final String code) extends ChatEvent;

/// A suggestion the server made, not yet understood by any feature.
final class const ChatSuggestion({
  required final String tool,
  required final Map<String, Object?> args,
  required final bool needsConfirmation,
}) extends ChatEvent;
