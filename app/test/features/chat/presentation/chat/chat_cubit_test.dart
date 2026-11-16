import 'dart:async';

import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:app/features/chat/data/models/chat_action.dart';
import 'package:app/features/chat/data/models/chat_models.dart';
import 'package:app/features/chat/data/models/learned_item.dart';
import 'package:app/features/chat/data/repositories/chat_repository.dart';
import 'package:app/features/chat/data/repositories/learned_items_repository.dart';
import 'package:app/features/chat/presentation/chat/cubit/chat_cubit.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockChatRepository() extends Mock implements ChatRepository;

class _MockLearnedItemsRepository() extends Mock implements LearnedItemsRepository;

void main() {
  late ChatRepository repository;
  late LearnedItemsRepository learnedItemsRepository;

  setUpAll(() {
    registerFallbackValue(ChatMode.free);
    registerFallbackValue(LearnedTarget.partnerFact);
  });

  setUp(() {
    repository = _MockChatRepository();
    learnedItemsRepository = _MockLearnedItemsRepository();
    when(repository.getStatus)
        .thenAnswer((_) async => (messagesLeft: 5, limit: 20, isEnabled: true, hasPlus: true));
    when(repository.enable).thenAnswer((_) async {});
    when(() => repository.saveAsSlip(any())).thenAnswer((_) async {
      return;
    });
    when(
      () => learnedItemsRepository.add(
        target: any(named: 'target'),
        text: any(named: 'text'),
        excerpt: any(named: 'excerpt'),
      ),
    ).thenAnswer((_) async {
      return;
    });
  });

  void stubReply(Stream<ChatEvent> Function() events) {
    when(
      () => repository.send(
        message: any(named: 'message'),
        history: any(named: 'history'),
        locale: any(named: 'locale'),
        mode: any(named: 'mode'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((_) => events());
  }

  final actions = ChatActionRegistry();

  ChatCubit build() => ChatCubit(
    chatRepository: repository,
    learnedItemsRepository: learnedItemsRepository,
    actions: actions,
  );

  test('without the consent the chat asks first and sends nothing', () async {
    when(repository.getStatus)
        .thenAnswer((_) async => (messagesLeft: 5, limit: 20, isEnabled: false, hasPlus: true));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.stage, const Success(ChatStage.needsConsent));
  });

  test('turning it on reads the status again', () async {
    final cubit = build();

    await cubit.enable();

    verify(repository.enable).called(1);
    expect(cubit.state.stage, const Success(ChatStage.ready));
  });

  test('no messages left shows the limit', () async {
    when(repository.getStatus)
        .thenAnswer((_) async => (messagesLeft: 0, limit: 20, isEnabled: true, hasPlus: true));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.stage, const Success(ChatStage.limitReached));
  });

  test('the reply streams in, then offers the options', () async {
    stubReply(
      () => Stream.fromIterable([
        const ChatDelta('Oi, '),
        const ChatDelta('estou aqui.'),
        const ChatDone(['Estou cansada', 'Quero desabafar']),
      ]),
    );
    final cubit = build();
    await cubit.load();

    await cubit.send('Oi');

    expect(cubit.state.messages.last.text, 'Oi, estou aqui.');
    expect(cubit.state.messages.last.isStreaming, isFalse);
    expect(cubit.state.options, ['Estou cansada', 'Quero desabafar']);
    expect(cubit.state.messagesLeft, 4);
    expect(cubit.state.isReplying, isFalse);
  });

  test('a stream that breaks keeps what arrived and offers a retry', () async {
    stubReply(() async* {
      yield const ChatDelta('Parte da resposta');
      throw Exception('connection lost');
    });
    final cubit = build();
    await cubit.load();

    await cubit.send('Oi');

    expect(cubit.state.messages.last.isInterrupted, isTrue);
    expect(cubit.state.messages.last.text, 'Parte da resposta');
    expect(cubit.state.isReplying, isFalse);
  });

  test('the daily limit reached mid-chat locks the composer', () async {
    stubReply(() => Stream.value(const ChatError('CHAT_LIMIT')));
    final cubit = build();
    await cubit.load();

    await cubit.send('Oi');

    expect(cubit.state.stage, const Success(ChatStage.limitReached));
    expect(cubit.state.messages.where((m) => m.role == ChatRole.mascot), isEmpty);
  });

  test('an unconfigured server shows the unavailable stage', () async {
    stubReply(() => Stream.value(const ChatError('CHAT_UNAVAILABLE')));
    final cubit = build();
    await cubit.load();

    await cubit.send('Oi');

    expect(cubit.state.stage, const Success(ChatStage.unavailable));
  });

  test('a very long or empty message is not sent', () async {
    final cubit = build();
    await cubit.load();

    await cubit.send('   ');
    await cubit.send('a' * (chatMessageMaxLength + 1));

    expect(cubit.state.messages, isEmpty);
  });

  test('a reply can be saved as a slip', () async {
    stubReply(
      () => Stream.fromIterable([const ChatDelta('Um passo pequeno.'), const ChatDone([])]),
    );
    final cubit = build();
    await cubit.load();
    await cubit.send('Oi');

    await cubit.saveAsSlip(cubit.state.messages.last);

    verify(() => repository.saveAsSlip('Um passo pequeno.')).called(1);
  });

  test('a reply can be saved as a pending learning', () async {
    final cubit = build();

    await cubit.saveLearning(
      target: LearnedTarget.partnerFact,
      text: 'Prefere café sem açúcar',
      excerpt: 'Uma resposta da conversa',
    );

    verify(
      () => learnedItemsRepository.add(
        target: LearnedTarget.partnerFact,
        text: 'Prefere café sem açúcar',
        excerpt: 'Uma resposta da conversa',
      ),
    ).called(1);
  });

  test('a free person sees the Plus gate before the consent step', () async {
    when(repository.getStatus)
        .thenAnswer((_) async => (messagesLeft: 0, limit: 0, isEnabled: false, hasPlus: false));
    final cubit = build();

    await cubit.load();

    expect(cubit.state.stage, const Success(ChatStage.plusRequired));
    expect(cubit.state.hasPlus, isFalse);
  });

  test('retry resends the interrupted turn, not the latest message', () async {
    final sent = <String>[];
    when(
      () => repository.send(
        message: any(named: 'message'),
        history: any(named: 'history'),
        locale: any(named: 'locale'),
        mode: any(named: 'mode'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((invocation) {
      final message = invocation.namedArguments[#message] as String;
      sent.add(message);
      if (message == 'primeira') {
        return (() async* {
          yield const ChatDelta('Parte da primeira');
          throw Exception('connection lost');
        })();
      }

      return Stream.fromIterable([const ChatDelta('Segunda resposta'), const ChatDone([])]);
    });
    final cubit = build();
    await cubit.load();

    await cubit.send('primeira');
    final interrupted = cubit.state.messages.firstWhere((message) => message.isInterrupted);
    await cubit.send('segunda');
    await cubit.retry(interrupted);

    expect(sent, ['primeira', 'segunda', 'primeira']);
    expect(cubit.state.messages.where((message) => message.text == 'primeira'), hasLength(1));
    expect(cubit.state.messages.any((message) => message.text == 'segunda'), isTrue);
  });

  test('a stream that never closes is interrupted by the idle timeout', () async {
    final controller = StreamController<ChatEvent>();
    addTearDown(controller.close);
    when(
      () => repository.send(
        message: any(named: 'message'),
        history: any(named: 'history'),
        locale: any(named: 'locale'),
        mode: any(named: 'mode'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((_) => controller.stream);
    final cubit = ChatCubit(
      chatRepository: repository,
      learnedItemsRepository: learnedItemsRepository,
      actions: actions,
      idleTimeout: const Duration(milliseconds: 10),
    );
    await cubit.load();

    await cubit.send('Oi');

    expect(cubit.state.messages.last.isInterrupted, isTrue);
    expect(cubit.state.isReplying, isFalse);
  });

  test('the same session is sent with every message so the prompt cache can be reused', () async {
    final sessions = <String>[];
    when(
      () => repository.send(
        message: any(named: 'message'),
        history: any(named: 'history'),
        locale: any(named: 'locale'),
        mode: any(named: 'mode'),
        session: any(named: 'session'),
      ),
    ).thenAnswer((invocation) {
      sessions.add(invocation.namedArguments[#session] as String);

      return Stream.fromIterable([const ChatDelta('Oi'), const ChatDone([])]);
    });
    final cubit = build();
    await cubit.load();

    await cubit.send('Oi');
    await cubit.send('Tudo bem?');

    expect(sessions, hasLength(2));
    expect(sessions.toSet(), hasLength(1));
  });

  group('suggestions', () {
    var runs = 0;

    setUp(() {
      runs = 0;
      actions.register('ping', _Ping.new);
      _Ping.onRun = () => runs++;
    });

    Future<ChatCubit> withSuggestion(String tool) async {
      stubReply(
        () => Stream.fromIterable([
          const ChatDelta('Que tal?'),
          ChatSuggestion(tool: tool, args: const {'text': 'oi'}, needsConfirmation: true),
          const ChatDone([]),
        ]),
      );
      final cubit = build();
      await cubit.load();
      await cubit.send('Oi');

      return cubit;
    }

    test('a known tool becomes a card that waits for the person', () async {
      final cubit = await withSuggestion('ping');

      expect(cubit.state.messages.last.actions.single.status, ChatActionStatus.pending);
      expect(runs, 0);
    });

    test('a tool no feature handles leaves no card', () async {
      final cubit = await withSuggestion('unknown');

      expect(cubit.state.messages.last.actions, isEmpty);
    });

    test('running a card marks it done', () async {
      final cubit = await withSuggestion('ping');
      final id = cubit.state.messages.last.id;

      await cubit.runAction(id, 0);

      expect(runs, 1);
      expect(cubit.state.messages.last.actions.single.status, ChatActionStatus.done);
    });

    test('a failed card can be tried again', () async {
      _Ping.onRun = () => throw Exception('offline');
      final cubit = await withSuggestion('ping');
      final id = cubit.state.messages.last.id;

      await cubit.runAction(id, 0);
      expect(cubit.state.messages.last.actions.single.status, ChatActionStatus.failed);

      cubit.retryAction(id, 0);
      expect(cubit.state.messages.last.actions.single.status, ChatActionStatus.pending);
    });

    test('a dismissed card is not run', () async {
      final cubit = await withSuggestion('ping');
      final id = cubit.state.messages.last.id;

      cubit.dismissAction(id, 0);
      await cubit.runAction(id, 0);

      expect(runs, 0);
      expect(cubit.state.messages.last.actions.single.status, ChatActionStatus.dismissed);
    });
  });
}

class _Ping() extends TypedChatActionHandler<String> {
  static void Function() onRun = () {};

  @override
  String get tool => 'ping';

  @override
  String? parse(Map<String, Object?> args) => args['text'] as String?;

  @override
  Future<void> run(String args) async => onRun();
}
