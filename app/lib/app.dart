import 'dart:async';

import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/navigation/app_state_navigator.dart';
import 'package:app/features/app/presentation/shell/app_shell.dart';
import 'package:app/features/pairing/data/data_sources/local/invite_code_store.dart';
import 'package:app/features/profile/data/repositories/profile_repository.dart';
import 'package:app/features/settings/data/repositories/settings_repository.dart';
import 'package:app/features/widgets/data/repositories/widgets_repository.dart';
import 'package:app/features/widgets/data/services/widget_data_service.dart';
import 'package:app/features/widgets/presentation/navigation/widget_deep_link_resolver.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/observers/analytics_router_observer.dart';
import 'package:app/router/observers/log_router_observer.dart';
import 'package:app/router/pending_route.dart';
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
                    deepLinkTransformer: transformWidgetDeepLinkUri,
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

  DeepLink _deepLinkBuilder(PlatformDeepLink deepLink) {
    final injector = AppInjector.instance;
    final appCubit = injector.get<AppCubit>();
    final inviteRoutes = resolveInviteDeepLinkUri(
      deepLink.uri,
      appState: appCubit.state,
      inviteCodes: injector.get<InviteCodeStore>(),
      pending: injector.get<PendingRoute>(),
    );
    if (inviteRoutes != null) {
      return DeepLink(inviteRoutes);
    }
    final widgetRoutes = resolveWidgetDeepLinkUri(deepLink.uri, appState: appCubit.state);
    if (widgetRoutes != null) {
      return DeepLink(widgetRoutes);
    }
    return deepLink.initial ? DeepLink.single(_resolveRouteForState(appCubit.state)) : deepLink;
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
    final widgetDataService = injector.get<WidgetDataService>();
    _widgetClickSubscription = widgetDataService.widgetClicked.listen(_handleWidgetDeepLink);
    unawaited(widgetDataService.initiallyLaunchedFromHomeWidget().then(_handleWidgetDeepLink));
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
          unawaited(AppInjector.instance.get<WidgetsRepository>().syncQuietly());
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
    void sync(Object? _) => unawaited(injector.get<WidgetsRepository>().syncQuietly());
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

  void _handleWidgetDeepLink(Uri? uri) {
    final routes = resolveWidgetDeepLinkUri(uri, appState: widget.cubit.state);
    if (routes == null) return;
    unawaited(AppInjector.instance.get<RootStackRouter>().replaceAll(routes));
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
