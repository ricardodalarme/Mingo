import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/_shared/presentation/text_prompt/text_prompt_sheet.dart';
import 'package:app/features/agreements/data/models/agreement.dart';
import 'package:app/features/agreements/presentation/agreements/cubit/agreements_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Short sentences the couple agrees on; each one counts once the other person confirms it.
@RoutePage()
class const AgreementsPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<AgreementsCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.agreements;
    final agreements = context.select((AgreementsCubit cubit) => cubit.state.agreements);
    final hasPartner = context.select((AgreementsCubit cubit) => cubit.state.coupleId != null);
    final cubit = context.read<AgreementsCubit>();

    return BaseView(
      appBar: BaseAppBar(
        title: l10n.title,
        trailing: BaseRoundButton(
          icon: AppIcons.plus,
          semanticLabel: l10n.add,
          onPressed: agreements is Success ? () => _add(context) : null,
        ),
      ),
      body: BlocListener<AgreementsCubit, AgreementsState>(
        listenWhen: (previous, current) => previous.changeAction != current.changeAction,
        listener: (context, state) {
          if (state.changeAction case Failure(:final exception)) {
            BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
          }
        },
        child: BaseRefreshable(
          onRefresh: cubit.load,
          child: BaseStackedContent(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  hasPartner ? l10n.subtitleShared : l10n.subtitlePrivate,
                  style: context.text.body.copyWith(color: context.colors.textSecondary),
                ),
                const SizedBox(height: AppSpace.s20),
                SkeletonizerResourceWidget<List<Agreement>>(
                  agreements,
                  fakeValue: [Agreement.fake(), Agreement.fake()],
                  successBuilder: (values) => values.isEmpty
                      ? BaseEmptyState(
                          title: l10n.emptyTitle,
                          text: hasPartner ? l10n.emptyTextShared : l10n.emptyTextPrivate,
                          actionText: l10n.add,
                          onAction: () => _add(context),
                        )
                      : BaseListGroup(
                          children: [for (final item in values) _AgreementTile(agreement: item)],
                        ),
                  failureBuilder: (exception) =>
                      AppErrorView(exception: exception, onRetry: cubit.load),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _add(BuildContext context) async {
    final l10n = context.l10n.agreements;
    final cubit = context.read<AgreementsCubit>();

    await BaseSheet.show<void>(
      context: context,
      title: l10n.addTitle,
      child: TextPromptSheet(
        label: l10n.bodyLabel,
        hint: l10n.bodyHint,
        maxLength: agreementMaxLength,
        confirmText: l10n.propose,
        errors: l10n.bodyErrors,
        onConfirm: cubit.add,
      ),
    );
  }
}

class const _AgreementTile({required final Agreement agreement}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.agreements;
    final cubit = context.read<AgreementsCubit>();
    final status = switch (agreement) {
      Agreement(isShared: false) => l10n.statusPrivate,
      Agreement(isConfirmed: true) => l10n.statusConfirmed,
      Agreement(isMine: true) => l10n.statusWaitingPartner,
      _ => l10n.statusWaitingYou,
    };

    return BaseListTile(
      icon: agreement.isConfirmed ? AppIcons.check : AppIcons.note,
      title: agreement.body,
      subtitle: status,
      titleMaxLines: 3,
      trailing: agreement.needsMyConfirmation
          ? BaseButton.compact(text: l10n.confirm, onPressed: () => cubit.confirm(agreement))
          : BaseRoundButton(
              icon: AppIcons.more,
              semanticLabel: l10n.options,
              onPressed: () => _archive(context),
            ),
    );
  }

  Future<void> _archive(BuildContext context) async {
    final l10n = context.l10n.agreements;
    final cubit = context.read<AgreementsCubit>();
    final confirmed = await BaseConfirmSheet.show(
      context: context,
      title: l10n.archiveTitle,
      text: agreement.isShared ? l10n.archiveTextShared : l10n.archiveTextPrivate,
      confirmText: l10n.archiveConfirm,
      isDestructive: true,
    );
    if (confirmed) await cubit.archive(agreement);
  }
}
