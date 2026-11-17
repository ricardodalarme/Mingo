import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/mood/cubit/mood_cubit.dart';
import 'package:app/features/notifications/data/repositories/inbox_repository.dart';
import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/notifications/presentation/bell/cubit/inbox_badge_cubit.dart';
import 'package:app/features/notifications/presentation/off_banner/cubit/notifications_off_cubit.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/features/today/data/models/today_home.dart';
import 'package:app/features/today/presentation/today/widgets/today_content.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../test_helpers/pump_app.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

class _MockSlipRepository() extends Mock implements SlipRepository;

class _MockInboxRepository() extends Mock implements InboxRepository;

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  late MoodCubit mood;
  late InboxRepository inbox;

  setUp(() {
    final moodRepository = _MockMoodRepository();
    final slips = _MockSlipRepository();
    when(moodRepository.readCachedTodayMood).thenReturn(null);
    when(moodRepository.getTodayMood).thenAnswer(
      (_) async => (entry: null, partnerMood: null, partnerName: 'Luanna', hasPartner: true),
    );
    mood = MoodCubit(moodRepository: moodRepository, slipRepository: slips);

    inbox = _MockInboxRepository();
    when(inbox.watchUnreadCount).thenAnswer((_) => const Stream.empty());

    final notifications = _MockNotificationsRepository();
    when(notifications.currentAccess).thenAnswer((_) async => NotificationAccess.granted);
    AppInjector.instance.registerFactory<NotificationsOffCubit>(
      () => NotificationsOffCubit(repository: notifications),
    );
  });

  tearDown(() {
    AppInjector.instance.unregister<NotificationsOffCubit>();
    return mood.close();
  });

  Future<void> pump(
    WidgetTester tester,
    TodayHome home, {
    bool isFirstDay = false,
    bool isSoloOnly = false,
    bool isInConflict = false,
    bool isOffline = false,
    String? partnerHint,
  }) async {
    final badge = InboxBadgeCubit(inboxRepository: inbox)..start();
    addTearDown(badge.close);
    await mood.load();

    await tester.pumpApp(
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: mood),
          BlocProvider.value(value: badge),
        ],
        child: SingleChildScrollView(
          child: TodayContent(
            home: home,
            selfName: 'Luanna',
            partnerHint: partnerHint,
            isFirstDay: isFirstDay,
            isSoloOnly: isSoloOnly,
            isInConflict: isInConflict,
            isOffline: isOffline,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  double yOf(WidgetTester tester, String text) =>
      tester.getTopLeft(find.textContaining(text, findRichText: true).first).dy;

  TodayHome home({
    bool isPaired = true,
    int unopenedCards = 0,
    int slipsThisWeek = 3,
    bool hasPendingInvite = false,
    Suggestion? question = const Suggestion(slug: 'mania', title: 'Qual é uma mania dele?'),
  }) => TodayHome(
    isPaired: isPaired,
    unopenedCards: unopenedCards,
    slipsThisWeek: slipsThisWeek,
    slipsTotal: slipsThisWeek,
    hasPendingInvite: hasPendingInvite,
    hasPlus: false,
    partnerName: 'Luanna',
    question: question,
    idea: const Suggestion(slug: 'bilhete', title: 'Deixe um bilhete'),
  );

  testWidgets('connected reads mood, question, the note, the week and para hoje in order', (
    tester,
  ) async {
    await pump(tester, home());

    expect(yOf(tester, 'Como você está?'), lessThan(yOf(tester, 'Qual é uma')));
    expect(yOf(tester, 'Qual é uma'), lessThan(yOf(tester, 'Nenhum cartão novo. Sem pressa.')));
    expect(
      yOf(tester, 'Nenhum cartão novo. Sem pressa.'),
      lessThan(yOf(tester, '3 slips esta semana')),
    );
    expect(yOf(tester, '3 slips esta semana'), lessThan(yOf(tester, 'Para hoje')));
  });

  testWidgets('on your own the invite comes after the week and no question is fixed', (
    tester,
  ) async {
    await pump(tester, home(isPaired: false, question: null), partnerHint: 'Rui');

    expect(find.text('Como você está?'), findsOneWidget);
    expect(yOf(tester, 'Seus slips privados'), lessThan(yOf(tester, 'Convidar Rui')));
    expect(yOf(tester, 'Convidar Rui'), lessThan(yOf(tester, 'Para hoje')));
    expect(find.text('Já tenho um código'), findsNothing);
  });

  testWidgets('the first day keeps the mood, the question and the invite card out', (tester) async {
    await pump(tester, home(isPaired: false, slipsThisWeek: 1), isFirstDay: true);

    expect(find.text('BOM COMEÇO'), findsOneWidget);
    expect(find.text('Como você está?'), findsNothing);
    expect(find.text('CONVITE'), findsNothing);
    expect(yOf(tester, 'BOM COMEÇO'), lessThan(yOf(tester, '1 slip esta semana')));
    expect(yOf(tester, '1 slip esta semana'), lessThan(yOf(tester, 'Para hoje')));
  });

  testWidgets('an empty week shows the week and only the question after it', (tester) async {
    await pump(tester, home(slipsThisWeek: 0));

    expect(yOf(tester, 'Nenhum slip ainda'), lessThan(yOf(tester, 'Qual foi uma coisa')));
    expect(find.text('Para hoje'), findsNothing);
  });

  testWidgets('a pending invite keeps the mood, the week and the ideas under the notice', (
    tester,
  ) async {
    await pump(tester, home(isPaired: false, hasPendingInvite: true));

    expect(find.text('CONVITE ENVIADO'), findsOneWidget);
    expect(find.text('Como você está?'), findsOneWidget);
    expect(find.text('Para hoje'), findsOneWidget);
    expect(find.text('Convidar Rui'), findsNothing);
  });

  testWidgets('a fight answer keeps the screen to the repair and the conversation', (tester) async {
    await pump(tester, home(), isInConflict: true);

    expect(find.textContaining('Primeiro,', findRichText: true), findsOneWidget);
    expect(find.text('Como você está?'), findsNothing);
    expect(find.text('Para hoje'), findsNothing);
  });

  testWidgets('offline says so once and keeps the saved week', (tester) async {
    await pump(tester, home(), isOffline: true);

    expect(find.textContaining('Sem conexão'), findsOneWidget);
    expect(find.text('Os lembretes estão desligados. Ligue nas configurações.'), findsNothing);
    expect(find.text('3 slips esta semana'), findsOneWidget);
  });

  testWidgets('Hoje never shows a count of what waits', (tester) async {
    await pump(tester, home(unopenedCards: 3));

    expect(find.textContaining('3 novos'), findsNothing);
    expect(find.textContaining('pendente'), findsNothing);
  });
}
