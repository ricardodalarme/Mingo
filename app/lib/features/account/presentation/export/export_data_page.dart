import 'package:app/features/account/presentation/export/cubit/export_data_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:link_launcher_service/link_launcher_service.dart';

/// Builds a file with only the person's own data, to keep before leaving or deleting.
@RoutePage()
class const ExportDataPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => AppInjector.instance.get<ExportDataCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.account.export;
    final action = context.select((ExportDataCubit cubit) => cubit.state.exportAction);

    return BaseView(
      appBar: BaseAppBar(title: l10n.appBarTitle),
      body: BlocListener<ExportDataCubit, ExportDataState>(
        listenWhen: (previous, current) => previous.exportAction != current.exportAction,
        listener: _onChanged,
        child: BaseStackedContent(
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
              const SizedBox(height: AppSpace.s12),
              Text(
                l10n.text,
                style: context.text.body.copyWith(color: context.colors.textSecondary),
              ),
              const SizedBox(height: AppSpace.s20),
              BaseNote(text: l10n.note),
            ],
          ),
          footer: BaseButton(
            text: action is Success ? l10n.again : l10n.action,
            isLoading: action.isLoading,
            onPressed: context.read<ExportDataCubit>().export,
          ),
        ),
      ),
    );
  }

  Future<void> _onChanged(BuildContext context, ExportDataState state) async {
    final l10n = context.l10n.account.export;
    switch (state.exportAction) {
      case Success(:final value):
        final opened = await AppInjector.instance.get<LinkLauncherService>().openExternal(value);
        if (!opened && context.mounted) BaseToast.show(context, l10n.openFailed);
      case Failure(:final exception):
        BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
      case Initial() || Loading():
        break;
    }
  }
}
