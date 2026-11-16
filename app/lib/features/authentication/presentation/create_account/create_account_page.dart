import 'package:app/features/authentication/presentation/sign_in/cubit/sign_in_cubit.dart';
import 'package:app/features/authentication/presentation/sign_in/widgets/legal_footer.dart';
import 'package:app/features/authentication/presentation/sign_in/widgets/provider_buttons.dart';
import 'package:app/features/slips/data/repositories/slip_repository.dart';
import 'package:app/l10n/l10n_map_extension.dart';
import 'package:app/l10n/translations.g.dart';
import 'package:app/router/app_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:core/core.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class const CreateAccountPage({super.key}) extends StatelessWidget implements AutoRouteWrapper {
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => AppInjector.instance.get<SignInCubit>(), child: this);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n.createAccount;
    final hasSlip = AppInjector.instance.get<SlipRepository>().pendingCount > 0;

    return BaseView(
      appBar: BaseAppBar(title: l10n.title, onBack: () => context.router.maybePop()),
      body: BlocListener<SignInCubit, SignInState>(
        listenWhen: (previous, current) => previous.signInAction != current.signInAction,
        listener: _onStateChanged,
        child: BaseStackedContent(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                header: true,
                child: AppHighlightedText(
                  text: l10n.headline,
                  highlight: l10n.headlineHighlight,
                  style: context.text.titleXl,
                ),
              ),
              const SizedBox(height: AppSpace.s8),
              Text(
                hasSlip ? l10n.subtitleWithSlip : l10n.subtitleWithoutSlip,
                style: context.text.body.copyWith(color: context.colors.textSecondary),
              ),
              const SizedBox(height: AppSpace.s28),
              ProviderButtons(onEmailSignIn: () => context.pushRoute(const DebugSignInRoute())),
              const SizedBox(height: AppSpace.s16),
              const LegalFooter(),
            ],
          ),
        ),
      ),
    );
  }

  void _onStateChanged(BuildContext context, SignInState state) {
    final l10n = context.l10n.authentication;

    if (state.signInAction case Failure(:final exception)) {
      if (existingAccountCodes.contains(exception.l10nKey)) {
        context.router.replace(const ExistingAccountRoute());
        return;
      }
      BaseToast.show(
        context,
        l10n.errors.selectOrFallback(exception.l10nKey),
        variant: BaseToastVariant.error,
        actionLabel: l10n.tryAgain,
        onAction: context.read<SignInCubit>().retry,
      );
    }
  }
}
