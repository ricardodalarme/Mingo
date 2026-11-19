import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/presentation/slips/widgets/slip_note_card.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:common_ui/common_ui.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter/scheduler.dart';

/// Slips on a two-column wall of notes, grouped by week, newest week first.
///
/// A sliver: place it in a `CustomScrollView`. When [hasAddCard] is set, the current week ends
/// with a card that opens a new slip.
class const SlipsGroups({
  required final List<SlipEntry> slips,
  final bool isLoaded = true,
  final bool showsHeaders = true,
  final bool hasAddCard = false,
  final bool isLoadingMore = false,
  super.key,
}) extends StatefulWidget {
  @override
  State<SlipsGroups> createState() => _SlipsGroupsState();
}

class _SlipsGroupsState() extends State<SlipsGroups> {
  bool _isFirstLoad = true;

  @override
  Widget build(BuildContext context) {
    final groups = groupByWeek(widget.slips);
    final thisMonday = _monday(clock.now());
    final animates = widget.isLoaded && _isFirstLoad;
    if (animates) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isFirstLoad = false);
      });
    }

    return SliverMainAxisGroup(
      slivers: [
        for (final group in groups.entries) ...[
          if (widget.showsHeaders)
            SliverPadding(
              padding: const EdgeInsets.only(bottom: AppSpace.s8),
              sliver: SliverToBoxAdapter(
                child: BaseSectionHeader(title: _weekTitle(context, group.key, thisMonday)),
              ),
            ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: AppSpace.s20),
            sliver: _Wall(
              slips: group.value,
              animates: animates,
              hasAddCard: widget.hasAddCard && group.key == thisMonday,
            ),
          ),
        ],
        if (widget.isLoadingMore) const SliverToBoxAdapter(child: Center(child: BaseLoadingDots())),
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
}

class const _Wall({
  required final List<SlipEntry> slips,
  required final bool animates,
  required final bool hasAddCard,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverWall(
      itemCount: slips.length + (hasAddCard ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == slips.length) {
          return BaseSlipNoteAdd(
            label: context.l10n.slipsList.addNote,
            onTap: () => context.router.root.push(const QuickSlipRoute()),
          );
        }

        return SlipNoteCard(
          key: ValueKey(slips[index].id),
          slip: slips[index],
          animatesEntrance: animates,
        );
      },
    );
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
