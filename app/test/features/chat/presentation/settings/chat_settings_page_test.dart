import 'package:app/features/chat/data/repositories/chat_repository.dart';
import 'package:app/features/chat/presentation/settings/chat_settings_page.dart';
import 'package:app/features/chat/presentation/settings/cubit/chat_settings_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../test_helpers/pump_app.dart';

class _MockChatRepository() extends Mock implements ChatRepository;

void main() {
  late ChatRepository repository;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockChatRepository();
    when(repository.getStatus).thenAnswer((_) async => (messagesLeft: 4, limit: 20, hasPlus: true));
  });

  Future<ChatSettingsCubit> pumpSettings(WidgetTester tester) async {
    final cubit = ChatSettingsCubit(chatRepository: repository);
    addTearDown(cubit.close);
    await cubit.load();
    await tester.pumpApp(BlocProvider.value(value: cubit, child: const ChatSettingsPage()));
    await tester.pump();
    return cubit;
  }

  testWidgets('shows the usage and what is sent', (tester) async {
    await pumpSettings(tester);

    expect(find.text('Restam 4 de 20 mensagens hoje'), findsOneWidget);
    expect(find.text('O que é enviado'), findsOneWidget);
  });

  testWidgets('a free plan sees its plan and no message count', (tester) async {
    when(repository.getStatus).thenAnswer((_) async => (messagesLeft: 0, limit: 0, hasPlus: false));
    await pumpSettings(tester);

    expect(find.text('Plano gratuito'), findsOneWidget);
    expect(
      find.text('A conversa faz parte do Plus. O plano gratuito não tem mensagens.'),
      findsOneWidget,
    );
  });

  testWidgets('a failed load offers a retry', (tester) async {
    when(repository.getStatus).thenThrow(Exception('offline'));
    final cubit = ChatSettingsCubit(chatRepository: repository);
    addTearDown(cubit.close);
    await cubit.load();

    await tester.pumpApp(BlocProvider.value(value: cubit, child: const ChatSettingsPage()));
    await tester.pump();

    expect(find.text('Não deu para carregar'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
  });
}
