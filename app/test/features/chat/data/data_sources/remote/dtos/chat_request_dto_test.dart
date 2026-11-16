import 'package:app/features/chat/data/data_sources/remote/dtos/chat_request_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('toMap writes the body the chat function reads', () {
    const request = ChatRequestDto(
      message: 'oi',
      locale: 'pt-BR',
      mode: 'free',
      session: 's1',
      history: [ChatTurnDto(role: 'user', text: 'antes')],
    );

    expect(request.toMap(), {
      'message': 'oi',
      'locale': 'pt-BR',
      'mode': 'free',
      'session': 's1',
      'actions': true,
      'history': [
        {'role': 'user', 'text': 'antes'},
      ],
    });
  });
}
