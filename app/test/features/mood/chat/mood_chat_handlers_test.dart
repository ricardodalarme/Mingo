import 'package:app/features/mood/chat/mood_chat_handlers.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

void main() {
  late MoodRepository repository;

  setUp(() {
    repository = _MockMoodRepository();
    when(
      () => repository.saveMood(
        mood: any(named: 'mood'),
        share: any(named: 'share'),
      ),
    ).thenAnswer((_) async => throw UnimplementedError());
  });

  test('log_mood keeps the mood private', () async {
    final prepared = LogMoodChatHandler(repository: repository).prepare(const {'mood': 'tired'})!;

    expect(prepared.valueKey, 'tired');
    await expectLater(prepared.run(), throwsA(isA<UnimplementedError>()));
    verify(() => repository.saveMood(mood: MoodKind.tired, share: MoodShare.none)).called(1);
  });

  test('share_mood shares it with the partner', () async {
    final prepared = ShareMoodChatHandler(repository: repository).prepare(const {'mood': 'happy'})!;

    await expectLater(prepared.run(), throwsA(isA<UnimplementedError>()));
    verify(() => repository.saveMood(mood: MoodKind.happy, share: MoodShare.mood)).called(1);
  });

  test('an unknown mood has no card', () {
    expect(LogMoodChatHandler(repository: repository).prepare(const {'mood': 'angry'}), isNull);
  });
}
