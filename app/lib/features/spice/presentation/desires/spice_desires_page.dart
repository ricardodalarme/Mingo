import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/presentation/desires/cubit/spice_desires_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Private answers to desires; only what both people want is ever shown, and nobody sees a "no".
@RoutePage()
class const SpiceDesiresPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<SpiceDesiresCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.desires;
    final desires = context.select((SpiceDesiresCubit cubit) => cubit.state.desires);
    final cubit = context.read<SpiceDesiresCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BlocListener<SpiceDesiresCubit, SpiceDesiresState>(
        listenWhen: (previous, current) => previous.answerAction != current.answerAction,
        listener: (context, state) {
          if (state.answerAction case Failure(:final exception)) {
            BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
          }
        },
        child: BaseRefreshable(
          onRefresh: cubit.load,
          child: BaseStackedContent(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Matches(),
                Text(
                  l10n.subtitle,
                  style: context.text.body.copyWith(color: context.colors.textSecondary),
                ),
                const SizedBox(height: AppSpace.s16),
                SkeletonizerResourceWidget<List<SpiceDesire>>(
                  desires,
                  fakeValue: const [
                    SpiceDesire(
                      slug: 'a',
                      title: 'Um jantar à luz de velas',
                      level: SpiceLevel.soft,
                    ),
                    SpiceDesire(slug: 'b', title: 'Uma massagem demorada', level: SpiceLevel.soft),
                  ],
                  successBuilder: (values) => values.isEmpty
                      ? BaseEmptyState(title: l10n.emptyTitle, text: l10n.emptyText)
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: AppSpace.s12,
                          children: [for (final desire in values) _DesireCard(desire: desire)],
                        ),
                  failureBuilder: (exception) =>
                      AppErrorView(exception: exception, onRetry: cubit.load),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class const _Matches() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.desires;
    final matches = context.select((SpiceDesiresCubit cubit) => cubit.state.matches);
    if (matches == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpace.s20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BaseSectionHeader(title: l10n.matchesTitle),
          const SizedBox(height: AppSpace.s8),
          if (matches.isEmpty)
            Text(
              l10n.matchesEmpty,
              style: context.text.body.copyWith(color: context.colors.textSecondary),
            )
          else
            BaseListGroup(
              children: [
                for (final match in matches)
                  BaseListTile(icon: AppIcons.heart, title: match.title, titleMaxLines: 3),
              ],
            ),
        ],
      ),
    );
  }
}

class const _DesireCard({required final SpiceDesire desire}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.desires;
    final cubit = context.read<SpiceDesiresCubit>();

    return BaseSurfaceCard(
      padding: const EdgeInsets.all(AppSpace.s16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(desire.title, style: context.text.body),
          const SizedBox(height: AppSpace.s12),
          Wrap(
            spacing: AppSpace.s8,
            runSpacing: AppSpace.s8,
            children: [
              for (final answer in SpiceAnswer.values)
                BaseChoiceChip(
                  label: l10n.answers.selectOrFallback(answer.name),
                  isSelected: desire.answer == answer,
                  onTap: () => cubit.answer(desire, answer),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
