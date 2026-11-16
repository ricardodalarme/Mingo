import 'package:app/features/chat/data/data_sources/remote/dtos/chat_event_dto.dart';
import 'package:app/features/chat/data/mappers/chat_mapper.dart';
import 'package:app/features/chat/data/models/chat_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('roles and modes use the names the server expects', () {
    expect(ChatRole.mascot.toRemote(), 'mascot');
    expect(ChatMode.hardConversation.toRemote(), 'hard_conversation');
  });

  test('an action event becomes a suggestion', () {
    final event = const ChatActionDto(
      tool: 'log_mood',
      args: {'mood': 'tired'},
      needsConfirmation: false,
    ).toModel();

    expect(
      event,
      isA<ChatSuggestion>()
          .having((e) => e.tool, 'tool', 'log_mood')
          .having((e) => e.needsConfirmation, 'needsConfirmation', isFalse),
    );
  });

  test('the other events keep their content', () {
    expect(const ChatDeltaDto(text: 'a').toModel(), isA<ChatDelta>());
    expect(const ChatDoneDto(options: ['x']).toModel(), isA<ChatDone>());
    expect(const ChatErrorDto(code: 'E').toModel(), isA<ChatError>());
  });
}
