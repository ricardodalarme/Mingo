/// One event the chat function streams back.
sealed class const ChatEventDto() {
  /// Reads a decoded event, or returns null for a shape this version does not know.
  static ChatEventDto? fromMap(Map<String, Object?> map) {
    return switch (map['type']) {
      'delta' => ChatDeltaDto(text: map['text'] as String? ?? ''),
      'done' => ChatDoneDto(options: _strings(map['options'])),
      'action' => _action(map),
      'error' => ChatErrorDto(code: map['code'] as String? ?? 'UPSTREAM'),
      _ => map['error'] is String ? ChatErrorDto(code: map['error']! as String) : null,
    };
  }

  static ChatEventDto? _action(Map<String, Object?> map) {
    final tool = map['tool'];
    final args = map['args'];
    if (tool is! String || args is! Map<String, Object?>) return null;

    return ChatActionDto(tool: tool, args: args, needsConfirmation: map['confirm'] == true);
  }

  static List<String> _strings(Object? value) => [
    for (final item in (value as List<Object?>? ?? const [])) '$item',
  ];
}

final class const ChatDeltaDto({required final String text}) extends ChatEventDto;

final class const ChatDoneDto({required final List<String> options}) extends ChatEventDto;

final class const ChatActionDto({
  required final String tool,
  required final Map<String, Object?> args,
  required final bool needsConfirmation,
}) extends ChatEventDto;

final class const ChatErrorDto({required final String code}) extends ChatEventDto;
