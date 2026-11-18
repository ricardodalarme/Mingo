import 'dart:async';

import 'package:app/features/app/presentation/connectivity/cubit/connectivity_cubit.dart';
import 'package:app/features/app/presentation/connectivity/widgets/connectivity_wrapper.dart';
import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/shell/app_shell.dart';
import 'package:app/features/app/presentation/time_in_app/cubit/time_in_app_cubit.dart';
import 'package:app/features/app/presentation/time_in_app/widgets/time_in_app_wrapper.dart';
import 'package:app/features/app/presentation/version/cubit/version_gate_cubit.dart';
import 'package:app/features/app/presentation/version/update_required_page.dart';
import 'package:app/features/app/presentation/version/widgets/update_app_wrapper.dart';
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
    whenListen(
      connectivityCubit,
      connectivityStates.stream,
      initialState: const ConnectivityState(isOnline: true),
    );
    when(() => versionGateCubit.check()).thenAnswer((_) async {});
    when(() => connectivityCubit.start()).thenAnswer((_) async {});
    whenListen(appCubit, const Stream<AppState>.empty(), initialState: AppState.authenticated);
    AppInjector.instance.registerFactory<TimeInAppCubit>(() => timeInAppCubit);
    AppInjector.instance.registerFactory<VersionGateCubit>(() => versionGateCubit);
    AppInjector.instance.registerFactory<ConnectivityCubit>(() => connectivityCubit);
  });

  tearDown(() async {
    AppInjector.instance.unregister<TimeInAppCubit>();
    AppInjector.instance.unregister<VersionGateCubit>();
    AppInjector.instance.unregister<ConnectivityCubit>();
    await timeStates.close();
    await versionStates.close();
    await connectivityStates.close();
    await versionGateCubit.close();
    await connectivityCubit.close();
  });

  Future<void> pumpShell(
    WidgetTester tester,
    RootStackRouter router, {
    EdgeInsets padding = EdgeInsets.zero,
  }) {
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

  testWidgets('wraps the navigator with the three wrappers in order', (tester) async {
    await pumpShell(tester, _TestRouter());
    await tester.pump();

    expect(
      find.descendant(of: find.byType(UpdateAppWrapper), matching: find.byType(TimeInAppWrapper)),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(TimeInAppWrapper),
        matching: find.byType(ConnectivityWrapper),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(of: find.byType(ConnectivityWrapper), matching: find.byType(Navigator)),
      findsOneWidget,
    );
  });

  testWidgets('forced update replaces everything, so neither the toast nor the prompt runs', (
    tester,
  ) async {
    const padding = EdgeInsets.only(top: 59, bottom: 34);
    final router = _TestRouter();
    await pumpShell(tester, router, padding: padding);
    versionStates.add(const VersionGateState(updateRequired: true));
    await settle(tester);

    expect(find.byType(UpdateRequiredPage), findsOneWidget);
    expect(find.byType(TimeInAppWrapper), findsNothing);
    expect(find.byType(ConnectivityWrapper), findsNothing);

    connectivityStates.add(const ConnectivityState(isOnline: false));
    timeStates.add(const TimeInAppState(shouldPrompt: true));
    await settle(tester);

    expect(find.text(offlineCopy(tester)), findsNothing);
    expect(router.stack.map((route) => route.name), isNot(contains(TimeInAppRoute.name)));
    expect(mediaOf(tester, find.byType(UpdateRequiredPage)).padding, padding);
  });
}
