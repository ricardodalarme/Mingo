import 'dart:math' as math;

import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/slips/data/models/slip_entry.dart';
import 'package:app/features/slips/presentation/slips/cubit/slips_list_cubit.dart';
import 'package:app/features/slips/presentation/slips/widgets/jar_section.dart';
import 'package:app/features/slips/presentation/slips/widgets/slips_groups.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// How close to the end of the list, in pixels, the next page starts loading.
const double _loadMoreThreshold = 400;

@RoutePage()
class const SlipsPage({super.key}) extends StatefulWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<SlipsListCubit>()..start(),
      child: this,
    );
  }

  @override
  State<SlipsPage> createState() => _SlipsPageState();
}

class _SlipsPageState() extends State<SlipsPage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _controller.position;
    if (position.extentAfter < _loadMoreThreshold) context.read<SlipsListCubit>().loadMore();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slips = context.select((SlipsListCubit cubit) => cubit.state.slips);
    final scope = context.select((SlipsListCubit cubit) => cubit.state.scope);
    final cubit = context.read<SlipsListCubit>();

    return BaseView(
      appBar: null,
      body: BaseRefreshable(
        onRefresh: cubit.load,
        child: LayoutBuilder(
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
                        child: _Header(scope: scope, count: _weekCount(slips, scope)),
                      ),
                      if (scope == SlipsScope.jar)
                        const SliverToBoxAdapter(child: JarSection())
                      else
                        _Results(slips: slips, scope: scope),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  int? _weekCount(Resource<List<SlipEntry>> slips, SlipsScope scope) {
    if (scope != SlipsScope.week) return null;

    return switch (slips) {
      Success<List<SlipEntry>>(:final value) when value.isNotEmpty => value.length,
      _ => null,
    };
  }
}

class const _Header({required final SlipsScope scope, required final int? count})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final cubit = context.read<SlipsListCubit>();
    final count = this.count;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(l10n.title, style: context.text.titleXl)),
            BaseRoundButton(
              icon: AppIcons.search,
              semanticLabel: l10n.search,
              onPressed: () => context.pushRoute(const SlipsSearchRoute()),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.s16),
        Wrap(
          spacing: AppSpace.s8,
          runSpacing: AppSpace.s8,
          children: [
            for (final option in SlipsScope.values)
              BaseChoiceChip(
                label: switch (option) {
                  SlipsScope.week => l10n.scopeWeek,
                  SlipsScope.all => l10n.scopeAll,
                  SlipsScope.private => l10n.scopePrivate,
                  SlipsScope.jar => l10n.scopeJar,
                },
                isSelected: scope == option,
                onTap: () => cubit.changeScope(option),
              ),
          ],
        ),
        if (count != null) ...[
          const SizedBox(height: AppSpace.s16),
          Text(
            l10n.weekLine(count: count),
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
        ],
        const SizedBox(height: AppSpace.s20),
      ],
    );
  }
}

class const _Results({
  required final Resource<List<SlipEntry>> slips,
  required final SlipsScope scope,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SlipsListCubit>();

    return switch (slips) {
      Success<List<SlipEntry>>(:final value) when value.isEmpty => SliverToBoxAdapter(
        child: _Empty(scope: scope),
      ),
      Success<List<SlipEntry>>(:final value) => SlipsGroups(
        slips: value,
        showsHeaders: scope == SlipsScope.all,
        hasAddCard: scope != SlipsScope.private,
        isLoadingMore: context.select((SlipsListCubit cubit) => cubit.state.isLoadingMore),
      ),
      Failure(:final exception) => SliverToBoxAdapter(
        child: AppErrorView(exception: exception, onRetry: cubit.load),
      ),
      _ => SliverSkeletonizer(
        child: SlipsGroups(
          slips: [for (var i = 0; i < 4; i++) SlipEntry.fake(id: 'fake-$i')],
          isLoaded: false,
          showsHeaders: false,
        ),
      ),
    };
  }
}

class const _Empty({required final SlipsScope scope}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.slipsList;
    final isPrivate = scope == SlipsScope.private;

    return BaseEmptyState(
      title: isPrivate ? l10n.privateEmptyTitle : l10n.emptyTitle,
      text: isPrivate ? l10n.privateEmptyText : l10n.emptyText,
      face: FaceKind.thinking,
      actionText: l10n.emptyAction,
      onAction: () => context.router.root.push(const QuickSlipRoute()),
    );
  }
}
