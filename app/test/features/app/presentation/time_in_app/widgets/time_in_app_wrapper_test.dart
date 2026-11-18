import 'dart:async';

import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/time_in_app/cubit/time_in_app_cubit.dart';
import 'package:app/features/app/presentation/time_in_app/widgets/time_in_app_wrapper.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAppCubit() extends MockCubit<AppState> implements AppCubit;

class _MockTimeInAppCubit() extends MockCubit<TimeInAppState> implements TimeInAppCubit;

class _TestRouter() extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: NotFoundRoute.page, initial: true),
    AutoRoute(page: TimeInAppRoute.page, fullscreenDialog: true),
  ];
}

void main() {
  late AppCubit appCubit;
  late TimeInAppCubit timeInAppCubit;
  late StreamController<TimeInAppState> timeStates;

  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.pt));

  setUp(() {
    appCubit = _MockAppCubit();
    timeInAppCubit = _MockTimeInAppCubit();
    timeStates = StreamController<TimeInAppState>.broadcast();
    whenListen(timeInAppCubit, timeStates.stream, initialState: const TimeInAppState());
    AppInjector.instance.registerFactory<TimeInAppCubit>(() => timeInAppCubit);
  });

  tearDown(() async {
    AppInjector.instance.unregister<TimeInAppCubit>();
    await timeStates.close();
    await timeInAppCubit.close();
  });

  Future<void> pumpWrapper(
    WidgetTester tester,
    RootStackRouter router, {
    required AppState appState,
  }) {
    whenListen(appCubit, const Stream<AppState>.empty(), initialState: appState);

    return tester.pumpWidget(
      TranslationProvider(
        child: AppThemeHost(
          initialVariant: AppThemeVariant.rose,
          child: BlocProvider.value(
            value: appCubit,
            child: Builder(
              builder: (context) => BaseApp.router(
                routerConfig: router.config(),
                theme: AppTheme.light(AppThemeScope.of(context)),
                supportedLocales: AppLocaleUtils.supportedLocales,
                builder: (context, child) =>
                    TimeInAppWrapper(router: router, child: child ?? const SizedBox.shrink()),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> settle(WidgetTester tester) async {
    for (var index = 0; index < 6; index++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  int promptCount(RootStackRouter router) =>
      router.stack.where((route) => route.name == TimeInAppRoute.name).length;

  testWidgets('prompts once when authenticated', (tester) async {
    final router = _TestRouter();
    await pumpWrapper(tester, router, appState: AppState.authenticated);

    timeStates.add(const TimeInAppState(shouldPrompt: true));
    await settle(tester);

    expect(promptCount(router), 1);
  });

  testWidgets('does not prompt while unauthenticated', (tester) async {
    final router = _TestRouter();
    await pumpWrapper(tester, router, appState: AppState.unauthenticated);

    timeStates.add(const TimeInAppState(shouldPrompt: true));
    await settle(tester);

    expect(promptCount(router), 0);
  });

  testWidgets('does not prompt again for the same request', (tester) async {
    final router = _TestRouter();
    await pumpWrapper(tester, router, appState: AppState.authenticated);

    timeStates.add(const TimeInAppState(shouldPrompt: true));
    await settle(tester);
    timeStates.add(const TimeInAppState());
    await settle(tester);
    timeStates.add(const TimeInAppState(shouldPrompt: true));
    await settle(tester);

    expect(promptCount(router), 1);
  });

  testWidgets('pushes on the injected router', (tester) async {
    final router = _TestRouter();
    final fallbackRouter = _TestRouter();
    AppInjector.instance.registerFactory<RootStackRouter>(() => fallbackRouter);
    addTearDown(() => AppInjector.instance.unregister<RootStackRouter>());
    await pumpWrapper(tester, router, appState: AppState.authenticated);

    timeStates.add(const TimeInAppState(shouldPrompt: true));
    await settle(tester);

    expect(promptCount(router), 1);
    expect(promptCount(fallbackRouter), 0);
  });

  testWidgets('starts the cubit once', (tester) async {
    await pumpWrapper(tester, _TestRouter(), appState: AppState.authenticated);
    await tester.pump();

    verify(() => timeInAppCubit.start()).called(1);
  });
}
