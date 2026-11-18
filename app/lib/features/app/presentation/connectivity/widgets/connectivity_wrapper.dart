import 'package:app/features/app/presentation/connectivity/cubit/connectivity_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shows the offline toast through the navigator overlay when the connection drops.
class const ConnectivityWrapper({
  required final Widget child,
  final RootStackRouter? router,
  super.key,
}) extends StatefulWidget {
  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState() extends State<ConnectivityWrapper> {
  RootStackRouter get _router => widget.router ?? AppInjector.instance.get<RootStackRouter>();

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => AppInjector.instance.get<ConnectivityCubit>()..start(),
    child: BlocListener<ConnectivityCubit, ConnectivityState>(
      listenWhen: (previous, current) => !previous.isOffline && current.isOffline,
      listener: (context, _) => _showOfflineToast(context),
      child: widget.child,
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
