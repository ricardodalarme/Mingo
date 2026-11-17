import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/presentation/slips/widgets/slips_groups.dart';
import 'package:app/features/slips/presentation/slips_search/cubit/slips_search_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const SlipsSearchPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<SlipsSearchCubit>()..start(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final cubit = context.read<SlipsSearchCubit>();
    final results = context.select((SlipsSearchCubit cubit) => cubit.state.results);
    final query = context.select((SlipsSearchCubit cubit) => cubit.state.query);
    final filters = context.select((SlipsSearchCubit cubit) => cubit.state.filters);

    return BaseView(
      appBar: BaseAppBar(title: l10n.title, onBack: () => context.router.maybePop()),
      body: BaseStackedContent(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BaseTextField(text: query, hint: l10n.searchHint, onChanged: cubit.onQueryChanged),
            const SizedBox(height: AppSpace.s12),
            Wrap(
              spacing: AppSpace.s8,
              runSpacing: AppSpace.s8,
              children: [
                for (final filter in SlipsSearchFilter.values)
                  BaseChoiceChip(
                    label: switch (filter) {
                      SlipsSearchFilter.thisMonth => l10n.filterThisMonth,
                      SlipsSearchFilter.private => l10n.scopePrivate,
                      SlipsSearchFilter.inCard => l10n.filterInCard,
                      SlipsSearchFilter.invisible => l10n.filterInvisible,
                    },
                    isSelected: filters.contains(filter),
                    onTap: () => cubit.toggle(filter),
                  ),
              ],
            ),
            const SizedBox(height: AppSpace.s16),
            SkeletonizerResourceWidget<List<SlipEntry>>(
              results,
              fakeValue: [SlipEntry.fake(), SlipEntry.fake()],
              successBuilder: (items) => items.isEmpty
                  ? _Empty(query: query, hasFilters: filters.isNotEmpty)
                  : SlipsGroups(slips: items, showsHeaders: false),
              failureBuilder: (exception) =>
                  AppErrorView(exception: exception, onRetry: cubit.start),
            ),
          ],
        ),
      ),
    );
  }
}

class const _Empty({required final String query, required final bool hasFilters})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final hasQuery = query.trim().isNotEmpty;

    if (!hasQuery && !hasFilters) {
      return BaseEmptyState(
        title: l10n.emptyTitle,
        text: l10n.emptyText,
        face: FaceKind.thinking,
        actionText: l10n.emptyAction,
        onAction: () => context.router.root.push(const QuickSlipRoute()),
      );
    }

    return BaseEmptyState(
      title: l10n.searchEmptyTitle,
      text: hasQuery ? l10n.searchEmptyText : l10n.searchFiltersEmptyText,
      face: FaceKind.thinking,
    );
  }
}
