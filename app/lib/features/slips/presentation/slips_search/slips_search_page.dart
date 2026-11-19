import 'dart:math' as math;

import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/presentation/slips/widgets/slips_groups.dart';
import 'package:app/features/slips/presentation/slips_search/cubit/slips_search_cubit.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// How close to the end of the results, in pixels, the next page starts loading.
const double _loadMoreThreshold = 400;

@RoutePage()
class const SlipsSearchPage({super.key}) extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<SlipsSearchCubit>()..start(),
      child: this,
    );
  }

  @override
  State<SlipsSearchPage> createState() => _SlipsSearchPageState();
}

class _SlipsSearchPageState() extends State<SlipsSearchPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    if (_controller.position.extentAfter < _loadMoreThreshold) {
      context.read<SlipsSearchCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final cubit = context.read<SlipsSearchCubit>();
    final results = context.select((SlipsSearchCubit cubit) => cubit.state.results);
    final query = context.select((SlipsSearchCubit cubit) => cubit.state.query);
    final filters = context.select((SlipsSearchCubit cubit) => cubit.state.filters);
    final hasNext = context.select((SlipsSearchCubit cubit) => cubit.state.hasNext);

    return BaseView(
      appBar: BaseAppBar(title: l10n.title, onBack: () => context.router.maybePop()),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final inset = math.max(
            AppSpace.screenMargin,
            (constraints.maxWidth - AppSpace.maxContentWidth) / 2,
          );

          return CustomScrollView(
            controller: _controller,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(inset, AppSpace.s8, inset, AppSpace.s24),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BaseTextField(
                            text: query,
                            hint: l10n.searchHint,
                            onChanged: cubit.onQueryChanged,
                          ),
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
                          if (results case Success<List<SlipEntry>>(:final value)
                              when value.isNotEmpty && !hasNext) ...[
                            _CountLine(slips: value),
                            const SizedBox(height: AppSpace.s16),
                          ],
                        ],
                      ),
                    ),
                    _Results(results: results, query: query, hasFilters: filters.isNotEmpty),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class const _CountLine({required final List<SlipEntry> slips}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final months = {for (final slip in slips) _monthOf(slip)};
    final text = months.length == 1
        ? l10n.resultCountMonth(
            count: slips.length,
            month: l10n.monthsLong[months.single.month - 1],
          )
        : l10n.resultCount(count: slips.length);

    return Text(text, style: context.text.body.copyWith(color: context.colors.textSecondary));
  }

  DateTime _monthOf(SlipEntry slip) {
    final date = slip.createdAt.toLocal();

    return DateTime(date.year, date.month);
  }
}

class const _Results({
  required final Resource<List<SlipEntry>> results,
  required final String query,
  required final bool hasFilters,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SlipsSearchCubit>();

    return switch (results) {
      Success<List<SlipEntry>>(:final value) when value.isEmpty => SliverToBoxAdapter(
        child: _Empty(query: query, hasFilters: hasFilters),
      ),
      Success<List<SlipEntry>>(:final value) => SlipsGroups(
        slips: value,
        isLoadingMore: context.select((SlipsSearchCubit cubit) => cubit.state.isLoadingMore),
      ),
      Failure(:final exception) => SliverToBoxAdapter(
        child: AppErrorView(exception: exception, onRetry: cubit.start),
      ),
      _ => SliverSkeletonizer(
        child: SlipsGroups(
          slips: [for (var i = 0; i < 2; i++) SlipEntry.fake(id: 'fake-$i')],
          isLoaded: false,
          showsHeaders: false,
        ),
      ),
    };
  }
}

class const _Empty({required final String query, required final bool hasFilters})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final hasQuery = query.trim().isNotEmpty;

    if (!hasQuery && !hasFilters) {
      return Column(
        children: [
          const BaseSlipNoteGhost(),
          const SizedBox(height: AppSpace.s20),
          BaseEmptyState(
            title: l10n.emptyTitle,
            text: l10n.emptyText,
            face: FaceKind.thinking,
            actionText: l10n.emptyAction,
            onAction: () => context.router.root.push(const QuickSlipRoute()),
          ),
        ],
      );
    }

    return BaseEmptyState(
      title: l10n.searchEmptyTitle,
      text: hasQuery ? l10n.searchEmptyText : l10n.searchFiltersEmptyText,
      face: FaceKind.thinking,
    );
  }
}
