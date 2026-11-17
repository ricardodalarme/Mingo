import 'package:app/features/mood/data/models/mood_entry.dart';
import 'package:app/features/mood/data/models/mood_kind.dart';
import 'package:app/features/mood/data/models/mood_share.dart';
import 'package:app/features/mood/data/repositories/mood_repository.dart';
import 'package:app/features/mood/presentation/calendar/cubit/mood_calendar_cubit.dart';
import 'package:app/features/mood/presentation/calendar/mood_calendar_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network/network.dart';

class _MockMoodRepository() extends Mock implements MoodRepository;

class _MockStackRouter() extends Mock implements StackRouter;

void main() {
  late MoodRepository repository;

  final now = DateTime(2026, 11, 16, 21, 30);
  final entry = MoodEntry(
    id: 'm1',
    day: DateTime(2026, 11, 10),
    mood: MoodKind.tired,
    share: MoodShare.none,
  );

  setUpAll(() {
    LocaleSettings.setLocaleSync(AppLocale.pt);
    registerFallbackValue(MoodRoute());
  });

  setUp(() {
    repository = _MockMoodRepository();
    when(() => repository.getMonthMoods(month: any(named: 'month')))
        .thenAnswer((_) async => [entry]);
  });

  Future<void> pumpPage(WidgetTester tester, MoodCalendarCubit cubit) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: AppThemeHost(
          initialVariant: AppThemeVariant.rose,
          child: Builder(
            builder: (context) => BaseApp(
              home: BlocProvider.value(value: cubit, child: const MoodCalendarPage()),
              theme: AppTheme.light(AppThemeScope.of(context)),
              supportedLocales: AppLocaleUtils.supportedLocales,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the month and marks the days that have a mood', (tester) async {
    final cubit = MoodCalendarCubit(moodRepository: repository);
    addTearDown(cubit.close);

    await withClock(Clock.fixed(now), cubit.load);
    await pumpPage(tester, cubit);

    expect(find.text('Meus humores'), findsOneWidget);
    expect(find.text('novembro de 2026'), findsOneWidget);

    final calendar = tester.widget<BaseCompactCalendar>(find.byType(BaseCompactCalendar));
    expect(calendar.marked, {DateTime(2026, 11, 10)});
    expect(calendar.month, DateTime(2026, 11));
  });

  testWidgets('a month with nothing says so and keeps the grid', (tester) async {
    when(() => repository.getMonthMoods(month: any(named: 'month'))).thenAnswer((_) async => []);
    final cubit = MoodCalendarCubit(moodRepository: repository);
    addTearDown(cubit.close);

    await withClock(Clock.fixed(now), cubit.load);
    await pumpPage(tester, cubit);

    expect(find.text('Nenhum humor neste mês ainda.'), findsOneWidget);
    expect(find.byType(BaseCompactCalendar), findsOneWidget);
    expect(
      find.text(
        'Só você vê isto. Não aparece para o parceiro, a menos que seja compartilhado por dia.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('a failed read offers a retry that reads again', (tester) async {
    when(() => repository.getMonthMoods(month: any(named: 'month')))
        .thenThrow(const LocalizedException(l10nKey: networkErrorCode));
    final cubit = MoodCalendarCubit(moodRepository: repository);
    addTearDown(cubit.close);

    await withClock(Clock.fixed(now), cubit.load);
    await pumpPage(tester, cubit);

    expect(find.text('Não deu para abrir seus humores'), findsOneWidget);

    when(() => repository.getMonthMoods(month: any(named: 'month')))
        .thenAnswer((_) async => [entry]);
    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();

    expect(find.text('Não deu para abrir seus humores'), findsNothing);
    expect(find.byType(BaseCompactCalendar), findsOneWidget);
  });

  testWidgets('the footer opens the mood card', (tester) async {
    final router = _MockStackRouter();
    when(() => router.push<Object?>(any(), onFailure: any(named: 'onFailure')))
        .thenAnswer((_) async => null);
    final cubit = MoodCalendarCubit(moodRepository: repository);
    addTearDown(cubit.close);

    await withClock(Clock.fixed(now), cubit.load);
    await tester.pumpWidget(
      StackRouterScope(
        controller: router,
        stateHash: 0,
        child: TranslationProvider(
          child: AppThemeHost(
            initialVariant: AppThemeVariant.rose,
            child: Builder(
              builder: (context) => BaseApp(
                home: BlocProvider.value(value: cubit, child: const MoodCalendarPage()),
                theme: AppTheme.light(AppThemeScope.of(context)),
                supportedLocales: AppLocaleUtils.supportedLocales,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Registrar meu humor'));
    await tester.pump();

    final route = verify(
      () => router.push<Object?>(captureAny(), onFailure: any(named: 'onFailure')),
    ).captured.single;
    expect(route, isA<MoodRoute>());
  });
}
