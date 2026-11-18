import 'package:app/features/app/presentation/connectivity/cubit/connectivity_cubit.dart';
import 'package:app/features/app/presentation/time_in_app/widgets/time_in_app_wrapper.dart';
import 'package:app/features/app/presentation/version/widgets/update_app_wrapper.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Composes the forced-update block, the time-in-app prompt and the offline toast
/// around the navigator.
class const AppShell({required final Widget child, final RootStackRouter? router, super.key})
    extends StatefulWidget {
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState() extends State<AppShell> {
  RootStackRouter get _router => widget.router ?? AppInjector.instance.get<RootStackRouter>();

  @override
  Widget build(BuildContext context) => UpdateAppWrapper(
    child: TimeInAppWrapper(
      router: widget.router,
      child: BlocListener<ConnectivityCubit, ConnectivityState>(
        listenWhen: (previous, current) => !previous.isOffline && current.isOffline,
        listener: (context, _) => _showOfflineToast(context),
        child: widget.child,
      ),
    ),
  );

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
}
