import 'dart:async';

import 'package:app/features/app/presentation/connectivity/cubit/connectivity_cubit.dart';
import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/shell/app_shell.dart';
import 'package:app/features/app/presentation/time_in_app/cubit/time_in_app_cubit.dart';
import 'package:app/features/app/presentation/version/cubit/version_gate_cubit.dart';
import 'package:app/features/app/presentation/version/update_required_page.dart';
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

class _MockVersionGateCubit() extends MockCubit<VersionGateState> implements VersionGateCubit;

class _MockConnectivityCubit() extends MockCubit<ConnectivityState> implements ConnectivityCubit;

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
  late VersionGateCubit versionGateCubit;
  late StreamController<VersionGateState> versionStates;
  late ConnectivityCubit connectivityCubit;
  late StreamController<ConnectivityState> connectivityStates;

  setUp(() {
    appCubit = _MockAppCubit();
    timeInAppCubit = _MockTimeInAppCubit();
    timeStates = StreamController<TimeInAppState>.broadcast();
    versionGateCubit = _MockVersionGateCubit();
    versionStates = StreamController<VersionGateState>.broadcast();
    connectivityCubit = _MockConnectivityCubit();
    connectivityStates = StreamController<ConnectivityState>.broadcast();

    whenListen(timeInAppCubit, timeStates.stream, initialState: const TimeInAppState());
    whenListen(versionGateCubit, versionStates.stream, initialState: const VersionGateState());
    when(() => versionGateCubit.check()).thenAnswer((_) async {});
    AppInjector.instance.registerFactory<TimeInAppCubit>(() => timeInAppCubit);
    AppInjector.instance.registerFactory<VersionGateCubit>(() => versionGateCubit);
  });

  tearDown(() async {
    AppInjector.instance.unregister<TimeInAppCubit>();
    AppInjector.instance.unregister<VersionGateCubit>();
    await timeStates.close();
    await versionStates.close();
    await connectivityStates.close();
    await versionGateCubit.close();
    await connectivityCubit.close();
  });

  void stubConnectivity({bool? isOnline = true}) {
    whenListen(
      connectivityCubit,
      connectivityStates.stream,
      initialState: ConnectivityState(isOnline: isOnline),
    );
  }

  Future<void> pumpShell(
    WidgetTester tester,
    RootStackRouter router, {
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return tester.pumpWidget(
      TranslationProvider(
        child: AppThemeHost(
          initialVariant: AppThemeVariant.rose,
          child: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: appCubit),
              BlocProvider.value(value: connectivityCubit),
            ],
            child: Builder(
              builder: (context) => BaseApp.router(
                routerConfig: router.config(),
                theme: AppTheme.light(AppThemeScope.of(context)),
                supportedLocales: AppLocaleUtils.supportedLocales,
                builder: (context, child) => MediaQuery(
                  data: MediaQuery.of(context).copyWith(padding: padding, viewPadding: padding),
                  child: AppShell(router: router, child: child ?? const SizedBox.shrink()),
                ),
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

  MediaQueryData mediaOf(WidgetTester tester, Finder finder) =>
      MediaQuery.of(tester.element(finder));

  String offlineCopy(WidgetTester tester) =>
      tester.element(find.byType(AppShell)).l10n.globalErrors.offline;

  Future<void> dropConnection(WidgetTester tester) async {
    connectivityStates.add(const ConnectivityState(isOnline: false));
    await tester.pump();
    await tester.pump();
  }

  Future<void> endToast(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 4));
    await tester.pump();
  }

  group('offline toast', () {
    const padding = EdgeInsets.only(top: 59, bottom: 34);

    setUp(() {
      whenListen(appCubit, const Stream<AppState>.empty(), initialState: AppState.authenticated);
    });

    testWidgets('shows the copy when the connection drops', (tester) async {
      stubConnectivity();
      await pumpShell(tester, _TestRouter());
      await tester.pump();

      await dropConnection(tester);

      expect(find.text(offlineCopy(tester)), findsOneWidget);
      await endToast(tester);
    });

    testWidgets('shows the copy when the app starts offline', (tester) async {
      stubConnectivity(isOnline: null);
      await pumpShell(tester, _TestRouter());
      await tester.pump();

      expect(find.text(offlineCopy(tester)), findsNothing);

      await dropConnection(tester);

      expect(find.text(offlineCopy(tester)), findsOneWidget);
      await endToast(tester);
    });

    testWidgets('shows nothing while online', (tester) async {
      stubConnectivity();
      await pumpShell(tester, _TestRouter());
      await settle(tester);

      expect(find.text(offlineCopy(tester)), findsNothing);
    });

    testWidgets('shows the copy again after the connection comes back and drops', (tester) async {
      stubConnectivity();
      await pumpShell(tester, _TestRouter());
      await dropConnection(tester);
      await endToast(tester);

      connectivityStates.add(const ConnectivityState(isOnline: true));
      await tester.pump();
      expect(find.text(offlineCopy(tester)), findsNothing);

      await dropConnection(tester);

      expect(find.text(offlineCopy(tester)), findsOneWidget);
      await endToast(tester);
    });

    testWidgets('does not restart the toast on a repeated offline state', (tester) async {
      stubConnectivity();
      await pumpShell(tester, _TestRouter());
      await dropConnection(tester);

      await tester.pump(const Duration(seconds: 3));
      await dropConnection(tester);
      await tester.pump(const Duration(milliseconds: 1100));

      expect(find.text(offlineCopy(tester)), findsNothing);
    });

    testWidgets('leaves the navigator top padding alone', (tester) async {
      stubConnectivity();
      await pumpShell(tester, _TestRouter(), padding: padding);
      await dropConnection(tester);

      expect(find.text(offlineCopy(tester)), findsOneWidget);
      expect(mediaOf(tester, find.byType(Navigator)).padding, padding);
      await endToast(tester);
    });
  });

  group('forced update', () {
    const padding = EdgeInsets.only(top: 59, bottom: 34);

    setUp(() {
      whenListen(appCubit, const Stream<AppState>.empty(), initialState: AppState.authenticated);
    });

    testWidgets('replaces everything, so neither the toast nor the prompt runs', (tester) async {
      stubConnectivity();
      final router = _TestRouter();
      await pumpShell(tester, router, padding: padding);
      versionStates.add(const VersionGateState(updateRequired: true));
      await settle(tester);

      expect(find.byType(UpdateRequiredPage), findsOneWidget);

      connectivityStates.add(const ConnectivityState(isOnline: false));
      timeStates.add(const TimeInAppState(shouldPrompt: true));
      await settle(tester);

      expect(find.text(offlineCopy(tester)), findsNothing);
      expect(router.stack.map((route) => route.name), isNot(contains(TimeInAppRoute.name)));
      expect(mediaOf(tester, find.byType(UpdateRequiredPage)).padding, padding);
    });
  });
}
