/// One earlier turn sent along with a message.
final class const ChatTurnDto({required final String role, required final String text}) {
  Map<String, Object?> toMap() => {'role': role, 'text': text};
}

/// The body of a message sent to the chat function.
final class const ChatRequestDto({
  required final String message,
  required final String locale,
  required final String mode,
  required final String session,
  required final List<ChatTurnDto> history,
  final bool actions = true,
}) {
  Map<String, Object?> toMap() => {
    'message': message,
    'locale': locale,
    'mode': mode,
    'session': session,
    'actions': actions,
    'history': [for (final turn in history) turn.toMap()],
  };
}
