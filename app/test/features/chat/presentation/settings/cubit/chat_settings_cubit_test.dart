import 'package:app/features/chat/data/repositories/chat_repository.dart';
import 'package:app/features/chat/presentation/settings/cubit/chat_settings_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockChatRepository() extends Mock implements ChatRepository;

void main() {
  late ChatRepository repository;

  setUp(() {
    repository = _MockChatRepository();
    when(repository.getStatus).thenAnswer((_) async => (messagesLeft: 4, limit: 20, hasPlus: true));
  });

  ChatSettingsCubit build() => ChatSettingsCubit(chatRepository: repository);

  test('load reads today usage', () async {
    final cubit = build();

    await cubit.load();

    expect(cubit.state.status, const Success<void>(null));
    expect(cubit.state.messagesLeft, 4);
    expect(cubit.state.limit, 20);
    expect(cubit.state.hasPlus, isTrue);
  });

  test('a failed load offers the retry state', () async {
    when(repository.getStatus).thenThrow(Exception('offline'));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.status, isA<Failure>());
  });
}
