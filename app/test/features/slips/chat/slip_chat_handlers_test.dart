import 'package:app/features/slips/chat/slip_chat_handlers.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockSlipRepository() extends Mock implements SlipRepository;

void main() {
  late SlipRepository repository;

  setUp(() => repository = _MockSlipRepository());

  test('create_private_slip trims the body and shows it on the card', () {
    final prepared = CreatePrivateSlipChatHandler(repository: repository)
        .prepare(const {'body': '  fez café  '})!;

    expect(prepared.text, 'fez café');
  });

  test('a blank body has no card', () {
    expect(
      SendSlipToPartnerChatHandler(repository: repository).prepare(const {'body': ' '}),
      isNull,
    );
  });
}
