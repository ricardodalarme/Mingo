import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:design_system/design_system.dart';

/// The way into everything the couple keeps: memories, the jar, their story, dates and the diary.
@RoutePage()
class const MemoriesPage({final bool isEmbedded = false, super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.memories;

    final content = BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!isEmbedded) ...[
            Semantics(header: true, child: Text(l10n.title, style: context.text.titleXl)),
            const SizedBox(height: AppSpace.s16),
          ],
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
                icon: AppIcons.heart,
                title: l10n.menu.jar,
                subtitle: l10n.menu.jarText,
                showsChevron: true,
                onTap: () => context.pushRoute(const JarRoute()),
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
            ],
          ),
        ],
      ),
    );

    return isEmbedded ? content : BaseView(appBar: null, body: content);
  }
}
