import 'package:app/features/notifications/presentation/bell/cubit/inbox_badge_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The bell that opens the notifications, with a dot while something is unread.
class const InboxBellButton({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.inbox;
    final hasUnread = context.select((InboxBadgeCubit cubit) => cubit.state > 0);

    return BaseRoundButton(
      icon: AppIcons.bell,
      hasBadge: hasUnread,
      semanticLabel: hasUnread ? l10n.bellUnread : l10n.title,
      onPressed: () => context.pushRoute(const InboxRoute()),
    );
  }
}
