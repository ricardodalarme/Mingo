import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/repair/data/models/repair_path.dart';
import 'package:app/features/repair/data/models/temperature_history.dart';
import 'package:app/features/repair/presentation/history/cubit/temperature_history_cubit.dart';
import 'package:app/features/repair/presentation/history/widgets/temperature_chart.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The last eight weeks of the person's own temperature answers; it is never shared.
@RoutePage()
class const TemperatureHistoryPage({super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<TemperatureHistoryCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.temperature.history;
    final checks = context.select((TemperatureHistoryCubit cubit) => cubit.state.checks);

    return BaseView(
      appBar: BaseAppBar(onClose: () => context.router.maybePop()),
      body: BaseStackedContent(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: AppHighlightedText(
                text: l10n.title,
                highlight: l10n.titleHighlight,
                style: context.text.display,
              ),
            ),
            const SizedBox(height: AppSpace.s8),
            Text(
              l10n.subtitle,
              style: context.text.body.copyWith(color: context.colors.textSecondary),
            ),
            const SizedBox(height: AppSpace.s20),
            SkeletonizerResourceWidget<List<TemperatureCheck>>(
              checks,
              fakeValue: const [],
              successBuilder: (value) => _Content(checks: value),
              failureBuilder: (failure) => AppErrorView(
                exception: failure,
                onRetry: context.read<TemperatureHistoryCubit>().load,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class const _Content({required final List<TemperatureCheck> checks}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.temperature;
    final weeks = temperatureWeeks(checks, now: clock.now());
    if (weeks.every((week) => week.level == null)) {
      return BaseEmptyState(title: l10n.history.emptyTitle, text: l10n.history.emptyText);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TemperatureChart(weeks: weeks),
        const SizedBox(height: AppSpace.s20),
        BaseStatRow(
          children: [
            for (final level in Temperature.values)
              BaseStat(
                value: '${weeks.where((week) => week.level == level).length}',
                caption: l10n.levels.selectOrFallback(level.name),
              ),
          ],
        ),
        const SizedBox(height: AppSpace.s16),
        BaseNote(text: l10n.history.note),
      ],
    );
  }
}
