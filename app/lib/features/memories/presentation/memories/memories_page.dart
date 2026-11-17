import 'package:app/features/memories/presentation/memories/cubit/on_this_day_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The way into everything the couple keeps: memories, the jar, their story, dates and the diary.
@RoutePage()
class const MemoriesPage({final bool isEmbedded = false, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.memories;

    final content = BlocProvider(
      create: (_) => AppInjector.instance.get<OnThisDayCubit>()..load(),
      child: BaseStackedContent(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isEmbedded) ...[
              Semantics(header: true, child: Text(l10n.title, style: context.text.titleXl)),
              const SizedBox(height: AppSpace.s16),
            ],
            const _OnThisDay(),
            BaseListGroup(
              children: [
                BaseListTile(
                  icon: AppIcons.book,
                  title: l10n.menu.timeline,
                  subtitle: l10n.menu.timelineText,
                  showsChevron: true,
                  onTap: () => context.pushRoute(const MemoriesTimelineRoute()),
                ),
                BaseListTile(
                  icon: AppIcons.rings,
                  title: l10n.historyTitle,
                  subtitle: l10n.menu.storyText,
                  showsChevron: true,
                  onTap: () => context.pushRoute(const HistoryRoute()),
                ),
                BaseListTile(
                  icon: AppIcons.calendar,
                  title: l10n.menu.dates,
                  subtitle: l10n.menu.datesText,
                  showsChevron: true,
                  onTap: () => context.pushRoute(const DatesRoute()),
                ),
                BaseListTile(
                  icon: AppIcons.note,
                  title: l10n.menu.diary,
                  subtitle: l10n.menu.diaryText,
                  showsChevron: true,
                  onTap: () => context.pushRoute(const DiaryRoute()),
                ),
                BaseListTile(
                  icon: AppIcons.gift,
                  title: l10n.menu.gifts,
                  subtitle: l10n.menu.giftsText,
                  showsChevron: true,
                  onTap: () => context.pushRoute(const GiftsRoute()),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return isEmbedded ? content : BaseView(appBar: null, body: content);
  }
}

class const _OnThisDay() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.memories;
    final memories = context.watch<OnThisDayCubit>().state;
    if (memories.isEmpty) return const SizedBox.shrink();
    final memory = memories.first;
    final years = clock.now().year - memory.happenedOn.year;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.s16),
      child: BaseListCard(
        categoryLabel: l10n.onThisDay.label,
        category: AppCategory.dates,
        title: memory.title,
        supportText: l10n.onThisDay.yearsAgo(count: years),
      ),
    );
  }
}
