import 'package:app/features/love_style/data/models/love_style_entry.dart';
import 'package:app/features/love_style/presentation/compare/cubit/love_style_compare_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The two shared results side by side, ending with something to do together.
@RoutePage()
class const LoveStyleComparePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<LoveStyleCompareCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.loveStyle;
    final comparison = context.select((LoveStyleCompareCubit cubit) => cubit.state.comparison);
    final partnerName = context.select((LoveStyleCompareCubit cubit) => cubit.state.partnerName);
    final cubit = context.read<LoveStyleCompareCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.compareTitle),
      body: SkeletonizerResourceWidget<LoveStyleComparison?>(
        comparison,
        fakeValue: const LoveStyleComparison(own: ['time', 'words'], partner: ['touch', 'time']),
        successBuilder: (value) => value == null
            ? BaseEmptyState(
                title: l10n.compareMissingTitle,
                text: l10n.compareMissingText,
                actionText: context.l10n.common.retry,
                onAction: cubit.load,
              )
            : _ComparisonBody(comparison: value, partnerName: partnerName),
        failureBuilder: (_) => BaseEmptyState(
          title: l10n.loadErrorTitle,
          text: l10n.loadErrorText,
          actionText: context.l10n.common.retry,
          onAction: cubit.load,
        ),
      ),
    );
  }
}

class const _ComparisonBody({
  required final LoveStyleComparison comparison,
  final String? partnerName,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.loveStyle;
    final name = partnerName == null || partnerName!.trim().isEmpty
        ? l10n.partnerFallback
        : partnerName!;
    final common = comparison.commonPattern;

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.compareHeadline,
              highlight: l10n.compareHighlight,
              style: context.text.display,
            ),
          ),
          const SizedBox(height: AppSpace.s20),
          _RankCard(label: l10n.compareYou, ranked: comparison.own),
          const SizedBox(height: AppSpace.s12),
          _RankCard(label: name, ranked: comparison.partner),
          if (common != null) ...[
            const SizedBox(height: AppSpace.s12),
            BaseSurfaceCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BaseTag(text: l10n.compareCommon),
                  const SizedBox(height: AppSpace.s12),
                  Text(
                    l10n.compareCommonText(label: l10n.commonLabels.selectOrFallback(common)),
                    style: context.text.body,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      footer: BaseButton.primary(
        text: l10n.comparePlan,
        onPressed: () => context.pushRoute(const DateNightRoute()),
      ),
    );
  }
}

class const _RankCard({required final String label, required final List<String> ranked})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.loveStyle;
    final top = ranked.isEmpty ? null : ranked.first;
    final next = ranked.length > 1 ? ranked[1] : null;

    return BaseSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseTag(text: label),
          const SizedBox(height: AppSpace.s12),
          if (top != null) ...[
            Text(
              l10n.compareMost,
              style: context.text.caption.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s2),
            Text(l10n.labels.selectOrFallback(top), style: context.text.titleSm),
          ],
          if (next != null) ...[
            const SizedBox(height: AppSpace.s10),
            Text(
              l10n.compareNext,
              style: context.text.caption.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s2),
            Text(l10n.labels.selectOrFallback(next), style: context.text.body),
          ],
        ],
      ),
    );
  }
}
