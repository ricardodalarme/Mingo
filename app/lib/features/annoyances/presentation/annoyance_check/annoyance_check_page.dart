import 'package:app/features/annoyances/data/models/annoyance.dart';
import 'package:app/features/annoyances/presentation/annoyance_check/cubit/annoyance_check_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:clock/clock.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const AnnoyanceCheckPage({required final String id, super.key})
    extends StatelessWidget
    implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<AnnoyanceCheckCubit>()..load(id),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.annoyanceCheck;
    final annoyance = context.select((AnnoyanceCheckCubit cubit) => cubit.state.annoyance);

    return BaseView(
      appBar: BaseAppBar(onClose: () => context.router.maybePop()),
      body: BlocListener<AnnoyanceCheckCubit, AnnoyanceCheckState>(
        listenWhen: (previous, current) => previous.letGoAction != current.letGoAction,
        listener: (context, state) {
          switch (state.letGoAction) {
            case Success():
              BaseToast.show(context, l10n.letGoDone);
              context.router.maybePop();
            case Failure(:final exception):
              BaseToast.show(
                context,
                l10n.errors.selectOrFallback(exception.l10nKey),
                variant: BaseToastVariant.error,
              );
            default:
              break;
          }
        },
        child: SkeletonizerResourceWidget<Annoyance?>(
          annoyance,
          fakeValue: Annoyance.fake(),
          successBuilder: (value) =>
              value == null ? const _Gone() : _Check(annoyance: value, annoyanceId: id),
          failureBuilder: (failure) => BaseEmptyState(
            title: l10n.errorTitle,
            text: l10n.errors.selectOrFallback(failure.l10nKey),
            actionText: context.l10n.common.retry,
            onAction: () => context.read<AnnoyanceCheckCubit>().load(id),
          ),
        ),
      ),
    );
  }
}

class const _Gone() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.annoyanceCheck;

    return BaseEmptyState(
      title: l10n.goneTitle,
      text: l10n.goneText,
      actionText: l10n.close,
      onAction: () => context.router.maybePop(),
    );
  }
}

class const _Check({required final Annoyance annoyance, required final String annoyanceId})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.annoyanceCheck;
    final now = clock.now();

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            header: true,
            child: AppHighlightedText(
              text: l10n.title,
              highlight: l10n.titleHighlight,
              style: context.text.titleXl,
            ),
          ),
          const SizedBox(height: AppSpace.s16),
          BaseSurfaceCard(
            supportText: l10n.age(days: annoyance.ageInDays(now), left: annoyance.daysLeft(now)),
            child: Text(annoyance.body, style: context.text.bodyLg),
          ),
          const SizedBox(height: AppSpace.s16),
          BaseOptionTile(
            title: l10n.talkTitle,
            support: l10n.talkText,
            onTap: () => context.router.replace(GentleRequestRoute(annoyanceId: annoyanceId)),
          ),
          const SizedBox(height: AppSpace.s10),
          BaseOptionTile(
            title: l10n.chatTitle,
            support: l10n.chatText,
            onTap: () => context.router.replace(ChatRoute()),
          ),
          const SizedBox(height: AppSpace.s10),
          BaseOptionTile(
            title: l10n.letGoTitle,
            support: l10n.letGoText,
            onTap: () => _confirmLetGo(context),
          ),
          const SizedBox(height: AppSpace.s16),
          BaseNote(text: l10n.note, icon: AppIcons.info),
        ],
      ),
    );
  }

  Future<void> _confirmLetGo(BuildContext context) async {
    final l10n = context.l10n.annoyanceCheck;
    final cubit = context.read<AnnoyanceCheckCubit>();
    final confirmed = await BaseConfirmSheet.show(
      context: context,
      title: l10n.letGoConfirmTitle,
      text: l10n.letGoConfirmText,
      confirmText: l10n.letGoConfirm,
      isDestructive: true,
    );
    if (confirmed) await cubit.letGo(annoyanceId);
  }
}
