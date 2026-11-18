import 'package:app/features/app/presentation/connectivity/widgets/connectivity_wrapper.dart';
import 'package:app/features/app/presentation/time_in_app/widgets/time_in_app_wrapper.dart';
import 'package:app/features/app/presentation/version/widgets/update_app_wrapper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// Stacks the app-level wrappers around the navigator: the forced update first,
/// then the time-in-app prompt, then the offline toast.
class const AppShell({required final Widget child, final RootStackRouter? router, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) => UpdateAppWrapper(
    child: TimeInAppWrapper(
      router: router,
      child: ConnectivityWrapper(router: router, child: child),
    ),
  );
}
