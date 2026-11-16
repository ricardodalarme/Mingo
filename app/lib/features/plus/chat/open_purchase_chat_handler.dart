import 'package:app/features/_shared/chat_actions/chat_action_handler.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';

/// Opens the Plus purchase screen.
class OpenPurchaseChatHandler() extends TypedChatActionHandler<()> {
  @override
  String get tool => 'open_purchase';

  @override
  () parse(Map<String, Object?> args) => const ();

  @override
  PageRouteInfo<Object?>? route(() args) => const PlansRoute();

  @override
  Future<void> run(() args) async {}
}
