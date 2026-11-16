import 'package:app/features/chat/data/data_sources/remote/dtos/chat_event_dto.dart';
import 'package:app/features/chat/data/models/chat_models.dart';

extension ChatRoleMapper on ChatRole {
  String toRemote() => switch (this) {
    ChatRole.user => 'user',
    ChatRole.mascot => 'mascot',
  };
}

extension ChatModeMapper on ChatMode {
  String toRemote() => switch (this) {
    ChatMode.free => 'free',
    ChatMode.hardConversation => 'hard_conversation',
  };
}

extension ChatEventDtoMapper on ChatEventDto {
  ChatEvent toModel() => switch (this) {
    ChatDeltaDto(:final text) => ChatDelta(text),
    ChatDoneDto(:final options) => ChatDone(options),
    ChatActionDto(:final tool, :final args, :final needsConfirmation) => ChatSuggestion(
      tool: tool,
      args: args,
      needsConfirmation: needsConfirmation,
    ),
    ChatErrorDto(:final code) => ChatError(code),
  };
}
