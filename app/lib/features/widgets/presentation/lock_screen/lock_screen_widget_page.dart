import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/presentation/lock_screen/cubit/lock_screen_widget_cubit.dart';
import 'package:app/features/widgets/presentation/lock_screen/widgets/lock_screen_preview_section.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Lock-screen widget screen (`X-148`): iOS accessory families preview, pause status,
/// zero personal names/messages rule, and honest Android explanation.
@RoutePage()
class const LockScreenWidgetPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<LockScreenWidgetCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final overviewResource = context.select((LockScreenWidgetCubit cubit) => cubit.state.overview);
    final cubit = context.read<LockScreenWidgetCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.lockScreenPageTitle),
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
          successBuilder: (overview) => LockScreenPreviewSection(payload: overview.payload),
        ),
      ),
    );
  }
}
