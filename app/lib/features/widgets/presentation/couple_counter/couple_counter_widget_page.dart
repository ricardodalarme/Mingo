import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/presentation/couple_counter/cubit/couple_counter_widget_cubit.dart';
import 'package:app/features/widgets/presentation/couple_counter/widgets/couple_counter_preview_cards.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Couple counter widget screen (`X-149`): days together calculated at local midnight.
@RoutePage()
class const CoupleCounterWidgetPage({super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<CoupleCounterWidgetCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final overviewResource = context.select(
      (CoupleCounterWidgetCubit cubit) => cubit.state.overview,
    );
    final cubit = context.read<CoupleCounterWidgetCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.counterPageTitle),
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
          successBuilder: (overview) => CoupleCounterPreviewCards(payload: overview.payload),
        ),
      ),
    );
  }
}
