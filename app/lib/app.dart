import 'dart:async';

import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/navigation/app_state_navigator.dart';
import 'package:app/features/app/presentation/shell/app_shell.dart';
import 'package:app/features/home_widgets/data/repositories/home_widgets_repository.dart';
import 'package:app/features/home_widgets/data/services/home_widget_data_service.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/deep_links/deep_link_resolver.dart';
import 'package:app/router/deep_links/deep_link_transformer.dart';
import 'package:app/router/deep_links/public_destination.dart';
import 'package:app/router/observers/analytics_router_observer.dart';
import 'package:app/router/observers/log_router_observer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network/network.dart';

class const App({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final injector = AppInjector.instance;
    final appCubit = injector.get<AppCubit>();
    final appRouter = injector.get<RootStackRouter>();
    final navigatorObservers = <NavigatorObserver>[
      injector.get<LogRouterObserver>(),
      injector.get<AnalyticsRouterObserver>(),
    ];

    return TranslationProvider(
      child: AppThemeHost(
        initialVariant: _initialVariant(),
        child: BlocProvider(
          create: (context) => appCubit,
          child: _AppStateListener(
            cubit: appCubit,
            navigator: injector.get<AppStateNavigator>(),
            child: Builder(
              builder: (context) {
                final theme = AppTheme.light(AppThemeScope.of(context));
                return BaseApp.router(
                  theme: theme,
                  onGenerateTitle: (context) => context.l10n.common.appName,
                  routerConfig: appRouter.config(
                    navigatorObservers: () => navigatorObservers,
                    deepLinkTransformer: (uri) async => transformDeepLinkUri(uri),
                    deepLinkBuilder: _deepLinkBuilder,
                  ),
                  locale: TranslationProvider.of(context).flutterLocale,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  builder: (context, child) => AppShell(child: child ?? const SizedBox.shrink()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  AppThemeVariant _initialVariant() {
    final stored = AppInjector.instance.get<SettingsRepository>().get().themeVariant;

    return switch (stored) {
      'blue' => AppThemeVariant.blue,
      'neutral' => AppThemeVariant.neutral,
      _ => AppThemeVariant.rose,
    };
  }

  PageRouteInfo<void> _resolveRouteForState(AppState state) => routeForAppState(state);

  Future<DeepLink> _deepLinkBuilder(PlatformDeepLink deepLink) async {
    final injector = AppInjector.instance;
    final routes = await injector.get<DeepLinkResolver>().resolve(deepLink.uri);
    if (routes != null) return DeepLink(routes);

    final isLaunch = deepLink.initial && deepLink.path == '/';
    if (!isLaunch) {
      final alone = publicDestinationOf(deepLink.matches);

      return alone == null ? deepLink : DeepLink.single(alone);
    }

    return DeepLink.single(_resolveRouteForState(injector.get<AppCubit>().state));
  }
}

class const _AppStateListener({
  required final AppCubit cubit,
  required final AppStateNavigator navigator,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<_AppStateListener> createState() => _AppStateListenerState();
}

class _AppStateListenerState() extends State<_AppStateListener> with WidgetsBindingObserver {
  StreamSubscription<AppState>? _subscription;
  final List<StreamSubscription<void>> _profileSubscriptions = [];
  StreamSubscription<Uri?>? _widgetClickSubscription;
  late AppState _previous;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _previous = widget.cubit.state;
    _subscription = widget.cubit.stream.listen(_onStateChanged);
    final injector = AppInjector.instance;
    if (_previous == AppState.authenticated) _watchProfile();
    final homeWidgetDataService = injector.get<HomeWidgetDataService>();
    _widgetClickSubscription = homeWidgetDataService.widgetClicked.listen(_handleWidgetDeepLink);
    unawaited(homeWidgetDataService.initiallyLaunchedFromHomeWidget().then(_handleWidgetDeepLink));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final client = AppInjector.instance.get<GQLClient>();
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        client.pauseSubscriptions();
      case AppLifecycleState.resumed:
        client.resumeSubscriptions();
        if (widget.cubit.state == AppState.authenticated) {
          unawaited(AppInjector.instance.get<HomeWidgetsRepository>().syncQuietly());
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  /// Syncs the home-screen widgets when the profile or the settings change, from any screen.
  void _watchProfile() {
    if (_profileSubscriptions.isNotEmpty) return;

    final injector = AppInjector.instance;
    final repository = injector.get<ProfileRepository>();
    void sync(Object? _) => unawaited(injector.get<HomeWidgetsRepository>().syncQuietly());
    _profileSubscriptions.addAll([
      repository.watchMyProfile().distinct().skip(1).listen(sync, onError: (Object _) {}),
      repository.watchMySettings().distinct().skip(1).listen(sync, onError: (Object _) {}),
    ]);
  }

  void _stopWatchingProfile() {
    for (final subscription in _profileSubscriptions) {
      unawaited(subscription.cancel());
    }
    _profileSubscriptions.clear();
  }

  Future<void> _handleWidgetDeepLink(Uri? uri) async {
    if (uri == null) return;

    final path = transformDeepLinkUri(uri);
    await AppInjector.instance.get<RootStackRouter>().navigatePath(
      path.toString(),
      includePrefixMatches: true,
      onFailure: (_) {},
    );
  }

  void _onStateChanged(AppState current) {
    final previous = _previous;
    _previous = current;
    if (previous == current) return;

    if (current == AppState.authenticated) {
      _watchProfile();
    } else {
      _stopWatchingProfile();
    }
    widget.navigator.onStateChanged(previous, current);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _stopWatchingProfile();
    _widgetClickSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
