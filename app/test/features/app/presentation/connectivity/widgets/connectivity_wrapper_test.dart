import 'dart:async';

import 'package:app/features/app/presentation/connectivity/cubit/connectivity_cubit.dart';
import 'package:app/features/app/presentation/connectivity/widgets/connectivity_wrapper.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockConnectivityCubit() extends MockCubit<ConnectivityState> implements ConnectivityCubit;

class const _ConnectivityProbe() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isOffline = context.select((ConnectivityCubit cubit) => cubit.state.isOffline);

    return Text(isOffline ? 'offline' : 'online', textDirection: TextDirection.ltr);
  }
}

class _TestRouter() extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [AutoRoute(page: NotFoundRoute.page, initial: true)];
}

void main() {
  late ConnectivityCubit connectivityCubit;
  late StreamController<ConnectivityState> connectivityStates;

  setUp(() {
    connectivityCubit = _MockConnectivityCubit();
    connectivityStates = StreamController<ConnectivityState>.broadcast();
    when(() => connectivityCubit.start()).thenAnswer((_) async {});
    AppInjector.instance.registerFactory<ConnectivityCubit>(() => connectivityCubit);
  });

  tearDown(() async {
    AppInjector.instance.unregister<ConnectivityCubit>();
    await connectivityStates.close();
    await connectivityCubit.close();
  });

  void stubConnectivity({bool? isOnline = true}) {
    whenListen(
      connectivityCubit,
      connectivityStates.stream,
      initialState: ConnectivityState(isOnline: isOnline),
    );
  }

  Future<void> pumpWrapper(
    WidgetTester tester,
    RootStackRouter router, {
    EdgeInsets padding = EdgeInsets.zero,
    Widget? header,
  }) {
    return tester.pumpWidget(
      TranslationProvider(
        child: AppThemeHost(
          initialVariant: AppThemeVariant.rose,
          child: Builder(
            builder: (context) => BaseApp.router(
              routerConfig: router.config(),
              theme: AppTheme.light(AppThemeScope.of(context)),
              supportedLocales: AppLocaleUtils.supportedLocales,
              builder: (context, navigator) {
                final child = navigator ?? const SizedBox.shrink();

                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(padding: padding, viewPadding: padding),
                  child: ConnectivityWrapper(
                    router: router,
                    child: header == null
                        ? child
                        : Column(
                            children: [
                              header,
                              Expanded(child: child),
                            ],
                          ),
                  ),
                );
              },
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
      tester.element(find.byType(ConnectivityWrapper)).l10n.globalErrors.offline;

  Future<void> dropConnection(WidgetTester tester) async {
    connectivityStates.add(const ConnectivityState(isOnline: false));
    await tester.pump();
    await tester.pump();
  }

  Future<void> endToast(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 4));
    await tester.pump();
  }

  testWidgets('shows the copy when the connection drops', (tester) async {
    stubConnectivity();
    await pumpWrapper(tester, _TestRouter());
    await tester.pump();

    await dropConnection(tester);

    expect(find.text(offlineCopy(tester)), findsOneWidget);
    await endToast(tester);
  });

  testWidgets('shows the copy when the app starts offline', (tester) async {
    stubConnectivity(isOnline: null);
    await pumpWrapper(tester, _TestRouter());
    await tester.pump();

    expect(find.text(offlineCopy(tester)), findsNothing);

    await dropConnection(tester);

    expect(find.text(offlineCopy(tester)), findsOneWidget);
    await endToast(tester);
  });

  testWidgets('shows nothing while online', (tester) async {
    stubConnectivity();
    await pumpWrapper(tester, _TestRouter());
    await settle(tester);

    connectivityStates.add(const ConnectivityState(isOnline: true));
    await tester.pump();

    expect(find.text(offlineCopy(tester)), findsNothing);
  });

  testWidgets('shows the copy again after the connection comes back and drops', (tester) async {
    stubConnectivity();
    await pumpWrapper(tester, _TestRouter());
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
    await pumpWrapper(tester, _TestRouter());
    await dropConnection(tester);

    await tester.pump(const Duration(seconds: 3));
    await dropConnection(tester);
    await tester.pump(const Duration(milliseconds: 1100));

    expect(find.text(offlineCopy(tester)), findsNothing);
  });

  testWidgets('leaves the navigator top padding alone', (tester) async {
    const padding = EdgeInsets.only(top: 59, bottom: 34);
    stubConnectivity();
    await pumpWrapper(tester, _TestRouter(), padding: padding);
    await dropConnection(tester);

    expect(find.text(offlineCopy(tester)), findsOneWidget);
    expect(mediaOf(tester, find.byType(Navigator)).padding, padding);
    await endToast(tester);
  });

  testWidgets('exposes the cubit to the screens below', (tester) async {
    stubConnectivity();
    await pumpWrapper(tester, _TestRouter(), header: const _ConnectivityProbe());
    await tester.pump();

    expect(find.text('online'), findsOneWidget);
  });

  testWidgets('starts the cubit once', (tester) async {
    stubConnectivity();
    await pumpWrapper(tester, _TestRouter());
    await tester.pump();

    verify(() => connectivityCubit.start()).called(1);
  });
}
