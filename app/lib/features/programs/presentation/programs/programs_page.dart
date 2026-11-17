import 'package:app/features/programs/data/models/program.dart';
import 'package:app/features/programs/presentation/programs/cubit/programs_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The guided programs that exist for the account language, plus the private diary.
@RoutePage()
class const ProgramsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<ProgramsCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.programs;
    final programs = context.select((ProgramsCubit cubit) => cubit.state.programs);
    final hasPlus = context.select((ProgramsCubit cubit) => cubit.state.hasPlus);
    final cubit = context.read<ProgramsCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BaseRefreshable(
        onRefresh: cubit.load,
        child: BaseStackedContent(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.hubSubtitle,
                style: context.text.body.copyWith(color: context.colors.textSecondary),
              ),
              const SizedBox(height: AppSpace.s20),
              SkeletonizerResourceWidget<List<Program>>(
                programs,
                fakeValue: [Program.fake()],
                successBuilder: (list) => list.isEmpty
                    ? BaseEmptyState(title: l10n.emptyTitle, text: l10n.emptyText)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BaseListGroup(
                            children: [
                              for (final program in list)
                                _ProgramTile(
                                  program: program,
                                  isLocked: program.plusOnly && !hasPlus,
                                ),
                            ],
                          ),
                          const SizedBox(height: AppSpace.s12),
                          BaseNote(text: l10n.freeNote, icon: AppIcons.info),
                        ],
                      ),
                failureBuilder: (_) => BaseEmptyState(
                  face: FaceKind.sad,
                  title: l10n.errorTitle,
                  text: l10n.errorText,
                  actionText: context.l10n.common.retry,
                  onAction: cubit.load,
                ),
              ),
              const SizedBox(height: AppSpace.s16),
              BaseListGroup(
                children: [
                  BaseListTile(
                    title: l10n.diaryTitle,
                    icon: AppIcons.note,
                    showsChevron: true,
                    onTap: () => context.pushRoute(const DiaryRoute()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _ProgramTile({required final Program program, required final bool isLocked})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.programs;
    final lessonMeta = program.lessonCount == 0
        ? l10n.noLessons
        : l10n.lessonCount(count: program.lessonCount);
    final onTap = isLocked
        ? () => context.pushRoute(const PlansRoute())
        : () => context.pushRoute(ProgramDetailRoute(slug: program.slug));
    final trailing = isLocked ? BaseTag(text: l10n.plus) : null;

    return BaseListTile(
      title: program.title,
      subtitle: lessonMeta,
      icon: isLocked ? AppIcons.lock : AppIcons.plant,
      showsChevron: !isLocked,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
