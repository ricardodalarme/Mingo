import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/presentation/mood_longing/cubit/mood_longing_widget_cubit.dart';
import 'package:app/features/widgets/presentation/mood_longing/widgets/mood_longing_preview_section.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Partner mood and longing widgets (`X-152`).
@RoutePage()
class const MoodLongingWidgetPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<MoodLongingWidgetCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final overviewResource = context.select((MoodLongingWidgetCubit cubit) => cubit.state.overview);
    final cubit = context.read<MoodLongingWidgetCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.moodLongingPageTitle),
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
          successBuilder: (overview) => MoodLongingPreviewSection(payload: overview.payload),
        ),
      ),
    );
  }
}
