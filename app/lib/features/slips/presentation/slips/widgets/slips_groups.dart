import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/data/models/slip_kind.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:common_ui/common_ui.dart';
import 'package:design_system/design_system.dart';

/// Slips grouped by week, newest week first.
class const SlipsGroups({
  required final List<SlipEntry> slips,
  final bool isLoaded = true,
  final bool showsHeaders = true,
  final bool isLoadingMore = false,
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groups = groupByWeek(slips);
    final thisMonday = _monday(clock.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final group in groups.entries) ...[
          if (showsHeaders) ...[
            BaseSectionHeader(title: _weekTitle(context, group.key, thisMonday)),
            const SizedBox(height: AppSpace.s8),
          ],
          RevealScope(
            play: isLoaded,
            child: BaseListGroup(
              children: [
                for (final (index, slip) in group.value.indexed)
                  Reveal(
                    index: index,
                    child: BaseListTile(
                      title: slip.body,
                      titleMaxLines: 2,
                      subtitle: _dayLine(context, slip),
                      subtitleMaxLines: 2,
                      trailing: slip.isPrivate ? const _PrivateMarker() : null,
                      showsChevron: true,
                      onTap: () => context.pushRoute(SlipDetailRoute(id: slip.id)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.s20),
        ],
        if (isLoadingMore) const Center(child: BaseLoadingDots()),
      ],
    );
  }

  String _weekTitle(BuildContext context, DateTime monday, DateTime thisMonday) {
    final l10n = context.l10n.slipsList;
    if (monday == thisMonday) return l10n.thisWeek;
    if (monday == thisMonday.subtract(const Duration(days: 7))) return l10n.lastWeek;

    final end = monday.add(const Duration(days: 6));
    String short(DateTime date) =>
        l10n.dateShort(day: date.day, month: l10n.monthsShort[date.month - 1]);

    return l10n.weekRange(start: short(monday), end: short(end));
  }

  String _dayLine(BuildContext context, SlipEntry slip) {
    final l10n = context.l10n.slipsList;
    final day = l10n.weekdaysShort[slip.createdAt.toLocal().weekday - 1];
    final category = slip.category;
    if (category != null) {
      return l10n.dayLine(weekday: day, category: l10n.categories.selectOrFallback(category.name));
    }
    if (slip.kind == SlipKind.quick) return day;

    return l10n.dayLine(weekday: day, category: l10n.kinds.selectOrFallback(slip.kind.name));
  }
}

/// Groups [slips] by the Monday of the week they were written, keeping the input order.
Map<DateTime, List<SlipEntry>> groupByWeek(List<SlipEntry> slips) {
  final groups = <DateTime, List<SlipEntry>>{};
  for (final slip in slips) {
    groups.putIfAbsent(_monday(slip.createdAt.toLocal()), () => []).add(slip);
  }

  return groups;
}

DateTime _monday(DateTime date) {
  final day = DateTime(date.year, date.month, date.day);

  return day.subtract(Duration(days: day.weekday - DateTime.monday));
}

/// The lock that says a slip stays out of the weekly card.
class const _PrivateMarker() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppIcon(
      icon: AppIcons.lock,
      size: AppIconSize.sm,
      color: context.colors.iconMuted,
      semanticLabel: context.l10n.slipsList.privateMarker,
    );
  }
}
