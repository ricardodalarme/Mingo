import 'package:app/features/_shared/presentation/errors/app_error_view.dart';
import 'package:app/features/spice/data/models/spice_models.dart';
import 'package:app/features/spice/presentation/challenge/cubit/spice_challenge_cubit.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:common_ui/common_ui.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The challenge of the week for the couple, with no points and no deadline.
@RoutePage()
class const SpiceChallengePage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => AppInjector.instance.get<SpiceChallengeCubit>()..load(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.challenge;
    final challenge = context.select((SpiceChallengeCubit cubit) => cubit.state.challenge);
    final cubit = context.read<SpiceChallengeCubit>();

    return BaseView(
      appBar: BaseAppBar(title: l10n.title),
      body: BlocListener<SpiceChallengeCubit, SpiceChallengeState>(
        listenWhen: (previous, current) => previous.actAction != current.actAction,
        listener: (context, state) {
          if (state.actAction case Failure(:final exception)) {
            BaseToast.show(context, l10n.errors.selectOrFallback(exception.l10nKey));
          }
        },
        child: SkeletonizerResourceWidget<SpiceChallenge?>(
          challenge,
          fakeValue: const SpiceChallenge(
            text: 'Uma noite sem telas',
            acceptedByMe: false,
            doneByMe: false,
            acceptedByPartner: false,
            swapsLeft: 3,
          ),
          successBuilder: (value) => value == null
              ? BaseStackedContent(
                  body: BaseEmptyState(title: l10n.emptyTitle, text: l10n.emptyText),
                )
              : _Challenge(challenge: value),
          failureBuilder: (exception) => AppErrorView(exception: exception, onRetry: cubit.load),
        ),
      ),
    );
  }
}

class const _Challenge({required final SpiceChallenge challenge}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.spice.challenge;
    final cubit = context.read<SpiceChallengeCubit>();
    final isLoading = context.select(
      (SpiceChallengeCubit cubit) => cubit.state.actAction.isLoading,
    );
    final status = challenge.doneByMe
        ? l10n.statusDone
        : challenge.acceptedByMe
        ? (challenge.acceptedByPartner ? l10n.statusBothAccepted : l10n.statusWaitingPartner)
        : (challenge.acceptedByPartner ? l10n.statusPartnerAccepted : l10n.statusNew);

    return BaseStackedContent(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.subtitle,
            style: context.text.body.copyWith(color: context.colors.textSecondary),
          ),
          const SizedBox(height: AppSpace.s20),
          BaseSurfaceCard(
            style: .ring,
            padding: const EdgeInsets.all(AppSpace.s20),
            child: Text(challenge.text, style: context.text.titleLg),
          ),
          const SizedBox(height: AppSpace.s12),
          Text(status, style: context.text.caption.copyWith(color: context.colors.textSecondary)),
        ],
      ),
      footer: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!challenge.acceptedByMe)
            BaseButton(
              text: l10n.accept,
              isLoading: isLoading,
              onPressed: () => cubit.act(SpiceChallengeAction.accept),
            )
          else if (!challenge.doneByMe)
            BaseButton(
              text: l10n.done,
              isLoading: isLoading,
              onPressed: () => cubit.act(SpiceChallengeAction.done),
            ),
          if (!challenge.doneByMe && challenge.swapsLeft > 0) ...[
            const SizedBox(height: AppSpace.s10),
            BaseButton(
              text: l10n.swap,
              variant: .secondary,
              onPressed: () => cubit.act(SpiceChallengeAction.swap),
            ),
          ],
        ],
      ),
    );
  }
}
