import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:flutter_test/flutter_test.dart';

class _Echo() extends TypedChatActionHandler<String> {
  int runs = 0;

  @override
  String get tool => 'echo';

  @override
  String? parse(Map<String, Object?> args) => args['text'] as String?;

  @override
  String? text(String args) => args;

  @override
  Future<void> run(String args) async => runs++;
}

void main() {
  test('an unknown tool has no card', () {
    expect(ChatActionRegistry().prepare('nope', const {}), isNull);
  });

  test('invalid arguments have no card', () {
    final registry = ChatActionRegistry()..register('echo', _Echo.new);

    expect(registry.prepare('echo', const {}), isNull);
  });

  test('a handler is built once, on first use, and runs the typed action', () async {
    var built = 0;
    final handler = _Echo();
    final registry = ChatActionRegistry()
      ..register('echo', () {
        built++;

        return handler;
      });
    expect(built, 0);

    final prepared = registry.prepare('echo', const {'text': 'oi'})!;
    registry.prepare('echo', const {'text': 'de novo'});
    await prepared.run();

    expect(built, 1);
    expect(prepared.text, 'oi');
    expect(handler.runs, 1);
  });
}
