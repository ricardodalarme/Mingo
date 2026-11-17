import 'package:app/features/widgets/data/models/widget_family.dart';
import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/presentation/own_medium/cubit/own_medium_widgets_cubit.dart';
import 'package:app/features/widgets/presentation/own_medium/widgets/own_medium_cards.dart';
import 'package:app/features/widgets/presentation/shared/how_to_add_sheet.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Medium personal widgets (`X-147`): Minha semana, Ideia do dia and Próxima data.
@RoutePage()
class const OwnMediumWidgetsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<OwnMediumWidgetsCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final overviewResource = context.select((OwnMediumWidgetsCubit cubit) => cubit.state.overview);
    final cubit = context.read<OwnMediumWidgetsCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.ownMediumTitle),
      body: BaseStackedContent(
        body: SkeletonizerResourceWidget<WidgetOverview>(
          overviewResource,
          fakeValue: WidgetOverview.fake(),
          failureBuilder: (_) => BaseErrorState(
            title: l10n.loadErrorTitle,
            text: l10n.loadErrorBody,
            actionText: l10n.retryAction,
            onAction: cubit.load,
          ),
          successBuilder: (overview) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OwnMediumWidgetsCards(
                payload: overview.payload,
                onTap: (family) => _openFeature(context, family),
              ),
              const SizedBox(height: AppSpace.s12),
              BaseNote(text: l10n.ownGroupHint),
              const SizedBox(height: AppSpace.s24),
              BaseButton(
                text: l10n.ownSmallEntryTitle,
                variant: BaseButtonVariant.secondary,
                onPressed: () => context.pushRoute(const OwnSmallWidgetsRoute()),
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
      .ownWeek => const SlipsRoute() as PageRouteInfo<void>,
      .ownIdea => const HomeRoute(children: [TodayRoute()]),
      .ownMediumDate => const DatesRoute(),
      _ => const OwnMediumWidgetsRoute(),
    };
    await context.pushRoute(route);
  }
}
