import 'package:app/features/notifications/data/models/inbox_item.dart';
import 'package:app/features/notifications/presentation/inbox/widgets/inbox_copy.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// A titled group of notifications; [timeLabel] formats the time shown on each row.
class const InboxSection({
  required final String title,
  required final List<InboxItem> items,
  required final String? partnerName,
  required final String Function(InboxItem item) timeLabel,
  final String? actionLabel,
  final VoidCallback? onAction,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BaseSectionHeader(title: title, actionLabel: actionLabel, onAction: onAction),
        const SizedBox(height: AppSpace.s10),
        BaseListGroup(
          children: [
            for (var index = 0; index < items.length; index++)
              _InboxRow(
                item: items[index],
                partnerName: partnerName,
                timeLabel: timeLabel(items[index]),
                showsDivider: index < items.length - 1,
              ),
          ],
        ),
      ],
    );
  }
}

class const _InboxRow({
  required final InboxItem item,
  required final String? partnerName,
  required final String timeLabel,
  required final bool showsDivider,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final copy = inboxCopyFor(context, item, partnerName);
    final route = inboxRouteFor(item);

    return BaseListTile(
      leading: BaseIconTile(icon: copy.icon),
      title: copy.title,
      subtitle: copy.subtitle,
      value: timeLabel,
      trailing: item.isRead ? null : const _UnreadDot(),
      showsChevron: item.isRead && route != null,
      onTap: route == null ? null : () => context.pushRoute(route),
      showsDivider: showsDivider,
    );
  }
}

class const _UnreadDot() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Container(
        width: AppSpace.s8,
        height: AppSpace.s8,
        decoration: BoxDecoration(color: context.colors.accentHighlight, shape: BoxShape.circle),
      ),
    );
  }
}
