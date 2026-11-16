import 'package:app/features/chat/data/data_sources/remote/chat_data_source.dart';
import 'package:app/features/chat/data/data_sources/remote/dtos/chat_event_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseChatLine', () {
    test('reads delta, done and error events', () {
      expect(
        parseChatLine('data: {"type":"delta","text":"oi"}'),
        isA<ChatDeltaDto>().having((e) => e.text, 'text', 'oi'),
      );
      expect(
        parseChatLine('data: {"type":"done","options":["a","b"]}'),
        isA<ChatDoneDto>().having((e) => e.options, 'options', ['a', 'b']),
      );
      expect(
        parseChatLine('data: {"type":"error","code":"CHAT_LIMIT"}'),
        isA<ChatErrorDto>().having((e) => e.code, 'code', 'CHAT_LIMIT'),
      );
    });

    test('reads an action with its tool, arguments and confirmation rule', () {
      final event = parseChatLine(
        'data: {"type":"action","tool":"share_mood","args":{"mood":"happy"},"confirm":true}',
      );

      expect(
        event,
        isA<ChatActionDto>()
            .having((e) => e.tool, 'tool', 'share_mood')
            .having((e) => e.args, 'args', {'mood': 'happy'})
            .having((e) => e.needsConfirmation, 'needsConfirmation', isTrue),
      );
    });

    test('an action without arguments is ignored', () {
      expect(parseChatLine('data: {"type":"action","tool":"log_mood"}'), isNull);
    });

    test('a plain error body becomes an error event', () {
      expect(
        parseChatLine('{"error":"UNAUTHORIZED"}'),
        isA<ChatErrorDto>().having((e) => e.code, 'code', 'UNAUTHORIZED'),
      );
    });

    test('blank lines and noise are ignored', () {
      expect(parseChatLine(''), isNull);
      expect(parseChatLine('data: not json'), isNull);
    });
  });
}
