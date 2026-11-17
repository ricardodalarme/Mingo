import 'package:app/features/memories/data/models/memory.dart';
import 'package:app/features/memories/presentation/add_memory/add_memory_sheet.dart';
import 'package:app/features/memories/presentation/timeline/cubit/memories_cubit.dart';
import 'package:app/features/memories/presentation/timeline/widgets/memory_detail_sheet.dart';
import 'package:app/features/share/data/models/share_card.dart';
import 'package:app/features/share/presentation/widgets/share_image_entry.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The couple's memories, newest first.
@RoutePage()
class const MemoriesTimelinePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<MemoriesCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.memories;
    final cubit = context.read<MemoriesCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.segmentTimeline),
      body: BlocListener<MemoriesCubit, MemoriesState>(
        listenWhen: (previous, current) => previous.saveAction != current.saveAction,
        listener: (context, state) {
          if (state.saveAction case Failure(:final exception)) {
            BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
          }
        },
        child: BaseRefreshable(
          onRefresh: cubit.load,
          child: const BaseStackedContent(body: _MemoriesTimeline()),
        ),
      ),
    );
  }
}

class const _MemoriesTimeline() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.memories;
    final memories = context.select((MemoriesCubit cubit) => cubit.state.memories);
    final cubit = context.read<MemoriesCubit>();

    Future<void> confirmDelete(Memory memory) async {
      final confirmed = await BaseConfirmSheet.show(
        context: context,
        title: l10n.deleteTitle,
        text: l10n.deleteText,
        confirmText: l10n.deleteConfirm,
        isDestructive: true,
      );
      if (confirmed) await cubit.delete(memory);
    }

    return SkeletonizerResourceWidget<List<Memory>>(
      memories,
      fakeValue: [Memory.fake()],
      successBuilder: (list) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (list.isEmpty)
            BaseEmptyState(title: l10n.emptyTitle, text: l10n.emptyText)
          else
            RevealScope(
              play: memories is Success<List<Memory>>,
              child: BaseListGroup(
                children: [
                  for (final (index, memory) in list.indexed)
                    Reveal(
                      index: index,
                      child: BaseListTile(
                        title: memory.title,
                        subtitle: [
                          l10n.dateLine(
                            day: memory.happenedOn.day,
                            month: l10n.monthsShort[memory.happenedOn.month - 1],
                            year: memory.happenedOn.year,
                          ),
                          if (memory.place != null) memory.place!,
                        ].join(' · '),
                        onTap: () => _openMemoryDetail(context, memory),
                        trailing: BaseTextLink(
                          text: l10n.delete,
                          onPressed: () => confirmDelete(memory),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          if (list.isNotEmpty) ...[
            const SizedBox(height: AppSpace.s12),
            ShareImageEntry(
              cards: [
                ShareTimelineCard(
                  entries: [
                    for (final memory in list.take(3))
                      ShareTimelineEntry(
                        title: memory.title,
                        date: memory.happenedOn,
                        place: memory.place,
                      ),
                  ],
                ),
              ],
              subtitle: context.l10n.share.entrySubtitleMemories,
            ),
          ],
          const SizedBox(height: AppSpace.s16),
          const _AddMemoryTile(),
        ],
      ),
      failureBuilder: (_) => BaseEmptyState(
        title: l10n.errorTitle,
        text: l10n.errorText,
        actionText: context.l10n.common.retry,
        onAction: cubit.load,
      ),
    );
  }
}

class const _AddMemoryTile() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseListGroup(
      children: [
        BaseListTile(
          icon: AppIcons.plus,
          title: context.l10n.memories.add,
          onTap: () => _openAddMemorySheet(context),
        ),
      ],
    );
  }
}

Future<void> _openMemoryDetail(BuildContext context, Memory memory) => BaseSheet.show<void>(
  context: context,
  title: memory.title,
  child: MemoryDetailSheet(memory: memory),
);

Future<void> _openAddMemorySheet(BuildContext context) async {
  final cubit = context.read<MemoriesCubit>();
  final draft = await BaseSheet.show<AddMemoryDraft>(
    context: context,
    title: context.l10n.memories.add,
    child: const AddMemorySheet(),
  );
  if (draft == null || !context.mounted) return;

  await cubit.add(title: draft.title, body: draft.body, place: draft.place);
}
