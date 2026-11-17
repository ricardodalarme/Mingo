import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/presentation/own_small/cubit/own_small_widgets_cubit.dart';
import 'package:app/features/widgets/presentation/own_small/widgets/own_small_grid.dart';
import 'package:app/features/widgets/presentation/shared/how_to_add_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Small personal widgets (`X-146`): Anotar slip, Próxima data, Ritual and
/// Cartão de domingo. They work without a partner and only show what is theirs.
@RoutePage()
class const OwnSmallWidgetsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<OwnSmallWidgetsCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final overviewResource = context.select((OwnSmallWidgetsCubit cubit) => cubit.state.overview);
    final cubit = context.read<OwnSmallWidgetsCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.ownSmallTitle),
      body: BaseStackedContent(
        body: SkeletonizerResourceWidget<WidgetOverview>(
          overviewResource,
          fakeValue: WidgetOverview.fake(),
          failureBuilder: (_) => BaseEmptyState(
            face: FaceKind.sad,
            title: l10n.loadErrorTitle,
            text: l10n.loadErrorBody,
            actionText: l10n.retryAction,
            onAction: cubit.load,
          ),
          successBuilder: (overview) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BaseSectionHeader(title: l10n.ownSmallGroup, isLabel: true),
              const SizedBox(height: AppSpace.s8),
              OwnSmallWidgetsGrid(
                payload: overview.payload,
                onTap: (family) => _openFeature(context, family),
              ),
              const SizedBox(height: AppSpace.s12),
              BaseNote(text: l10n.ownGroupHint),
              const SizedBox(height: AppSpace.s24),
              BaseButton(
                text: l10n.ownMediumEntryTitle,
                variant: BaseButtonVariant.secondary,
                onPressed: () => context.pushRoute(const OwnMediumWidgetsRoute()),
              ),
              const SizedBox(height: AppSpace.s12),
              BaseButton(
                text: l10n.howToAddAction,
                variant: BaseButtonVariant.text,
                onPressed: () => showHowToAddSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openFeature(BuildContext context, WidgetFamily family) async {
    final route = switch (family) {
      .ownSlip => const QuickSlipRoute() as PageRouteInfo<void>,
      .ownNextDate => const DatesRoute(),
      .ownRitual => const RitualsRoute(),
      .ownSundayCard => const SundayCardRoute(),
      _ => const OwnSmallWidgetsRoute(),
    };
    await context.pushRoute(route);
  }
}
