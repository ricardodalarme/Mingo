import 'package:app/features/chat/presentation/chat/chat_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// The chat as a tab of the home shell.
@RoutePage()
class const ChatTabPage({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const ChatPage().wrappedRoute(context);
}
