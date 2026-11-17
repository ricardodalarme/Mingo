import 'package:app/features/widgets/data/models/widget_models.dart';
import 'package:app/features/widgets/presentation/partner_note/cubit/partner_note_widget_cubit.dart';
import 'package:app/features/widgets/presentation/partner_note/widgets/partner_note_preview_section.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Partner note widget screen (`X-151`): only a note the partner chose to send.
@RoutePage()
class const PartnerNoteWidgetPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<PartnerNoteWidgetCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.widgets;
    final overviewResource = context.select((PartnerNoteWidgetCubit cubit) => cubit.state.overview);
    final cubit = context.read<PartnerNoteWidgetCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.partnerNotePageTitle),
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
          successBuilder: (overview) => PartnerNotePreviewSection(payload: overview.payload),
        ),
      ),
    );
  }
}
