import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// A blank, neutral screen that quick exit closes to; it says nothing about the app.
///
/// Pressing and holding anywhere brings the app back.
@RoutePage()
class const NeutralPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPress: () => context.router.root.replaceAll([const HomeRoute()]),
      child: const ColoredBox(color: AppPalette.white, child: SizedBox.expand()),
    );
  }
}
