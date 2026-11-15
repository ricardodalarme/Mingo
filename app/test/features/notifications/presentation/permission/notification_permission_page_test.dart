import 'dart:async';

import 'package:app/features/notifications/data/repositories/notifications_repository.dart';
import 'package:app/features/notifications/presentation/permission/cubit/notification_permission_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockNotificationsRepository() extends Mock implements NotificationsRepository;

class _TestRouter() extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: NotFoundRoute.page, initial: true),
    AutoRoute(page: NotificationPermissionRoute.page, fullscreenDialog: true),
  ];
}

void main() {
  late NotificationsRepository repository;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    repository = _MockNotificationsRepository();
    when(() => repository.requestAccess()).thenAnswer((_) async => NotificationAccess.granted);
    when(repository.registerDevice).thenAnswer((_) async {
      return;
    });
    AppInjector.instance.registerFactory<NotificationPermissionCubit>(
      () => NotificationPermissionCubit(repository: repository),
    );
    addTearDown(() => AppInjector.instance.unregister<NotificationPermissionCubit>());
  });

  Future<_TestRouter> openPage(WidgetTester tester) async {
    final router = _TestRouter();
    await tester.pumpWidget(
      TranslationProvider(
        child: AppThemeHost(
          initialVariant: AppThemeVariant.rose,
          child: Builder(
            builder: (context) => BaseApp.router(
              routerConfig: router.config(),
              theme: AppTheme.light(AppThemeScope.of(context)),
              supportedLocales: AppLocaleUtils.supportedLocales,
            ),
          ),
        ),
      ),
    );
    unawaited(router.push(const NotificationPermissionRoute()));
    await tester.pumpAndSettle();

    return router;
  }

  testWidgets('offers a retry and a way out when the registration times out', (tester) async {
    when(repository.registerDevice).thenAnswer((_) => Completer<void>().future);
    final router = await openPage(tester);

    await tester.tap(find.text('Permitir'));
    await tester.pump();

    expect(find.text('Tentar de novo'), findsNothing);
    expect(router.stack.map((route) => route.name), contains(NotificationPermissionRoute.name));

    await tester.pump(const Duration(seconds: 8));
    await tester.pump();

    expect(find.text('Tentar de novo'), findsOneWidget);
    expect(find.text('Seguir sem lembretes'), findsOneWidget);
    expect(router.stack.map((route) => route.name), contains(NotificationPermissionRoute.name));
  });

  testWidgets('a granted permission that registers closes the page', (tester) async {
    final router = await openPage(tester);

    await tester.tap(find.text('Permitir'));
    await tester.pump();
    await tester.pump();

    expect(
      router.stack.map((route) => route.name),
      isNot(contains(NotificationPermissionRoute.name)),
    );
    verify(() => repository.registerDevice()).called(1);
  });

  testWidgets('a retry registers the device again', (tester) async {
    when(repository.registerDevice).thenAnswer((_) => Completer<void>().future);
    await openPage(tester);
    await tester.tap(find.text('Permitir'));
    await tester.pump(const Duration(seconds: 8));
    await tester.pump();

    await tester.tap(find.text('Tentar de novo'));
    await tester.pump();

    verify(() => repository.registerDevice()).called(2);
    expect(find.text('Seguir sem lembretes'), findsOneWidget);

    await tester.pump(const Duration(seconds: 8));
    await tester.pump();

    expect(find.text('Tentar de novo'), findsOneWidget);
  });

  testWidgets('continuing without reminders closes the page', (tester) async {
    when(repository.registerDevice).thenThrow(const LocalizedException(l10nKey: 'registerDevice'));
    final router = await openPage(tester);

    await tester.tap(find.text('Permitir'));
    await tester.pump();

    await tester.tap(find.text('Seguir sem lembretes'));
    await tester.pumpAndSettle();

    expect(
      router.stack.map((route) => route.name),
      isNot(contains(NotificationPermissionRoute.name)),
    );
  });

  testWidgets('a denial closes the page without registering', (tester) async {
    when(() => repository.requestAccess()).thenAnswer((_) async => NotificationAccess.denied);
    final router = await openPage(tester);

    await tester.tap(find.text('Permitir'));
    await tester.pumpAndSettle();

    expect(
      router.stack.map((route) => route.name),
      isNot(contains(NotificationPermissionRoute.name)),
    );
    verifyNever(() => repository.registerDevice());
  });
}
