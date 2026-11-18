import 'dart:async';

import 'package:app/features/app/presentation/connectivity/cubit/connectivity_cubit.dart';
import 'package:app/features/app/presentation/cubit/app_cubit.dart';
import 'package:app/features/app/presentation/time_in_app/cubit/time_in_app_cubit.dart';
import 'package:app/features/app/presentation/version/cubit/version_gate_cubit.dart';
import 'package:app/features/app/presentation/version/update_required_page.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Wraps the navigator with the forced-update block, the time-in-app prompt and
/// the toast shown when the connection drops.
class const AppShell({required final Widget child, final RootStackRouter? router, super.key})
    extends StatefulWidget {
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState() extends State<AppShell> {
  bool _isShowingPrompt = false;

  RootStackRouter get _router => widget.router ?? AppInjector.instance.get<RootStackRouter>();

  @override
  Widget build(BuildContext context) {
    final updateRequired = context.select((VersionGateCubit cubit) => cubit.state.updateRequired);
    if (updateRequired) return const UpdateRequiredPage();

    final isAuthenticated = context.select(
      (AppCubit cubit) => cubit.state == AppState.authenticated,
    );

    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listenWhen: (previous, current) => !previous.isOffline && current.isOffline,
      listener: (context, _) => _showOfflineToast(context),
      child: BlocListener<TimeInAppCubit, TimeInAppState>(
        listenWhen: (previous, current) =>
            isAuthenticated && !previous.shouldPrompt && current.shouldPrompt,
        listener: (context, _) => _showTimeInAppPrompt(),
        child: widget.child,
      ),
    );
  }

  void _showOfflineToast(BuildContext context) {
    final message = context.l10n.globalErrors.offline;
    final overlay = _router.navigatorKey.currentState?.overlay;
    if (overlay != null) {
      BaseToast.showIn(overlay, message, bottom: _toastBottom);
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final retry = _router.navigatorKey.currentState?.overlay;
      if (retry != null) BaseToast.showIn(retry, message, bottom: _toastBottom);
    });
  }

  /// Clears the tab bar; the default footer offset would sit inside it on a tab screen.
  static const double _toastBottom = AppSpace.tabBarHeight + AppSpace.s16;

  void _showTimeInAppPrompt() {
    if (_isShowingPrompt) return;
    _isShowingPrompt = true;
    unawaited(_router.push(const TimeInAppRoute()).whenComplete(() => _isShowingPrompt = false));
  }
}
