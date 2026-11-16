import 'package:app/features/pairing/data/models/active_invite.dart';
import 'package:app/features/pairing/presentation/invite/cubit/invite_cubit.dart';
import 'package:app/features/pairing/presentation/invite/widgets/invite_compose.dart';
import 'package:app/features/pairing/presentation/invite/widgets/invite_sent.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const InvitePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<InviteCubit>()..start(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.invite;
    final invite = context.select((InviteCubit cubit) => cubit.state.invite);
    final hasShared = context.select((InviteCubit cubit) => cubit.state.hasShared);

    final title = invite is Success<ActiveInvite> && hasShared
        ? l10n.waitingTitle
        : l10n.shareTitle;

    return BaseView(
      appBar: BaseAppBar(title: title, onBack: () => context.router.maybePop()),
      body: BlocListener<InviteCubit, InviteState>(
        listenWhen: (previous, current) => previous.revokeAction != current.revokeAction,
        listener: (context, state) {
          switch (state.revokeAction) {
            case Success():
              context.router.maybePop();
            case Failure(:final exception):
              BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
            default:
              break;
          }
        },
        child: switch (invite) {
          Success<ActiveInvite>(:final value) =>
            hasShared ? InviteSent(invite: value) : InviteCompose(invite: value),
          Failure(:final exception) => BaseEmptyState(
            title: l10n.errorTitle,
            text: l10n.errors.selectOrFallback(exception.l10nKey),
            actionText: context.l10n.common.retry,
            onAction: context.read<InviteCubit>().start,
          ),
          _ => const Center(child: BaseLoadingDots()),
        },
      ),
    );
  }
}
